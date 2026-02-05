//
//  HistoryFlowCoordinator.swift
//  AppleScan
//
//  Created by Artyom on 04.02.2026.
//

import Combine
import SwiftUI

final class HistoryFlowCoordinator: ObservableObject {

    @Published var route: HistoryRoute?

    func showSessionDetails(_ session: ScanSession) {
        route = .sessionDetails(session)
    }

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
