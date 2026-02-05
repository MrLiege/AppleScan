//
//  RootTabView.swift
//  AppleScan
//
//  Created by Artyom on 04.02.2026.
//

import SwiftUI

struct RootTabView: View {

    @ObservedObject var coordinator: AppCoordinator

    var body: some View {
        TabView(selection: $coordinator.selectedTab) {

            ScanFlowCoordinatorView(coordinator: coordinator.scanCoordinator)
                .tabItem {
                    Label("Скан", systemImage: "dot.radiowaves.left.and.right")
                }
                .tag(AppCoordinator.Tab.scan)

            HistoryFlowCoordinatorView(coordinator: coordinator.historyCoordinator)
                .tabItem {
                    Label("История", systemImage: "clock")
                }
                .tag(AppCoordinator.Tab.history)
        }
    }
}
