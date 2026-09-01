import SwiftUI

// MARK: - VRRToggleStyle

/// A `ToggleStyle` that applies VRRDesignSystem theme tokens to Apple's native `Toggle`.
///
/// Apple's Toggle already handles accessibility, animation, and platform adaptation
/// (switch on iOS, checkbox on macOS). This style tints it with theme colors
/// and adds consistent sizing.
///
/// ## Usage
/// ```swift
/// Toggle("Notifications", isOn: $notificationsEnabled)
///     .toggleStyle(.vrr)
///
/// Toggle("Dark Mode", isOn: $darkMode)
///     .toggleStyle(.vrr(tint: .secondary))
/// ```
public struct VRRToggleStyle: ToggleStyle {

    @Environment(\.vrrTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    private let tint: VRRToggleTint

    public init(tint: VRRToggleTint = .primary) {
        self.tint = tint
    }

    public func makeBody(configuration: Configuration) -> some View {
        Toggle(isOn: configuration.$isOn) {
            configuration.label
                .font(theme.typography.body)
                .foregroundStyle(
                    isEnabled ? theme.colors.textPrimary : theme.colors.textDisabled
                )
        }
        .tint(tintColor)
        .opacity(isEnabled ? 1.0 : theme.opacity.disabled)
    }

    private var tintColor: Color {
        switch tint {
        case .primary: return theme.colors.primary
        case .secondary: return theme.colors.secondary
        case .success: return theme.colors.success
        case .custom(let color): return color
        }
    }
}

// MARK: - Toggle Tint

/// Controls the on-state tint color of a VRR toggle.
public enum VRRToggleTint: Sendable {
    case primary
    case secondary
    case success
    case custom(Color)
}

// MARK: - Convenience Static Factory

extension ToggleStyle where Self == VRRToggleStyle {

    /// VRR-themed toggle with primary tint.
    ///
    /// ```swift
    /// Toggle("Wi-Fi", isOn: $wifi)
    ///     .toggleStyle(.vrr)
    /// ```
    public static var vrr: VRRToggleStyle {
        VRRToggleStyle()
    }

    /// VRR-themed toggle with a custom tint.
    ///
    /// ```swift
    /// Toggle("Airplane Mode", isOn: $airplane)
    ///     .toggleStyle(.vrr(tint: .secondary))
    /// ```
    public static func vrr(tint: VRRToggleTint) -> VRRToggleStyle {
        VRRToggleStyle(tint: tint)
    }
}
