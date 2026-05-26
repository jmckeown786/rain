import SwiftUI

@main
struct RBTVarpaRainApp: App {
    @UIApplicationDelegateAdaptor(FirebasePushDelegate.self) private var firebasePushDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
