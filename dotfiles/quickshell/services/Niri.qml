pragma Singleton
import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    property var workspaces: []
    property int focusedId: 0
    property bool overviewOpen: false

    Process {
        id: niriWorker
    }

    Process {
        id: niriEventStream
        command: ["niri", "msg", "--json", "event-stream"]
        running: true

        stdout: SplitParser {
            onRead: data => {
                const event = JSON.parse(data);
                if (event.WorkspacesChanged) {
                    root.workspaces = event.WorkspacesChanged.workspaces.sort((a, b) => a.idx - b.idx);
                    root.focusedId = event.WorkspacesChanged.workspaces.filter(ws => ws.is_focused)[0].id;
                }
                if (event.WorkspaceActivated)
                    root.focusedId = event.WorkspaceActivated.id;
            }
        }
    }

    function focusWorkspace(idx): void {
        niriWorker.command = ["niri", "msg", "action", "focus-workspace", `${idx}`];
        niriWorker.running = true;
    }

    function focusWorkspaceRelative(direction): void {
        if (direction > 0)
            niriWorker.command = ["niri", "msg", "action", "focus-workspace-up"];
        else
            niriWorker.command = ["niri", "msg", "action", "focus-workspace-down"];

        niriWorker.running = true;
    }
}
