import Foundation
import WidgetKit

final class PottyStore {
    static let shared = PottyStore()
    static let didSyncNotification = Notification.Name("PottyStoreDidSync")

    private let defaults: UserDefaults
    private let cloudStore = NSUbiquitousKeyValueStore.default
    private let eventsKey = "potty_events"

    private init() {
        defaults = UserDefaults(suiteName: "group.com.ryanjadhav.potty") ?? .standard

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(cloudStoreDidChange),
            name: NSUbiquitousKeyValueStore.didChangeExternallyNotification,
            object: cloudStore
        )
        cloudStore.synchronize()
        syncWithCloud()
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
        NotificationCenter.default.post(name: Self.didSyncNotification, object: nil)
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
        cloudStore.set(data, forKey: eventsKey)
        cloudStore.synchronize()
    }

    @objc private func cloudStoreDidChange(_ notification: Notification) {
        syncWithCloud()
    }

    private func syncWithCloud() {
        let localEvents = allEvents
        var cloudEvents: [PottyEvent] = []
        if let cloudData = cloudStore.data(forKey: eventsKey) {
            cloudEvents = (try? JSONDecoder().decode([PottyEvent].self, from: cloudData)) ?? []
        }

        // Merge by UUID — union of both sets, deduplicated
        var merged: [UUID: PottyEvent] = [:]
        for event in localEvents { merged[event.id] = event }
        for event in cloudEvents { merged[event.id] = event }

        let mergedEvents = Array(merged.values).sorted { $0.timestamp > $1.timestamp }

        // Only save if the merged set differs from local
        if Set(mergedEvents.map(\.id)) != Set(localEvents.map(\.id)) {
            let data = try? JSONEncoder().encode(mergedEvents)
            defaults.set(data, forKey: eventsKey)
            cloudStore.set(data, forKey: eventsKey)
            cloudStore.synchronize()

            WidgetCenter.shared.reloadAllTimelines()
            NotificationCenter.default.post(name: Self.didSyncNotification, object: nil)
        }
    }
}
