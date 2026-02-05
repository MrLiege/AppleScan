//
//  HistoryFlowCoordinatorView.swift
//  AppleScan
//
//  Created by Artyom on 04.02.2026.
//

import SwiftUI

struct HistoryFlowCoordinatorView: View {

    @ObservedObject var coordinator: HistoryFlowCoordinator

    var body: some View {
        NavigationView {
            HistoryScreen(
                viewModel: HistoryViewModel(
                    database: DatabaseService(),
                    coordinator: coordinator
                )
            )
            .background(
                NavigationLink(
                    destination: sessionDetailsView,
                    isActive: Binding(
                        get: { if case .sessionDetails = coordinator.route { return true } else { return false } },
                        set: { if !$0 { coordinator.close() } }
                    ),
                    label: { EmptyView() }
                )
                .hidden()
            )
            .navigationTitle("История")
        }
    }

    @ViewBuilder
    private var sessionDetailsView: some View {
        if case .sessionDetails(let session) = coordinator.route {
            HistorySessionDetailsView(session: session)
        }
    }
}
