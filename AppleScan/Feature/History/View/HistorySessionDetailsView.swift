//
//  HistorySessionDetailsView.swift
//  AppleScan
//
//  Created by Artyom on 04.02.2026.
//

import SwiftUI

struct HistorySessionDetailsView: View {

    @State private var searchText = ""
    let session: ScanSession

    var body: some View {
        List {
            searchHeader

            infoSection

            bluetoothSection

            lanSection
        }
        .navigationTitle("Сессия")
    }
}

private extension HistorySessionDetailsView {

    var searchHeader: some View {
        SearchBar(text: $searchText)
    }

    var infoSection: some View {
        Section("Информация") {
            DetailRow(
                title: "Дата",
                value: session.date.formatted(date: .abbreviated, time: .shortened)
            )
            DetailRow(title: "Bluetooth устройств", value: "\(session.bluetoothDevices.count)")
            DetailRow(title: "LAN устройств", value: "\(session.lanDevices.count)")
        }
    }

    var bluetoothSection: some View {
        Group {
            if !filteredBluetooth.isEmpty {
                Section("Bluetooth устройства") {
                    ForEach(filteredBluetooth) { device in
                        BluetoothRow(device: device)
                    }
                }
            }
        }
    }

    var lanSection: some View {
        Group {
            if !filteredLan.isEmpty {
                Section("LAN устройства") {
                    ForEach(filteredLan) { device in
                        LanRow(device: device)
                    }
                }
            }
        }
    }
}

private extension HistorySessionDetailsView {

    var filteredBluetooth: [BluetoothDevice] {
        guard !searchText.isEmpty else { return session.bluetoothDevices }
        let text = searchText.lowercased()
        return session.bluetoothDevices.filter {
            ($0.name ?? "").lowercased().contains(text)
        }
    }

    var filteredLan: [LanDevice] {
        guard !searchText.isEmpty else { return session.lanDevices }
        let text = searchText.lowercased()
        return session.lanDevices.filter {
            ($0.hostname ?? "").lowercased().contains(text)
        }
    }
}
