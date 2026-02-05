//
//  LanDeviceMapper.swift
//  AppleScan
//
//  Created by Artyom on 03.02.2026.
//

import Foundation

struct LanDeviceMapper {

    static func toRealm(_ device: LanDevice) -> RealmLanDevice {
        let obj = RealmLanDevice()
        obj.ip = device.ip
        obj.mac = device.mac
        obj.hostname = device.hostname
        return obj
    }

    static func fromRealm(_ obj: RealmLanDevice) -> LanDevice {
        LanDevice(
            ip: obj.ip,
            mac: obj.mac,
            hostname: obj.hostname
        )
    }
}
