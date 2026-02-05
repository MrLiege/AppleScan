//
//  ScanFlowCoordinator.swift
//  AppleScan
//
//  Created by Artyom on 04.02.2026.
//

import Combine
import SwiftUI

final class ScanFlowCoordinator: ObservableObject {

    @Published var route: ScanRoute?

    func showBluetoothDetails(_ device: BluetoothDevice) {
        route = .bluetoothDetails(device)
    }

    func showLanDetails(_ device: LanDevice) {
        route = .lanDetails(device)
    }

    func close() {
        route = nil
    }
}
