//
//  LanRow.swift
//  AppleScan
//
//  Created by Artyom on 05.02.2026.
//

import SwiftUI

struct LanRow: View {
    let device: LanDevice

    var body: some View {
        NavigationLink(
            destination: LanDeviceDetailsView(device: device)
        ) {
            VStack(alignment: .leading, spacing: 4) {
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
            .padding(.vertical, 4)
        }
    }
}
