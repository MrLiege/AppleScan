//
//  BluetoothService.swift
//  AppleScan
//
//  Created by Artyom on 03.02.2026.
//

import Foundation
import CoreBluetooth
import Combine

final class BluetoothService: NSObject, ObservableObject {

    private var centralManager: CBCentralManager!
    private var discoveredDevices: [String: BluetoothDevice] = [:]

    private let devicesSubject = PassthroughSubject<[BluetoothDevice], Never>()
    var devicesPublisher: AnyPublisher<[BluetoothDevice], Never> {
        devicesSubject.eraseToAnyPublisher()
    }

    private let errorSubject = PassthroughSubject<String, Never>()
    var errorPublisher: AnyPublisher<String, Never> {
        errorSubject.eraseToAnyPublisher()
    }

    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: .main)
    }

    func startScan() {
        guard centralManager.state == .poweredOn else {
            errorSubject.send("Bluetooth выключен или недоступен")
            return
        }

        discoveredDevices.removeAll()

        centralManager.scanForPeripherals(
            withServices: nil,
            options: [CBCentralManagerScanOptionAllowDuplicatesKey: false]
        )
    }

    func stopScan() {
        centralManager.stopScan()
    }
}

extension BluetoothService: CBCentralManagerDelegate {

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            break
        case .poweredOff:
            errorSubject.send("Bluetooth выключен")
        case .unauthorized:
            errorSubject.send("Нет разрешения на использование Bluetooth")
        case .unsupported:
            errorSubject.send("Bluetooth не поддерживается устройством")
        default:
            errorSubject.send("Неизвестная ошибка Bluetooth")
        }
    }

    func centralManager(
        _ central: CBCentralManager,
        didDiscover peripheral: CBPeripheral,
        advertisementData: [String : Any],
        rssi RSSI: NSNumber
    ) {
        let device = BluetoothDevice(
            name: peripheral.name,
            uuid: peripheral.identifier.uuidString,
            rssi: RSSI.intValue,
            state: peripheral.state.description
        )

        discoveredDevices[device.uuid] = device
        devicesSubject.send(Array(discoveredDevices.values))
    }
}

extension CBPeripheralState {
    var description: String {
        switch self {
        case .connected: return "Подключено"
        case .connecting: return "Подключение…"
        case .disconnected: return "Отключено"
        case .disconnecting: return "Отключение…"
        @unknown default: return "Неизвестно"
        }
    }
}
