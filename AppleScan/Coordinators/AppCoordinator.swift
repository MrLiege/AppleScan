//
//  AppCoordinator.swift
//  AppleScan
//
//  Created by Artyom on 04.02.2026.
//

import Combine

final class AppCoordinator: ObservableObject {

    enum Tab {
        case scan
        case history
    }

    @Published var selectedTab: Tab = .scan

    let scanCoordinator = ScanFlowCoordinator()
    let historyCoordinator = HistoryFlowCoordinator()

    func start() {
        selectedTab = .scan
    }
}
