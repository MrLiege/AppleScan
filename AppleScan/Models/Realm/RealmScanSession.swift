//
//  RealmScanSession.swift
//  AppleScan
//
//  Created by Artyom on 03.02.2026.
//

import Foundation
import RealmSwift

class RealmScanSession: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var date: Date

    @Persisted var bluetoothDevices = List<RealmBluetoothDevice>()
    @Persisted var lanDevices = List<RealmLanDevice>()
}
