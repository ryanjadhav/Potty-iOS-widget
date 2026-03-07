import SwiftUI
import WidgetKit
import AppIntents

struct MediumWidgetView: View {
    let entry: PottyEntry

    var body: some View {
        HStack(spacing: 16) {
            // Left: last event info
            VStack(alignment: .leading, spacing: 6) {
                if let event = entry.lastEvent {
                    Text(event.type.emoji)
                        .font(.system(size: 36))

                    Text("Last \(event.type.label)")
                        .font(.system(.caption, design: .rounded, weight: .medium))
                        .foregroundStyle(.secondary)

                    Text(event.timestamp, style: .relative)
                        .font(.system(.title3, design: .rounded, weight: .semibold))

                    Text(event.timestamp, format: .dateTime.hour().minute())
                        .font(.system(.caption2, design: .rounded, weight: .medium))
                        .foregroundStyle(.tertiary)
                } else {
                    Text("🚽")
                        .font(.system(size: 36))

                    Text("No logs yet")
                        .font(.system(.body, design: .rounded, weight: .medium))
                        .foregroundStyle(.secondary)

                    Spacer()
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            // Right: action buttons
            VStack(spacing: 8) {
                Button(intent: LogPeeIntent()) {
                    HStack(spacing: 6) {
                        Text("💧")
                            .font(.system(size: 18))
                        Text("Pee")
                            .font(.system(.callout, design: .rounded, weight: .semibold))
                            .foregroundStyle(.primary)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 44)
                    .background(Color(red: 1.0, green: 0.851, blue: 0.239).opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                }

                Button(intent: LogPoopIntent()) {
                    HStack(spacing: 6) {
                        Text("💩")
                            .font(.system(size: 18))
                        Text("Poop")
                            .font(.system(.callout, design: .rounded, weight: .semibold))
                            .foregroundStyle(.primary)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 44)
                    .background(Color(red: 0.769, green: 0.584, blue: 0.416).opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                }
            }
            .buttonStyle(.plain)
            .frame(width: 120)
        }
        .containerBackground(for: .widget) {
            Color(red: 1.0, green: 0.973, blue: 0.941)
        }
    }
}
