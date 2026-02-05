//
//  DatabaseService.swift
//  AppleScan
//
//  Created by Artyom on 03.02.2026.
//

import Foundation
import RealmSwift

final class DatabaseService {

    private let realm = try! Realm()

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

    func fetchSessions() -> [ScanSession] {
        let objects = realm.objects(RealmScanSession.self)
        return objects.map { ScanSessionMapper.fromRealm($0) }
    }

    func fetchSession(by id: ObjectId) -> ScanSession? {
        guard let obj = realm.object(ofType: RealmScanSession.self, forPrimaryKey: id) else {
            return nil
        }
        return ScanSessionMapper.fromRealm(obj)
    }

    func filterSessions(name: String?, date: Date?) -> [ScanSession] {
        var predicate = NSPredicate(value: true)

        if let name = name, !name.isEmpty {
            predicate = NSPredicate(format: "ANY bluetoothDevices.name CONTAINS[c] %@ OR ANY lanDevices.hostname CONTAINS[c] %@", name, name)
        }

        let results = realm.objects(RealmScanSession.self).filter(predicate)

        return results.map { ScanSessionMapper.fromRealm($0) }
    }
}
