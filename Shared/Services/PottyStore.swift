import Foundation
import WidgetKit

final class PottyStore {
    static let shared = PottyStore()

    private let defaults: UserDefaults
    private let eventsKey = "potty_events"

    private init() {
        defaults = UserDefaults(suiteName: "group.com.ryanjadhav.potty") ?? .standard
    }

    var allEvents: [PottyEvent] {
        guard let data = defaults.data(forKey: eventsKey) else { return [] }
        let events = (try? JSONDecoder().decode([PottyEvent].self, from: data)) ?? []
        return events.sorted { $0.timestamp > $1.timestamp }
    }

    var lastEvent: PottyEvent? {
        allEvents.first
    }

    func logEvent(_ type: PottyType) {
        let event = PottyEvent(type: type)
        var events = allEvents
        events.insert(event, at: 0)
        save(events)

        WidgetCenter.shared.reloadAllTimelines()
        NotificationManager.shared.scheduleReminder()
    }

    func deleteEvent(_ event: PottyEvent) {
        var events = allEvents
        events.removeAll { $0.id == event.id }
        save(events)
        WidgetCenter.shared.reloadAllTimelines()
    }

    private func save(_ events: [PottyEvent]) {
        let data = try? JSONEncoder().encode(events)
        defaults.set(data, forKey: eventsKey)
    }
}
