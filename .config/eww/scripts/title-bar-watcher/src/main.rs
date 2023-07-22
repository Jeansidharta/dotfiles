use anyhow::Result;
use breadx::{display::DisplayConnection, prelude::*, protocol::xproto};

fn main() -> Result<()> {
    let mut connection = DisplayConnection::connect(None)?;

    loop {
        let event = connection.wait_for_event()?;

        dbg!(&event);

        // match event {
        //     breadx::protocol::Event::Unknown(_) => todo!(),
        //     breadx::protocol::Event::Error(_) => todo!(),
        //     breadx::protocol::Event::ButtonPress(_) => todo!(),
        //     breadx::protocol::Event::ButtonRelease(_) => todo!(),
        //     breadx::protocol::Event::CirculateNotify(_) => todo!(),
        //     breadx::protocol::Event::CirculateRequest(_) => todo!(),
        //     breadx::protocol::Event::ClientMessage(_) => todo!(),
        //     breadx::protocol::Event::ColormapNotify(_) => todo!(),
        //     breadx::protocol::Event::ConfigureNotify(_) => todo!(),
        //     breadx::protocol::Event::ConfigureRequest(_) => todo!(),
        //     breadx::protocol::Event::CreateNotify(_) => todo!(),
        //     breadx::protocol::Event::DestroyNotify(_) => todo!(),
        //     breadx::protocol::Event::EnterNotify(_) => todo!(),
        //     breadx::protocol::Event::Expose(_) => todo!(),
        //     breadx::protocol::Event::FocusIn(_) => todo!(),
        //     breadx::protocol::Event::FocusOut(_) => todo!(),
        //     breadx::protocol::Event::GeGeneric(_) => todo!(),
        //     breadx::protocol::Event::GraphicsExposure(_) => todo!(),
        //     breadx::protocol::Event::GravityNotify(_) => todo!(),
        //     breadx::protocol::Event::KeyPress(_) => todo!(),
        //     breadx::protocol::Event::KeyRelease(_) => todo!(),
        //     breadx::protocol::Event::KeymapNotify(_) => todo!(),
        //     breadx::protocol::Event::LeaveNotify(_) => todo!(),
        //     breadx::protocol::Event::MapNotify(_) => todo!(),
        //     breadx::protocol::Event::MapRequest(_) => todo!(),
        //     breadx::protocol::Event::MappingNotify(_) => todo!(),
        //     breadx::protocol::Event::MotionNotify(_) => todo!(),
        //     breadx::protocol::Event::NoExposure(_) => todo!(),
        //     breadx::protocol::Event::PropertyNotify(_) => todo!(),
        //     breadx::protocol::Event::ReparentNotify(_) => todo!(),
        //     breadx::protocol::Event::ResizeRequest(_) => todo!(),
        //     breadx::protocol::Event::SelectionClear(_) => todo!(),
        //     breadx::protocol::Event::SelectionNotify(_) => todo!(),
        //     breadx::protocol::Event::SelectionRequest(_) => todo!(),
        //     breadx::protocol::Event::UnmapNotify(_) => todo!(),
        //     breadx::protocol::Event::VisibilityNotify(_) => todo!(),
        //     _ => todo!(),
        // }
    }
}
