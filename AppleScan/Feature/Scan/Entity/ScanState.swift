//
//  ScanState.swift
//  AppleScan
//
//  Created by Artyom on 05.02.2026.
//

import Foundation

enum ScanState {
    case idle
    case scanning
    case error(String)
}
