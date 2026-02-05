//
//  ScanScreen.swift
//  AppleScan
//
//  Created by Artyom on 03.02.2026.
//

import SwiftUI

struct ScanScreen: View {

    @StateObject private var viewModel: ScanViewModel

    init(viewModel: ScanViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            content

            if case .scanning = viewModel.state {
                LoadingOverlay(progress: viewModel.progress)
            }
        }
    }
}

private extension ScanScreen {

    @ViewBuilder
    var content: some View {
        switch viewModel.state {

        case .idle:
            idleView

        case .scanning:
            idleView.opacity(0.3)

        case .error(let message):
            errorView(message)
        }
    }
}

private extension ScanScreen {

    var idleView: some View {
        VStack(spacing: 24) {
            deviceFilterPicker
            startScanButton
            if isEmptyState {
                emptyStateView
            } else {
                devicesList
            }
        }
    }
}

private extension ScanScreen {

    var deviceFilterPicker: some View {
        Picker("Тип устройств", selection: $viewModel.selectedFilter) {
            ForEach(ScanViewModel.ScanFilter.allCases, id: \.self) { filter in
                Text(filter.rawValue).tag(filter)
            }
        }
        .pickerStyle(.segmented)
        .padding(.horizontal)
    }

    var startScanButton: some View {
        Button(action: viewModel.startScan) {
            Text("Начать сканирование")
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)
        }
        .padding(.horizontal)
    }

    var devicesList: some View {
        List {
            bluetoothSection
            lanSection
        }
    }
}

private extension ScanScreen {

    var bluetoothSection: some View {
        Group {
            if !viewModel.filteredBluetooth.isEmpty {
                Section("Bluetooth устройства") {
                    ForEach(viewModel.filteredBluetooth) { device in
                        Button(
                            action: { viewModel.openBluetoothDetails(device) },
                            label: { DeviceRow(device: device) }
                        )
                    }
                }
            }
        }
    }

    var lanSection: some View {
        Group {
            if !viewModel.filteredLan.isEmpty {
                Section("LAN устройства") {
                    ForEach(viewModel.filteredLan) { device in
                        Button(
                            action: { viewModel.openLanDetails(device) },
                            label: { LanDeviceRow(device: device) }
                        )
                    }
                }
            }
        }
    }
}

private extension ScanScreen {
    var isEmptyState: Bool {
        viewModel.filteredBluetooth.isEmpty && viewModel.filteredLan.isEmpty
    }
    
    var emptyStateView: some View {
        VStack(spacing: 12) {
            LottieView(name: "broom", loop: true)
                .frame(height: 180)
            
            Text("Нет устройств")
                .foregroundColor(.secondary)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.top, 40)
    }
}

private extension ScanScreen {

    func errorView(_ message: String) -> some View {
        VStack(spacing: 24) {
            Spacer()

            LottieView(name: "error", loop: false)
                .frame(width: 220, height: 220)

            Text(message)
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Spacer()

            Button(action: viewModel.retryScan) {
                Text("Повторить")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .padding(.horizontal)
            .padding(.vertical)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
