import WidgetKit

struct PottyEntry: TimelineEntry {
    let date: Date
    let lastEvent: PottyEvent?
}

struct PottyTimelineProvider: TimelineProvider {
    func placeholder(in context: Context) -> PottyEntry {
        PottyEntry(date: .now, lastEvent: PottyEvent(type: .pee, timestamp: .now.addingTimeInterval(-1200)))
    }

    func getSnapshot(in context: Context, completion: @escaping (PottyEntry) -> Void) {
        let entry = PottyEntry(date: .now, lastEvent: PottyStore.shared.lastEvent)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<PottyEntry>) -> Void) {
        let entry = PottyEntry(date: .now, lastEvent: PottyStore.shared.lastEvent)
        let nextUpdate = Calendar.current.date(byAdding: .minute, value: 15, to: .now) ?? .now
        let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
        completion(timeline)
    }
}
