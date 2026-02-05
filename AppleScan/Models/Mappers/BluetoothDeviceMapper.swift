//
//  BluetoothDeviceMapper.swift
//  AppleScan
//
//  Created by Artyom on 03.02.2026.
//

import Foundation

struct BluetoothDeviceMapper {

    static func toRealm(_ device: BluetoothDevice) -> RealmBluetoothDevice {
        let obj = RealmBluetoothDevice()
        obj.name = device.name
        obj.uuid = device.uuid
        obj.rssi = device.rssi
        obj.state = device.state
        return obj
    }

    static func fromRealm(_ obj: RealmBluetoothDevice) -> BluetoothDevice {
        BluetoothDevice(
            name: obj.name,
            uuid: obj.uuid,
            rssi: obj.rssi,
            state: obj.state
        )
    }
}
