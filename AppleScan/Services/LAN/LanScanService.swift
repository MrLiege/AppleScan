//
//  LanScanService.swift
//  AppleScan
//
//  Created by Artyom on 03.02.2026.
//

import Foundation
import Combine
import MMLanScan

final class LanScanService: NSObject {

    private var scanner: MMLANScanner?
    private var discovered: [LanDevice] = []

    private let devicesSubject = PassthroughSubject<[LanDevice], Never>()
    var devicesPublisher: AnyPublisher<[LanDevice], Never> {
        devicesSubject.eraseToAnyPublisher()
    }

    private let errorSubject = PassthroughSubject<String, Never>()
    var errorPublisher: AnyPublisher<String, Never> {
        errorSubject.eraseToAnyPublisher()
    }

    private let progressSubject = PassthroughSubject<Double, Never>()
    var progressPublisher: AnyPublisher<Double, Never> {
        progressSubject.eraseToAnyPublisher()
    }

    func startScan() {
        discovered.removeAll()

        scanner = MMLANScanner(delegate: self)
        scanner?.start()
    }

    func stopScan() {
        scanner?.stop()
    }
}

extension LanScanService: MMLANScannerDelegate {

    func lanScanDidFindNewDevice(_ device: MMDevice!) {
        guard let device = device else { return }

        let lanDevice = LanDevice(
            ip: device.ipAddress ?? "",
            mac: device.macAddress,
            hostname: device.hostname
        )

        discovered.append(lanDevice)
        devicesSubject.send(discovered)
    }

    func lanScanDidFinishScanning(with status: MMLanScannerStatus) {
        switch status {
        case MMLanScannerStatusFinished:
            devicesSubject.send(discovered)
        case MMLanScannerStatusCancelled:
            errorSubject.send("Сканирование LAN отменено")
        default:
            errorSubject.send("Неизвестный статус сканирования LAN")
        }
    }

    func lanScanProgressPinged(_ pingedHosts: Float, from overallHosts: Int) {
        guard overallHosts > 0 else { return }
        let progress = Double(pingedHosts / Float(overallHosts))
        progressSubject.send(progress)
    }

    func lanScanDidFailedToScan() {
        errorSubject.send("Не удалось начать сканирование LAN")
    }
}
