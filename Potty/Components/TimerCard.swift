import SwiftUI

struct TimerCard: View {
    let event: PottyEvent?

    var body: some View {
        VStack(spacing: 8) {
            if let event {
                Text(event.type.emoji)
                    .font(.system(size: 48))

                Text("Last \(event.type.label)")
                    .font(PottyTheme.rounded(.subheadline, weight: .medium))
                    .foregroundStyle(PottyTheme.textSecondary)

                Text(event.timestamp, style: .relative)
                    .font(PottyTheme.rounded(.title2, weight: .semibold))
                    .foregroundStyle(PottyTheme.textPrimary)
                + Text(" ago")
                    .font(PottyTheme.rounded(.title2, weight: .semibold))
                    .foregroundStyle(PottyTheme.textPrimary)

                Text(event.timestamp, format: .dateTime.hour().minute())
                    .font(PottyTheme.rounded(.caption, weight: .medium))
                    .foregroundStyle(PottyTheme.textSecondary)
            } else {
                Text("🚽")
                    .font(.system(size: 48))

                Text("No potty yet")
                    .font(PottyTheme.rounded(.title3, weight: .medium))
                    .foregroundStyle(PottyTheme.textSecondary)

                Text("Tap a button to start tracking!")
                    .font(PottyTheme.rounded(.subheadline))
                    .foregroundStyle(PottyTheme.textSecondary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 32)
        .padding(.horizontal, PottyTheme.cardPadding)
        .background(PottyTheme.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: PottyTheme.cornerRadius, style: .continuous))
        .shadow(color: .black.opacity(0.05), radius: 12, y: 4)
    }
}
