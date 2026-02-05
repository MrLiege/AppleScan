//
//  ScanRoute.swift
//  AppleScan
//
//  Created by Artyom on 04.02.2026.
//

import Foundation

enum ScanRoute: Hashable {
    case bluetoothDetails(BluetoothDevice)
    case lanDetails(LanDevice)
}
