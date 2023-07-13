use anyhow::Result;
use serde::Serialize;
use std::io::Read;
use std::process::Command;
use std::process::Stdio;

#[derive(Debug)]
enum ReportItem {
    FocusedMonitor(String),
    UnfocusedMonitor(String),
    OccupiedFocusedDesktop(String),
    OccupiedUnfocusedDesktop(String),
    FreeFocusedDesktop(String),
    FreeUnfocusedDesktop(String),
    UrgentFocusedDesktop(String),
    UrgentUnfocusedDesktop(String),
    LayoutOfFocusedDesktop(String),
    StateOfFocusedNode(String),
    ActiveFlagsOfFocuesdNode(String),
}

#[derive(Debug, Serialize)]
struct Desktop {
    name: String,
    is_focused: bool,
    is_urgent: bool,
}

impl Desktop {
    fn new_focused(name: String) -> Desktop {
        Desktop {
            name,
            is_focused: true,
            is_urgent: false,
        }
    }
    fn new_unfocused(name: String) -> Desktop {
        Desktop {
            name,
            is_focused: false,
            is_urgent: false,
        }
    }
    fn mark_as_urgent(mut self) -> Self {
        self.is_urgent = true;
        self
    }
}

#[derive(Debug, Serialize)]
struct Monitor {
    name: String,
    is_focused: bool,
    #[serde(skip)]
    free_and_unfocused_and_unurgent_desktop: Vec<Desktop>,
    #[serde(rename = "desktops")]
    occupied_or_focused_or_urgent_desktop: Vec<Desktop>,
}

impl Monitor {
    fn new_focused(name: String) -> Monitor {
        Monitor {
            name,
            is_focused: true,
            occupied_or_focused_or_urgent_desktop: vec![],
            free_and_unfocused_and_unurgent_desktop: vec![],
        }
    }
    fn new_unfocused(name: String) -> Monitor {
        Monitor {
            name,
            is_focused: false,
            occupied_or_focused_or_urgent_desktop: vec![],
            free_and_unfocused_and_unurgent_desktop: vec![],
        }
    }
    fn push_occupied_focused_desktop(&mut self, desktop_name: String) {
        self.occupied_or_focused_or_urgent_desktop
            .push(Desktop::new_focused(desktop_name))
    }
    fn push_occupied_unfocused_desktop(&mut self, desktop_name: String) {
        self.occupied_or_focused_or_urgent_desktop
            .push(Desktop::new_unfocused(desktop_name));
    }

    fn push_free_focused_desktop(&mut self, desktop_name: String) {
        self.occupied_or_focused_or_urgent_desktop
            .push(Desktop::new_focused(desktop_name));
    }

    fn push_free_unfocused_desktop(&mut self, desktop_name: String) {
        self.free_and_unfocused_and_unurgent_desktop
            .push(Desktop::new_unfocused(desktop_name));
    }

    fn push_urgent_focused_desktop(&mut self, desktop_name: String) {
        self.occupied_or_focused_or_urgent_desktop
            .push(Desktop::new_focused(desktop_name).mark_as_urgent());
    }

    fn push_urgent_unfocused_desktop(&mut self, desktop_name: String) {
        self.occupied_or_focused_or_urgent_desktop
            .push(Desktop::new_unfocused(desktop_name).mark_as_urgent());
    }
}

fn main() -> Result<()> {
    let mut bspc = Command::new("bspc")
        .args(["subscribe", "report"])
        .stdout(Stdio::piped())
        .spawn()?
        .stdout
        .unwrap();

    loop {
        let mut buf = [0u8; 4096];
        let ammount_read = bspc.read(&mut buf)?;
        let line = String::from_utf8(buf[..ammount_read].to_vec())?;
        line.split('W').for_each(|line| {
            let line = line.trim();
            if line.is_empty() {
                return;
            }

            let mut monitors: Vec<Monitor> = vec![];
            line.split(':')
                .map(|section| {
                    let mut chars = section.chars();

                    match chars.next().unwrap() {
                        'M' => ReportItem::FocusedMonitor(chars.collect()),
                        'm' => ReportItem::UnfocusedMonitor(chars.collect()),
                        'O' => ReportItem::OccupiedFocusedDesktop(chars.collect()),
                        'o' => ReportItem::OccupiedUnfocusedDesktop(chars.collect()),
                        'F' => ReportItem::FreeFocusedDesktop(chars.collect()),
                        'f' => ReportItem::FreeUnfocusedDesktop(chars.collect()),
                        'U' => ReportItem::UrgentFocusedDesktop(chars.collect()),
                        'u' => ReportItem::UrgentUnfocusedDesktop(chars.collect()),
                        'L' => ReportItem::LayoutOfFocusedDesktop(chars.collect()),
                        'T' => ReportItem::StateOfFocusedNode(chars.collect()),
                        'G' => ReportItem::ActiveFlagsOfFocuesdNode(chars.collect()),
                        _ => panic!("Unknown format report item"),
                    }
                })
                .map(|report_item| match report_item {
                    ReportItem::FocusedMonitor(name) => monitors.push(Monitor::new_focused(name)),
                    ReportItem::UnfocusedMonitor(name) => {
                        monitors.push(Monitor::new_unfocused(name))
                    }
                    ReportItem::OccupiedFocusedDesktop(name) => monitors
                        .last_mut()
                        .unwrap()
                        .push_occupied_focused_desktop(name),
                    ReportItem::OccupiedUnfocusedDesktop(name) => monitors
                        .last_mut()
                        .unwrap()
                        .push_occupied_unfocused_desktop(name),

                    ReportItem::FreeFocusedDesktop(name) => {
                        monitors.last_mut().unwrap().push_free_focused_desktop(name)
                    }
                    ReportItem::FreeUnfocusedDesktop(name) => monitors
                        .last_mut()
                        .unwrap()
                        .push_free_unfocused_desktop(name),
                    ReportItem::UrgentFocusedDesktop(name) => monitors
                        .last_mut()
                        .unwrap()
                        .push_urgent_focused_desktop(name),
                    ReportItem::UrgentUnfocusedDesktop(name) => monitors
                        .last_mut()
                        .unwrap()
                        .push_urgent_unfocused_desktop(name),
                    ReportItem::LayoutOfFocusedDesktop(_) => {}
                    ReportItem::StateOfFocusedNode(_) => {}
                    ReportItem::ActiveFlagsOfFocuesdNode(_) => {}
                })
                .count();

            println!("{}", serde_json::to_string(&monitors).unwrap());
        });
    }
}
