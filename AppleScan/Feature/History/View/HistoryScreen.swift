//
//  HistoryScreen.swift
//  AppleScan
//
//  Created by Artyom on 04.02.2026.
//

import SwiftUI

struct HistoryScreen: View {

    @StateObject private var viewModel: HistoryViewModel

    init(viewModel: HistoryViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        Group {
            if viewModel.filteredSessions.isEmpty {
                emptyState
            } else {
                sessionsList
            }
        }
        .toolbar { toolbarContent }
        .sheet(isPresented: $viewModel.isDatePickerPresented) {
            datePickerSheet
        }
    }
}

private extension HistoryScreen {

    var emptyState: some View {
        VStack(spacing: 12) {
            LottieView(name: "broom", loop: true)
                .frame(height: 180)

            Text("Нет сессий по выбранным фильтрам")
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }

    var sessionsList: some View {
        List {
            ForEach(viewModel.filteredSessions) { session in
                Button(
                    action: { viewModel.openSession(session) },
                    label: { HistorySessionRow(session: session) }
                )
            }
        }
    }

    var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button {
                viewModel.isDatePickerPresented = true
            } label: {
                Image(systemName: "calendar")
            }
        }
    }
}

private extension HistoryScreen {

    var datePickerSheet: some View {
        NavigationView {
            VStack(spacing: 20) {
                DatePicker(
                    "Выберите дату",
                    selection: Binding(
                        get: { viewModel.selectedDate ?? Date() },
                        set: { viewModel.selectedDate = $0 }
                    ),
                    displayedComponents: .date
                )
                .datePickerStyle(.graphical)
                .padding()

                Spacer()
            }
            .navigationTitle("Фильтр по дате")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Все даты") {
                        viewModel.selectedDate = nil
                        viewModel.isDatePickerPresented = false
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Готово") {
                        viewModel.isDatePickerPresented = false
                    }
                }
            }
        }
    }
}
