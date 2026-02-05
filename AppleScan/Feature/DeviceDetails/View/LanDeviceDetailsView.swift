//
//  LanDeviceDetailsView.swift
//  AppleScan
//
//  Created by Artyom on 04.02.2026.
//

import SwiftUI

struct LanDeviceDetailsView: View {

    @StateObject var viewModel: LanDeviceDetailsViewModel

    init(device: LanDevice) {
        _viewModel = StateObject(wrappedValue: LanDeviceDetailsViewModel(device: device))
    }

    var body: some View {
        List {
            Section("Информация") {
                DetailRow(title: "Hostname", value: viewModel.hostname)
                DetailRow(title: "IP", value: viewModel.ip)
                DetailRow(title: "MAC", value: viewModel.mac)
            }
        }
        .navigationTitle(viewModel.hostname)
    }
}
