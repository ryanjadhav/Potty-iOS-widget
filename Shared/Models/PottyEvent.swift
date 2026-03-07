import Foundation

enum PottyType: String, Codable, CaseIterable {
    case pee
    case poop

    var emoji: String {
        switch self {
        case .pee: return "💧"
        case .poop: return "💩"
        }
    }

    var label: String {
        switch self {
        case .pee: return "Pee"
        case .poop: return "Poop"
        }
    }
}

struct PottyEvent: Codable, Identifiable, Equatable {
    let id: UUID
    let type: PottyType
    let timestamp: Date

    init(type: PottyType, timestamp: Date = .now) {
        self.id = UUID()
        self.type = type
        self.timestamp = timestamp
    }
}
