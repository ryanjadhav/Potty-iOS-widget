import SwiftUI

struct HistoryView: View {
    @Binding var events: [PottyEvent]
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                PottyTheme.background.ignoresSafeArea()

                if events.isEmpty {
                    ContentUnavailableView(
                        "No Events Yet",
                        systemImage: "drop.degreesign",
                        description: Text("Log your first potty event to start tracking.")
                    )
                } else {
                    List {
                        ForEach(groupedByDay, id: \.key) { day, dayEvents in
                            Section {
                                ForEach(dayEvents) { event in
                                    EventRow(event: event)
                                        .listRowBackground(PottyTheme.cardBackground)
                                }
                                .onDelete { offsets in
                                    deleteEvents(dayEvents: dayEvents, at: offsets)
                                }
                            } header: {
                                Text(day, format: .dateTime.month(.wide).day().year())
                                    .font(PottyTheme.rounded(.subheadline, weight: .semibold))
                                    .foregroundStyle(PottyTheme.textSecondary)
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationTitle("History")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(PottyTheme.background, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") { dismiss() }
                        .font(PottyTheme.rounded(.body, weight: .semibold))
                        .foregroundStyle(PottyTheme.accent)
                }
            }
        }
    }

    private var groupedByDay: [(key: Date, value: [PottyEvent])] {
        let calendar = Calendar.current
        let grouped = Dictionary(grouping: events) { event in
            calendar.startOfDay(for: event.timestamp)
        }
        return grouped.sorted { $0.key > $1.key }
    }

    private func deleteEvents(dayEvents: [PottyEvent], at offsets: IndexSet) {
        for index in offsets {
            let event = dayEvents[index]
            PottyStore.shared.deleteEvent(event)
        }
        events = PottyStore.shared.allEvents
    }
}
