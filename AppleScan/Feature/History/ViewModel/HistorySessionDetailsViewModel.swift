//
//  HistorySessionDetailsViewModel.swift
//  AppleScan
//
//  Created by Artyom on 05.02.2026.
//

import Combine

final class HistorySessionDetailsViewModel: ObservableObject {

    let session: ScanSession
    private let coordinator: HistoryFlowCoordinator

    init(session: ScanSession, coordinator: HistoryFlowCoordinator) {
        self.session = session
        self.coordinator = coordinator
    }

    func openBluetoothDetails(_ device: BluetoothDevice) {
        coordinator.showBluetoothDetails(device)
    }

    func openLanDetails(_ device: LanDevice) {
        coordinator.showLanDetails(device)
    }
}
