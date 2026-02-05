//
//  ScanFlowCoordinatorView.swift
//  AppleScan
//
//  Created by Artyom on 04.02.2026.
//

import SwiftUI

struct ScanFlowCoordinatorView: View {

    @ObservedObject var coordinator: ScanFlowCoordinator

    var body: some View {
        NavigationView {
            ScanScreen(
                viewModel: ScanViewModel(
                    bluetoothService: BluetoothService(),
                    lanService: LanScanService(),
                    database: DatabaseService(),
                    coordinator: coordinator
                )
            )
            .background(
                NavigationLink(
                    destination: destinationView(),
                    isActive: Binding(
                        get: { coordinator.route != nil },
                        set: { if !$0 { coordinator.close() } }
                    ),
                    label: { EmptyView() }
                )
                .hidden()
            )
            .navigationTitle("Сканирование")
        }
    }

    @ViewBuilder
    private func destinationView() -> some View {
        switch coordinator.route {
        case .bluetoothDetails(let device):
            BluetoothDeviceDetailsView(device: device)

        case .lanDetails(let device):
            LanDeviceDetailsView(device: device)

        case .none:
            EmptyView()
        }
    }
}
