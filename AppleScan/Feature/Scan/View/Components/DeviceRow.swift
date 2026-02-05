//
//  DeviceRow.swift
//  AppleScan
//
//  Created by Artyom on 03.02.2026.
//

import SwiftUI

struct DeviceRow: View {
    let device: BluetoothDevice

    var body: some View {
        VStack(alignment: .leading) {
            Text(device.name ?? "Неизвестное устройство")
                .font(.headline)
            Text("UUID: \(device.uuid)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            Text("RSSI: \(device.rssi)")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}
