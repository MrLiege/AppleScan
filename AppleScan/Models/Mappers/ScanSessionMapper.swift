//
//  ScanSessionMapper.swift
//  AppleScan
//
//  Created by Artyom on 03.02.2026.
//

import Foundation
import RealmSwift

struct ScanSessionMapper {

    static func toRealm(_ session: ScanSession) -> RealmScanSession {
        let obj = RealmScanSession()
        obj.date = session.date

        let bt = session.bluetoothDevices.map { BluetoothDeviceMapper.toRealm($0) }
        let lan = session.lanDevices.map { LanDeviceMapper.toRealm($0) }

        obj.bluetoothDevices.append(objectsIn: bt)
        obj.lanDevices.append(objectsIn: lan)

        return obj
    }

    static func fromRealm(_ obj: RealmScanSession) -> ScanSession {
        ScanSession(
            date: obj.date,
            bluetoothDevices: obj.bluetoothDevices.map { BluetoothDeviceMapper.fromRealm($0) },
            lanDevices: obj.lanDevices.map { LanDeviceMapper.fromRealm($0) }
        )
    }
}
