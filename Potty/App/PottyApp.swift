import SwiftUI

@main
struct PottyApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .onAppear {
                    NotificationManager.shared.requestPermission()
                }
        }
    }
}
