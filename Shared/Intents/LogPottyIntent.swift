import AppIntents
import SwiftUI

struct LogPeeIntent: AppIntent {
    static var title: LocalizedStringResource = "Log Pee"
    static var description: IntentDescription = "Log a pee event"

    func perform() async throws -> some IntentResult {
        PottyStore.shared.logEvent(.pee)
        return .result()
    }
}

struct LogPoopIntent: AppIntent {
    static var title: LocalizedStringResource = "Log Poop"
    static var description: IntentDescription = "Log a poop event"

    func perform() async throws -> some IntentResult {
        PottyStore.shared.logEvent(.poop)
        return .result()
    }
}
