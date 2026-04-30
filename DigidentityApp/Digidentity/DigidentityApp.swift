import SwiftUI

@main
struct DigidentityApp: App {
    private let appContainer = AppContainer()
    @StateObject private var themeStore = ThemeStore()

    var body: some Scene {
        WindowGroup {
            AppCoordinator(container: appContainer)
                .start()
                .environmentObject(themeStore)
                .preferredColorScheme(themeStore.colorSchemeOverride)
        }
    }
}
