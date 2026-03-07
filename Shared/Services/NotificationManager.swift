import Foundation
import UserNotifications

final class NotificationManager {
    static let shared = NotificationManager()

    private let notificationID = "potty-reminder"
    private let reminderInterval: TimeInterval = 45 * 60 // 45 minutes

    private init() {}

    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in }
    }

    func scheduleReminder() {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [notificationID])

        let content = UNMutableNotificationContent()
        content.title = "Potty Tracker"
        content.body = "It's been 45 minutes — time for a potty check!"
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: reminderInterval, repeats: false)
        let request = UNNotificationRequest(identifier: notificationID, content: content, trigger: trigger)

        center.add(request)
    }

    func cancelPending() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [notificationID])
    }
}
