//
//  HistorySessionRow.swift
//  AppleScan
//
//  Created by Artyom on 04.02.2026.
//

import SwiftUI

struct HistorySessionRow: View {
    let session: ScanSession

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(session.date.formatted(date: .abbreviated, time: .shortened))
                .font(.headline)

            Text("Bluetooth: \(session.bluetoothDevices.count), LAN: \(session.lanDevices.count)")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }
}
