import SwiftUI
import WidgetKit
import AppIntents

struct SmallWidgetView: View {
    let entry: PottyEntry

    var body: some View {
        VStack(spacing: 6) {
            if let event = entry.lastEvent {
                Text(event.type.emoji)
                    .font(.system(size: 32))

                Text(event.timestamp, style: .relative)
                    .font(.system(.caption, design: .rounded, weight: .semibold))
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)

                Text("ago")
                    .font(.system(.caption2, design: .rounded, weight: .medium))
                    .foregroundStyle(.tertiary)
            } else {
                Text("🚽")
                    .font(.system(size: 32))

                Text("No logs yet")
                    .font(.system(.caption, design: .rounded, weight: .medium))
                    .foregroundStyle(.secondary)
            }

            Spacer(minLength: 2)

            HStack(spacing: 6) {
                Button(intent: LogPeeIntent()) {
                    Text("💧")
                        .font(.system(size: 16))
                        .frame(maxWidth: .infinity)
                        .frame(height: 28)
                        .background(Color(red: 1.0, green: 0.851, blue: 0.239).opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                }

                Button(intent: LogPoopIntent()) {
                    Text("💩")
                        .font(.system(size: 16))
                        .frame(maxWidth: .infinity)
                        .frame(height: 28)
                        .background(Color(red: 0.769, green: 0.584, blue: 0.416).opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                }
            }
            .buttonStyle(.plain)
        }
        .containerBackground(for: .widget) {
            Color(red: 1.0, green: 0.973, blue: 0.941)
        }
    }
}
