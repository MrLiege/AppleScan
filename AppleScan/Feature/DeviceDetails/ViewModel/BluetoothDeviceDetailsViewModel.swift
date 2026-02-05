//
//  BluetoothDeviceDetailsViewModel.swift
//  AppleScan
//
//  Created by Artyom on 04.02.2026.
//

import Combine

final class BluetoothDeviceDetailsViewModel: ObservableObject {

    @Published private(set) var device: BluetoothDevice

    init(device: BluetoothDevice) {
        self.device = device
    }

    var name: String {
        device.name ?? "Неизвестное устройство"
    }

    var uuid: String {
        device.uuid
    }

    var rssi: String {
        "\(device.rssi)"
    }

    var state: String {
        device.state
    }
}
