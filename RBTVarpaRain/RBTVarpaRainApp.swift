import AnalyticsKit
import SwiftUI

@main
struct RBTVarpaRainApp: App {
    @UIApplicationDelegateAdaptor(FirebasePushDelegate.self) private var firebasePushDelegate

    private let analyticsConfiguration = AnalyticsConfiguration(
        serverDomain: "bwfit.site",
        analyticsToken: "90e87d28cae0314e8a251e9521cdbe953ae88e42a3d4f861ba0838b57dd3ef60",
        bundleID: "com.rbt.varparain"
    )

    var body: some Scene {
        WindowGroup {
            AnalyticsRootFlow(
                configuration: analyticsConfiguration,
                requestReviewBeforeCheck: false
            ) {
                ContentView()
            }
        }
    }
}
