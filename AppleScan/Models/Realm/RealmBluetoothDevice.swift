//
//  RealmBluetoothDevice.swift
//  AppleScan
//
//  Created by Artyom on 03.02.2026.
//

import Foundation
import RealmSwift

class RealmBluetoothDevice: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String?
    @Persisted var uuid: String
    @Persisted var rssi: Int
    @Persisted var state: String
}
