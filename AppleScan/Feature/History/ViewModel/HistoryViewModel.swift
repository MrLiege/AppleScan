//
//  HistoryViewModel.swift
//  AppleScan
//
//  Created by Artyom on 04.02.2026.
//

import Foundation
import Combine

final class HistoryViewModel: ObservableObject {

    @Published private(set) var sessions: [ScanSession] = []
    @Published var isDatePickerPresented = false
    @Published var selectedDate: Date? = nil

    private let database: DatabaseService
    private let coordinator: HistoryFlowCoordinator
    private var cancellables = Set<AnyCancellable>()

    init(
        database: DatabaseService,
        coordinator: HistoryFlowCoordinator
    ) {
        self.database = database
        self.coordinator = coordinator

        database.sessionsPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] sessions in
                self?.sessions = sessions
            }
            .store(in: &cancellables)
    }

    var filteredSessions: [ScanSession] {
        sessions.filter { session in
            guard let date = selectedDate else { return true }
            return Calendar.current.isDate(session.date, inSameDayAs: date)
        }
    }

    func openSession(_ session: ScanSession) {
        coordinator.showSessionDetails(session)
    }
}
