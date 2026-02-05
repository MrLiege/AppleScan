//
//  DatabaseService.swift
//  AppleScan
//
//  Created by Artyom on 03.02.2026.
//

import Foundation
import Combine
import RealmSwift

final class DatabaseService {

    private let realm = try! Realm()
    private var sessionsToken: NotificationToken?

    private let sessionsSubject = CurrentValueSubject<[ScanSession], Never>([])

    var sessionsPublisher: AnyPublisher<[ScanSession], Never> {
        sessionsSubject.eraseToAnyPublisher()
    }

    init() {
        observeSessions()
    }

    private func observeSessions() {
        let results = realm.objects(RealmScanSession.self)
            .sorted(byKeyPath: "date", ascending: false)

        sessionsToken = results.observe { [weak self] changes in
            guard let self else { return }

            switch changes {
            case .initial(let collection),
                 .update(let collection, _, _, _):
                let mapped = Array(collection.map { ScanSessionMapper.fromRealm($0) })
                sessionsSubject.send(mapped)

            case .error:
                break
            }
        }
    }

    func saveScanSession(bluetooth: [BluetoothDevice], lan: [LanDevice]) {
        let session = RealmScanSession()
        session.date = Date()

        let bt = bluetooth.map { BluetoothDeviceMapper.toRealm($0) }
        let ln = lan.map { LanDeviceMapper.toRealm($0) }

        session.bluetoothDevices.append(objectsIn: bt)
        session.lanDevices.append(objectsIn: ln)

        try? realm.write {
            realm.add(session)
        }
    }
}
