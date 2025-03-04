import { GLib, Variable, bind } from "astal"
import { App, Astal, Gtk, Gdk } from "astal/gtk4"
import WorkspacesWidget from "./Workspaces"
import Network from "gi://AstalNetwork"
import Battery from "gi://AstalBattery"

function Time({ format = "%H\n%M" }) {
  const time = Variable<string>("").poll(60000, () =>
    GLib.DateTime.new_now_local().format(format)!)

  return <label
    cssClasses={["time"]}
    onDestroy={() => time.drop()}
    label={time()}
  />
}

function BatteryLevel() {
  const bat = Battery.get_default()

  return <box cssClasses={["battery"]} orientation={Gtk.Orientation.VERTICAL}
    visible={bind(bat, "isPresent")}>
    <image
      iconName={bind(bat, "batteryIconName")}
      tooltipText={bind(bat, "percentage").as(p => `${Math.floor(p * 100)} %`)}
    />
  </box>
}

function Wifi() {
  const network = Network.get_default()
  const wifi = bind(network, "wifi")

  return <box orientation={Gtk.Orientation.VERTICAL} visible={wifi.as(Boolean)}>
    {wifi.as(wifi => wifi && (
      <image
        tooltipText={bind(wifi, "ssid").as(String)}
        css_classes={["wifi"]}
        iconName={bind(wifi, "iconName")}
      />
    ))}
  </box>

}

export default function Bar(gdkmonitor: Gdk.Monitor) {
  const { TOP, BOTTOM, LEFT } = Astal.WindowAnchor
  const monitorName = gdkmonitor.get_connector()

  return <window
    visible
    cssClasses={["Bar"]}
    gdkmonitor={gdkmonitor}
    exclusivity={Astal.Exclusivity.EXCLUSIVE}
    anchor={TOP | BOTTOM | LEFT}
    application={App}>
    <box cssClasses={["main-box"]} orientation={Gtk.Orientation.VERTICAL} vexpand={true}>

      {/*<box cssClasses={["top-container"]} orientation={Gtk.Orientation.VERTICAL} valign={Gtk.Align.START}>

      </box>*/}

      <WorkspacesWidget monitor={monitorName} />

      <box cssClasses={["bottom-container"]} orientation={Gtk.Orientation.VERTICAL} valign={Gtk.Align.END}>
        <Wifi />
        <BatteryLevel />
        <Time />
      </box>
    </box>
  </window>
}
