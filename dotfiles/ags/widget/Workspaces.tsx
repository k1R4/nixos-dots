import { Gtk } from "astal/gtk4"
import { Variable, bind } from "astal"

const workspacesCmdOut = Variable("").poll(100, ["niri", "msg", "--json", "workspaces"], (out, _) => String(out))
const workspaces: Variable<Array<any>> = Variable.derive(
  [workspacesCmdOut],
  (workspacesCmdOut: string) => {
    if (workspacesCmdOut) {
      return JSON.parse(workspacesCmdOut).sort((a: any, b: any) => { return a.idx - b.idx })
    }
    else return []
  }
)

function WorkspacesWidget({ monitor }: { monitor: string | null }) {
  return (
    <box cssClasses={["workspaces-container"]} orientation={Gtk.Orientation.VERTICAL} valign={Gtk.Align.CENTER} vexpand={true}>
      {bind(workspaces).as((ws: Array<any>) => {
        var elements = []

        for (var i = 0; i < ws.length; i++) {

          if (ws[i].output != monitor) continue
          const isActive = ws[i].is_active

          elements.push(
            <button
              hexpand={false}
              vexpand={false}
              onClicked={`niri msg action focus-workspace ${ws[i].idx}`}
              cssClasses={isActive ? ["workspace-button", "active"] : ["workspace-button"]}
            ></button>
          )
        }
        return elements
      })}
    </box>
  )
}

export default WorkspacesWidget
