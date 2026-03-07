import SwiftUI

struct MainView: View {
    @State private var events: [PottyEvent] = PottyStore.shared.allEvents
    @State private var showHistory = false
    @State private var lastLoggedType: PottyType?

    var body: some View {
        NavigationStack {
            ZStack {
                PottyTheme.background.ignoresSafeArea()

                VStack(spacing: 24) {
                    Spacer()

                    TimerCard(event: events.first)
                        .padding(.horizontal, 20)
                        .contentTransition(.numericText())

                    Spacer()

                    VStack(spacing: 12) {
                        PottyButton(type: .pee) {
                            logEvent(.pee)
                        }

                        PottyButton(type: .poop) {
                            logEvent(.poop)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 8)
                }
            }
            .navigationTitle("Potty")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showHistory = true
                    } label: {
                        Image(systemName: "clock.arrow.circlepath")
                            .font(.body.weight(.medium))
                            .foregroundStyle(PottyTheme.accent)
                    }
                }
            }
            .sheet(isPresented: $showHistory) {
                HistoryView(events: $events)
            }
            .onAppear {
                refreshEvents()
            }
        }
    }

    private func logEvent(_ type: PottyType) {
        PottyStore.shared.logEvent(type)
        withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
            lastLoggedType = type
            refreshEvents()
        }
    }

    private func refreshEvents() {
        events = PottyStore.shared.allEvents
    }
}
