//
//  ScanViewModel.swift
//  AppleScan
//
//  Created by Artyom on 03.02.2026.
//

import Foundation
import Combine

final class ScanViewModel: ObservableObject {

    // MARK: - UI State
    @Published var state: ScanState = .idle
    @Published var progress: Double = 0
    @Published var bluetoothDevices: [BluetoothDevice] = []
    @Published var lanDevices: [LanDevice] = []

    // MARK: - Segmented Control Filter
    enum ScanFilter: String, CaseIterable {
        case all = "Все"
        case bluetooth = "Bluetooth"
        case lan = "LAN"
    }

    @Published var selectedFilter: ScanFilter = .all

    // MARK: - Filtered Lists
    var filteredBluetooth: [BluetoothDevice] {
        selectedFilter == .bluetooth || selectedFilter == .all ? bluetoothDevices : []
    }

    var filteredLan: [LanDevice] {
        selectedFilter == .lan || selectedFilter == .all ? lanDevices : []
    }

    // MARK: - Services
    private let bluetoothService: BluetoothService
    private let lanService: LanScanService
    private let database: DatabaseService
    private let coordinator: ScanFlowCoordinator

    private var cancellables = Set<AnyCancellable>()
    private var timer: AnyCancellable?

    private let scanDuration: TimeInterval = 15

    // MARK: - Init
    init(
        bluetoothService: BluetoothService,
        lanService: LanScanService,
        database: DatabaseService,
        coordinator: ScanFlowCoordinator
    ) {
        self.bluetoothService = bluetoothService
        self.lanService = lanService
        self.database = database
        self.coordinator = coordinator

        bindServices()
    }

    // MARK: - Bind Services
    private func bindServices() {

        bluetoothService.devicesPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] devices in
                self?.bluetoothDevices = devices
            }
            .store(in: &cancellables)

        lanService.devicesPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] devices in
                self?.lanDevices = devices
            }
            .store(in: &cancellables)

        lanService.progressPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] lanProgress in
                guard let self = self else { return }
                self.progress = min(self.progress + lanProgress * 0.5, 1)
            }
            .store(in: &cancellables)

        // Ошибки от сервисов → переводим в state = .error
        bluetoothService.errorPublisher
            .merge(with: lanService.errorPublisher)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                self?.state = .error(error)
            }
            .store(in: &cancellables)
    }

    // MARK: - Scan Control
    func startScan() {
        guard case .idle = state else { return }

        bluetoothDevices.removeAll()
        lanDevices.removeAll()
        progress = 0

        state = .scanning

        bluetoothService.startScan()
        lanService.startScan()

        startTimer()
    }

    private func startTimer() {
        let start = Date()

        timer = Timer.publish(every: 0.1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] now in
                guard let self = self else { return }

                let elapsed = now.timeIntervalSince(start)
                let timeProgress = elapsed / self.scanDuration

                self.progress = max(self.progress, timeProgress)

                if elapsed >= self.scanDuration {
                    self.stopScan()
                }
            }
    }

    func stopScan() {
        timer?.cancel()
        timer = nil

        bluetoothService.stopScan()
        lanService.stopScan()

        saveSession()

        state = .idle
    }

    // MARK: - Retry
    func retryScan() {
        state = .idle
        startScan()
    }

    // MARK: - Save Session
    private func saveSession() {
        database.saveScanSession(
            bluetooth: bluetoothDevices,
            lan: lanDevices
        )
    }

    // MARK: - Coordinator
    func openBluetoothDetails(_ device: BluetoothDevice) {
        coordinator.showBluetoothDetails(device)
    }

    func openLanDetails(_ device: LanDevice) {
        coordinator.showLanDetails(device)
    }
}
