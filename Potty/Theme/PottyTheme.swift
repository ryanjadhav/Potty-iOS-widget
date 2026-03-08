import SwiftUI

enum PottyTheme {
    // MARK: - Colors (adaptive light/dark)
    static let background = Color(UIColor { t in
        t.userInterfaceStyle == .dark
            ? UIColor(red: 0.10, green: 0.08, blue: 0.13, alpha: 1)   // #1A1421 deep plum
            : UIColor(red: 1.00, green: 0.97, blue: 0.94, alpha: 1)   // #FFF8F0 warm cream
    })
    static let cardBackground = Color(UIColor { t in
        t.userInterfaceStyle == .dark
            ? UIColor(red: 0.17, green: 0.13, blue: 0.21, alpha: 1)   // #2B2136 dark card
            : UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1)   // #FFFFFF white
    })
    static let peeColor = Color(red: 1.0, green: 0.851, blue: 0.239)         // #FFD93D sunny yellow
    static let poopColor = Color(red: 0.769, green: 0.584, blue: 0.416)      // #C4956A warm brown
    static let accent = Color(UIColor { t in
        t.userInterfaceStyle == .dark
            ? UIColor(red: 0.65, green: 0.52, blue: 0.88, alpha: 1)   // #A685E0 lighter violet
            : UIColor(red: 0.42, green: 0.31, blue: 0.69, alpha: 1)   // #6B4FB0 deep violet
    })
    static let textPrimary = Color(UIColor { t in
        t.userInterfaceStyle == .dark
            ? UIColor(red: 0.94, green: 0.92, blue: 0.97, alpha: 1)   // #F0EBF7 near-white
            : UIColor(red: 0.13, green: 0.11, blue: 0.16, alpha: 1)   // #211C29 near-black
    })
    static let textSecondary = Color(UIColor { t in
        t.userInterfaceStyle == .dark
            ? UIColor(red: 0.70, green: 0.63, blue: 0.78, alpha: 1)   // #B3A0C7 muted light purple
            : UIColor(red: 0.38, green: 0.33, blue: 0.43, alpha: 1)   // #61546D dark plum
    })

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
