pragma Singleton
import Quickshell
import Quickshell.Services.UPower
import QtQuick

Singleton {
    id: root
    property bool charging: !UPower.onBattery
    property int percentage: UPower.displayDevice.percentage * 100
    property string timeTo: formatSecondsToString(charging ? UPower.displayDevice.timeToFull : UPower.displayDevice.timeToEmpty)

    function formatSecondsToString(n) {
        let h = Math.floor(n / 3600);
        let m = Math.floor((n % 3600) / 60);

        let result = "";
        if (h > 0)
            result += h + "h ";
        if (m > 0 || h === 0)
            result += m + "m";

        return result.trim();
    }
}
