import SwiftUI

struct PottyButton: View {
    let type: PottyType
    let action: () -> Void

    var body: some View {
        Button(action: {
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            action()
        }) {
            HStack(spacing: 12) {
                Text(type.emoji)
                    .font(.system(size: 28))

                Text("Log \(type.label)")
                    .font(PottyTheme.rounded(.title3, weight: .semibold))
                    .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity)
            .frame(height: PottyTheme.buttonHeight)
            .background(PottyTheme.color(for: type))
            .clipShape(RoundedRectangle(cornerRadius: PottyTheme.cornerRadius, style: .continuous))
        }
        .buttonStyle(PottyButtonStyle(color: PottyTheme.color(for: type)))
    }
}
