//
//  LanDeviceDetailsViewModel.swift
//  AppleScan
//
//  Created by Artyom on 04.02.2026.
//

import Combine

final class LanDeviceDetailsViewModel: ObservableObject {

    @Published private(set) var device: LanDevice

    init(device: LanDevice) {
        self.device = device
    }

    var hostname: String {
        device.hostname ?? "Неизвестное устройство"
    }

    var ip: String {
        device.ip
    }

    var mac: String {
        device.mac ?? "Неизвестно"
    }
}
