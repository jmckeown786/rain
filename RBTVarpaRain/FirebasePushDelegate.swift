import FirebaseCore
import FirebaseAnalytics
import FirebaseMessaging
import UIKit
import UserNotifications

final class FirebasePushDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        UNUserNotificationCenter.current().delegate = self

        if configureFirebaseIfPossible() {
            Messaging.messaging().delegate = self
            requestPushAuthorization(application)
        }

        return true
    }

    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        guard FirebaseApp.app() != nil else { return }
        Messaging.messaging().apnsToken = deviceToken
    }

    func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error
    ) {}

    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        UserDefaults.standard.set(fcmToken, forKey: "firebase.fcm.token")
        NotificationCenter.default.post(
            name: .fcmRegistrationTokenUpdated,
            object: nil,
            userInfo: ["token": fcmToken as Any]
        )
    }

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification
    ) async -> UNNotificationPresentationOptions {
        [.banner, .list, .sound, .badge]
    }

    private func configureFirebaseIfPossible() -> Bool {
        guard FirebaseApp.app() == nil else { return true }
        guard
            let path = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist"),
            let options = FirebaseOptions(contentsOfFile: path)
        else {
            return false
        }

        FirebaseApp.configure(options: options)
        Analytics.setAnalyticsCollectionEnabled(true)
        return true
    }

    private func requestPushAuthorization(_ application: UIApplication) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, _ in
            guard granted else { return }
            DispatchQueue.main.async {
                application.registerForRemoteNotifications()
            }
        }
    }
}

extension Notification.Name {
    static let fcmRegistrationTokenUpdated = Notification.Name("fcmRegistrationTokenUpdated")
}
