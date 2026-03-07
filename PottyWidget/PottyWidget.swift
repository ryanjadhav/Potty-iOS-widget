import SwiftUI
import WidgetKit

struct PottyWidget: Widget {
    let kind: String = "PottyWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: PottyTimelineProvider()) { entry in
            PottyWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Potty Timer")
        .description("Track your toddler's potty events.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct PottyWidgetEntryView: View {
    @Environment(\.widgetFamily) var family
    let entry: PottyEntry

    var body: some View {
        switch family {
        case .systemSmall:
            SmallWidgetView(entry: entry)
        case .systemMedium:
            MediumWidgetView(entry: entry)
        default:
            SmallWidgetView(entry: entry)
        }
    }
}
