pragma Singleton
import Quickshell
import QtQuick

Singleton {
    id: root

    readonly property string timeFormat: "hh\nmm"
    readonly property string time: {
        Qt.formatDateTime(clock.date, timeFormat);
    }

    readonly property string dateFormat: "dddd, dd MMMM yyyy"
    readonly property string date: {
        Qt.formatDateTime(clock.date, dateFormat);
    }

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}
