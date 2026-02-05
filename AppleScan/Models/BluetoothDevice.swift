//
//  BluetoothDevice.swift
//  AppleScan
//
//  Created by Artyom on 03.02.2026.
//

import Foundation

struct BluetoothDevice: Identifiable, Hashable {
    let id = UUID()
    let name: String?
    let uuid: String
    let rssi: Int
    let state: String
}
