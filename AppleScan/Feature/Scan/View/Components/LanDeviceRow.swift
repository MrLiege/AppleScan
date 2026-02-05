//
//  LanDeviceRow.swift
//  AppleScan
//
//  Created by Artyom on 03.02.2026.
//

import SwiftUI

struct LanDeviceRow: View {
    let device: LanDevice

    var body: some View {
        VStack(alignment: .leading) {
            Text(device.hostname ?? "Неизвестное устройство")
                .font(.headline)
            Text("IP: \(device.ip)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            if let mac = device.mac {
                Text("MAC: \(mac)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}
