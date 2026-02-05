//
//  LanDevice.swift
//  AppleScan
//
//  Created by Artyom on 03.02.2026.
//

import Foundation

struct LanDevice: Identifiable, Hashable {
    let id = UUID()
    let ip: String
    let mac: String?
    let hostname: String?
}
