//
//  BluetoothRow.swift
//  AppleScan
//
//  Created by Artyom on 05.02.2026.
//

import SwiftUI

struct BluetoothRow: View {
    let device: BluetoothDevice

    var body: some View {
        NavigationLink(
            destination: BluetoothDeviceDetailsView(device: device)
        ) {
            VStack(alignment: .leading, spacing: 4) {
                Text(device.name ?? "Неизвестное устройство")
                    .font(.headline)
                Text("UUID: \(device.uuid)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("RSSI: \(device.rssi)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.vertical, 4)
        }
    }
}
