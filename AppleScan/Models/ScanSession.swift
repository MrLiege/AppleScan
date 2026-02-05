//
//  ScanSession.swift
//  AppleScan
//
//  Created by Artyom on 03.02.2026.
//

import Foundation

struct ScanSession: Identifiable, Hashable {
    let id = UUID()
    let date: Date
    let bluetoothDevices: [BluetoothDevice]
    let lanDevices: [LanDevice]
}
