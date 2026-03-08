import Foundation
import WidgetKit

final class PottyStore {
    static let shared = PottyStore()
    static let didSyncNotification = Notification.Name("PottyStoreDidSync")

    private let defaults: UserDefaults
    private let eventsKey = "potty_events"
    private static let darwinNotificationName = "com.ryanjadhav.potty.eventLogged" as CFString

    private init() {
        defaults = UserDefaults(suiteName: "group.com.ryanjadhav.potty") ?? .standard

        // Listen for Darwin notifications from the widget process (cross-process)
        let darwinCenter = CFNotificationCenterGetDarwinNotifyCenter()
        let selfPtr = Unmanaged.passRetained(self).toOpaque()
        CFNotificationCenterAddObserver(
            darwinCenter,
            selfPtr,
            { _, observer, _, _, _ in
                guard let observer else { return }
                let store = Unmanaged<PottyStore>.fromOpaque(observer).takeUnretainedValue()
                store.handleDarwinNotification()
            },
            Self.darwinNotificationName,
            nil,
            .deliverImmediately
        )
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
        postDarwinNotification()
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

    private func handleDarwinNotification() {
        // Force UserDefaults to re-read from disk (clears stale in-memory cache)
        defaults.synchronize()
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: Self.didSyncNotification, object: nil)
        }
    }

    private func postDarwinNotification() {
        CFNotificationCenterPostNotification(
            CFNotificationCenterGetDarwinNotifyCenter(),
            CFNotificationName(Self.darwinNotificationName),
            nil, nil, true
        )
    }
}
