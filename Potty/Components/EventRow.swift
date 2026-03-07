import SwiftUI

struct EventRow: View {
    let event: PottyEvent

    var body: some View {
        HStack(spacing: 14) {
            Text(event.type.emoji)
                .font(.system(size: 28))
                .frame(width: 44, height: 44)
                .background(PottyTheme.color(for: event.type).opacity(0.15))
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 2) {
                Text(event.type.label)
                    .font(PottyTheme.rounded(.body, weight: .semibold))
                    .foregroundStyle(PottyTheme.textPrimary)

                Text(event.timestamp, format: .dateTime.month().day().hour().minute())
                    .font(PottyTheme.rounded(.caption, weight: .medium))
                    .foregroundStyle(PottyTheme.textSecondary)
            }

            Spacer()

            Text(event.timestamp, style: .relative)
                .font(PottyTheme.rounded(.caption, weight: .medium))
                .foregroundStyle(PottyTheme.textSecondary)
        }
        .padding(.vertical, 6)
    }
}
