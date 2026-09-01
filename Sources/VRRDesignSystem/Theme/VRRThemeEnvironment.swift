import SwiftUI

// MARK: - SwiftUI Environment Integration

/// Custom EnvironmentKey that injects the active theme into the view hierarchy.
///
/// Components in VRRDesignSystem read this key to resolve their tokens.
/// The default value is `VRRDefaultTheme`, so the system works out of the box
/// even without explicit theme injection.
private struct VRRThemeEnvironmentKey: EnvironmentKey {
    static let defaultValue: any VRRTheme = VRRDefaultTheme()
}

extension EnvironmentValues {

    /// The active VRR design system theme.
    ///
    /// Set this at the root of your app to override the default theme:
    /// ```swift
    /// @main
    /// struct MyApp: App {
    ///     var body: some Scene {
    ///         WindowGroup {
    ///             ContentView()
    ///                 .environment(\.vrrTheme, MyAppTheme())
    ///         }
    ///     }
    /// }
    /// ```
    public var vrrTheme: any VRRTheme {
        get { self[VRRThemeEnvironmentKey.self] }
        set { self[VRRThemeEnvironmentKey.self] = newValue }
    }
}

// MARK: - View Convenience

extension View {

    /// Applies a custom VRR theme to this view hierarchy.
    ///
    /// A convenience wrapper around `.environment(\.vrrTheme, theme)`.
    /// ```swift
    /// ContentView()
    ///     .vrrTheme(MyAppTheme())
    /// ```
    public func vrrTheme(_ theme: some VRRTheme) -> some View {
        environment(\.vrrTheme, theme)
    }
}
