//
//  BluetoothDeviceDetailsView.swift
//  AppleScan
//
//  Created by Artyom on 04.02.2026.
//

import SwiftUI

struct BluetoothDeviceDetailsView: View {

    @StateObject var viewModel: BluetoothDeviceDetailsViewModel

    init(device: BluetoothDevice) {
        _viewModel = StateObject(wrappedValue: BluetoothDeviceDetailsViewModel(device: device))
    }

    var body: some View {
        List {
            Section("Информация") {
                DetailRow(title: "Имя", value: viewModel.name)
                DetailRow(title: "UUID", value: viewModel.uuid)
                DetailRow(title: "RSSI", value: viewModel.rssi)
                DetailRow(title: "Статус", value: viewModel.state)
            }
        }
        .navigationTitle(viewModel.name)
    }
}
