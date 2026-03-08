import SwiftUI

enum PottyTheme {
    // MARK: - Colors
    static let background = Color(red: 1.0, green: 0.973, blue: 0.941)       // #FFF8F0 warm cream
    static let cardBackground = Color.white
    static let peeColor = Color(red: 1.0, green: 0.851, blue: 0.239)         // #FFD93D sunny yellow
    static let poopColor = Color(red: 0.769, green: 0.584, blue: 0.416)      // #C4956A warm brown
    static let accent = Color(red: 0.42, green: 0.31, blue: 0.69)             // #6B4FB0 deep violet
    static let textPrimary = Color(red: 0.13, green: 0.11, blue: 0.16)       // near-black plum
    static let textSecondary = Color(red: 0.38, green: 0.33, blue: 0.43)     // readable dark plum

    // MARK: - Typography
    static func rounded(_ style: Font.TextStyle, weight: Font.Weight = .regular) -> Font {
        .system(style, design: .rounded, weight: weight)
    }

    // MARK: - Layout
    static let cornerRadius: CGFloat = 20
    static let cardPadding: CGFloat = 20
    static let buttonHeight: CGFloat = 72

    static func color(for type: PottyType) -> Color {
        switch type {
        case .pee: return peeColor
        case .poop: return poopColor
        }
    }
}

// MARK: - Button Style

struct PottyButtonStyle: ButtonStyle {
    let color: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: configuration.isPressed)
    }
}
