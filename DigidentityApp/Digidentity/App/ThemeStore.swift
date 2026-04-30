import Combine
import SwiftUI

@MainActor
final class ThemeStore: ObservableObject {
    @Published var colorSchemeOverride: ColorScheme?

    func toggleColorScheme() {
        colorSchemeOverride = colorSchemeOverride == .dark ? .light : .dark
    }
}
