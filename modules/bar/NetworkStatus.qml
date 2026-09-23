import qs.components
import qs.config
import qs.services

// Wi-Fi icon follows signal strength (same thresholds as nmcli bars)
Icon {
    readonly property int bars: {
        const s = Network.strength * 100
        return s > 80 ? 4 : s > 55 ? 3 : s > 30 ? 2 : s > 5 ? 1 : 0
    }

    color: Theme.primary
    text: !Network.connected ? "signal_wifi_off"
        : !Network.wifi ? "lan"
        : ["signal_wifi_0_bar", "network_wifi_1_bar", "network_wifi_2_bar", "network_wifi_3_bar", "signal_wifi_4_bar"][bars]
}
