//
//  RealmLanDevice.swift
//  AppleScan
//
//  Created by Artyom on 03.02.2026.
//

import Foundation
import RealmSwift

class RealmLanDevice: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var ip: String
    @Persisted var mac: String?
    @Persisted var hostname: String?
}
