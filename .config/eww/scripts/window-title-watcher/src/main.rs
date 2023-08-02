use anyhow::Result;
use xcb::x::{Atom, EventMask, Window};

fn get_window_title(
    conn: &xcb::Connection,
    window: Window,
    net_wm_name_atom: Atom,
    utf8_string_atom: Atom,
) -> Result<String> {
    let window_title = {
        let reply = conn.wait_for_reply(conn.send_request(&xcb::x::GetProperty {
            delete: false,
            window,
            property: net_wm_name_atom,
            // r#type: utf8_string_atom,
            r#type: utf8_string_atom,
            long_offset: 0,
            long_length: std::u32::MAX,
        }))?;
        String::from_utf8(reply.value().to_vec())?
    };
    Ok(window_title)
}

fn handle_active_window_change(
    conn: &xcb::Connection,
    root_window: Window,
    net_active_window_atom: Atom,
    net_wm_name_atom: Atom,
    utf8_string_atom: Atom,
) -> Result<Option<Window>> {
    let net_active_window = {
        let reply = conn.wait_for_reply(conn.send_request(&xcb::x::GetProperty {
            delete: false,
            window: root_window,
            property: net_active_window_atom,
            r#type: xcb::x::ATOM_WINDOW,
            long_offset: 0,
            long_length: std::u32::MAX,
        }))?;
        reply.value::<xcb::x::Window>().get(0).cloned()
    };
    let net_active_window = match net_active_window {
        Some(w) => w,
        None => return Ok(None),
    };
    let window_title =
        get_window_title(conn, net_active_window, net_wm_name_atom, utf8_string_atom)?;
    println!("{window_title}");

    Ok(Some(net_active_window))
}
fn subscribe_property_events_to_window(conn: &xcb::Connection, window: Window) -> Result<()> {
    let mut event_mask = xcb::x::EventMask::empty();
    event_mask.set(xcb::x::EventMask::PROPERTY_CHANGE, true);
    conn.send_and_check_request(&xcb::x::ChangeWindowAttributes {
        window,
        value_list: &[xcb::x::Cw::EventMask(event_mask)],
    })?;
    Ok(())
}

fn unsubscribe_events_from_window(conn: &xcb::Connection, window: Window) -> Result<()> {
    conn.send_and_check_request(&xcb::x::ChangeWindowAttributes {
        window,
        value_list: &[xcb::x::Cw::EventMask(EventMask::empty())],
    })?;
    Ok(())
}

fn main() -> Result<()> {
    let (conn, screen_num) = xcb::Connection::connect(None)?;
    let setup = conn.get_setup();
    let zero_screen = setup.roots().nth(screen_num as usize).unwrap();
    let root_window = zero_screen.root();

    subscribe_property_events_to_window(&conn, root_window)?;

    let net_active_window_atom = conn
        .wait_for_reply(conn.send_request(&xcb::x::InternAtom {
            only_if_exists: true,
            name: b"_NET_ACTIVE_WINDOW",
        }))?
        .atom();

    let net_wm_name_atom = conn
        .wait_for_reply(conn.send_request(&xcb::x::InternAtom {
            only_if_exists: true,
            name: b"_NET_WM_NAME",
        }))?
        .atom();

    let utf8_string_atom = conn
        .wait_for_reply(conn.send_request(&xcb::x::InternAtom {
            only_if_exists: true,
            name: b"UTF8_STRING",
        }))?
        .atom();

    let mut last_active_screen: Option<Window> = None;

    loop {
        let event = conn.wait_for_event()?;

        if let xcb::Event::X(xcb::x::Event::PropertyNotify(property_notify_event)) = event {
            if property_notify_event.atom() == net_active_window_atom {
                if let Some(win) = last_active_screen {
                    unsubscribe_events_from_window(&conn, win)?;
                }
                let active_window = handle_active_window_change(
                    &conn,
                    root_window,
                    net_active_window_atom,
                    net_wm_name_atom,
                    utf8_string_atom,
                )?;
                if let Some(win) = active_window {
                    subscribe_property_events_to_window(&conn, win)?;
                }
                last_active_screen = active_window;
            } else if property_notify_event.atom() == net_wm_name_atom {
                let new_title = get_window_title(
                    &conn,
                    property_notify_event.window(),
                    net_wm_name_atom,
                    utf8_string_atom,
                )?;
                println!("{new_title}");
            }
        }
    }
}
