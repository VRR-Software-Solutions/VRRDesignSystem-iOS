import SwiftUI

// MARK: - VRR TextField Variant

/// Visual variant for VRR-themed text fields.
public enum VRRTextFieldVariant: Sendable {
    /// Outlined border (most common, Apple HIG style).
    case outlined
    /// Filled background with no border.
    case filled
    /// Underline only — minimal style.
    case underlined
}

// MARK: - VRR TextField State

/// Represents the current validation/visual state of a text field.
public enum VRRTextFieldState: Sendable {
    /// Default idle state.
    case `default`
    /// Field has an error.
    case error
    /// Field value is valid/confirmed.
    case success
    /// Field is disabled (also handled by SwiftUI's .disabled modifier).
    case disabled
}

// MARK: - VRRTextFieldStyle

/// A `TextFieldStyle` that applies VRRDesignSystem theme tokens to Apple's native `TextField`.
///
/// All native TextField behavior is preserved — keyboard, autocomplete, paste,
/// VoiceOver, Writing Tools (iOS 18), focus management.
///
/// Uses the `.control` shape role — capsule themes render text fields as
/// fully rounded tubes.
///
/// ## Usage
/// ```swift
/// TextField("Email", text: $email)
///     .textFieldStyle(.vrr())
///
/// TextField("Username", text: $username)
///     .textFieldStyle(.vrr(.filled, state: .error))
///
/// SecureField("Password", text: $password)
///     .textFieldStyle(.vrr(.outlined))
/// ```
public struct VRRTextFieldStyle: TextFieldStyle {

    @Environment(\.vrrTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled
    @FocusState private var isFocused: Bool

    private let variant: VRRTextFieldVariant
    private let state: VRRTextFieldState

    public init(
        variant: VRRTextFieldVariant = .outlined,
        state: VRRTextFieldState = .default
    ) {
        self.variant = variant
        self.state = state
    }

    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .focused($isFocused)
            .font(theme.typography.body)
            .foregroundStyle(isEnabled ? theme.colors.textPrimary : theme.colors.textDisabled)
            .padding(.horizontal, horizontalPadding)
            .padding(.vertical, theme.spacing.xs)
            .background(backgroundColor, in: backgroundShape)
            .overlay(borderOverlay)
            .overlay(underlineOverlay, alignment: .bottom)
            .animation(theme.animation.quick, value: isFocused)
    }

    // MARK: - Shape

    /// Extra horizontal padding when capsule to prevent text touching the curves.
    private var horizontalPadding: CGFloat {
        theme.radius.shape(for: .control) == .capsule ? theme.spacing.md : theme.spacing.sm
    }

    private var effectiveCornerRadius: CGFloat {
        theme.radius.effectiveRadius(theme.radius.md, for: .control)
    }

    private var backgroundShape: some Shape {
        RoundedRectangle(
            cornerRadius: effectiveCornerRadius,
            style: theme.radius.cornerStyle
        )
    }

    // MARK: - Appearance

    private var effectiveState: VRRTextFieldState {
        isEnabled ? state : .disabled
    }

    private var backgroundColor: Color {
        switch variant {
        case .outlined:
            return .clear
        case .filled:
            return isEnabled ? theme.colors.surfaceSecondary : theme.colors.surfaceSecondary.opacity(0.5)
        case .underlined:
            return .clear
        }
    }

    @ViewBuilder
    private var borderOverlay: some View {
        if variant == .outlined {
            RoundedRectangle(
                cornerRadius: effectiveCornerRadius,
                style: theme.radius.cornerStyle
            )
            .strokeBorder(borderColor, lineWidth: isFocused ? 2 : 1)
        }
    }

    @ViewBuilder
    private var underlineOverlay: some View {
        if variant == .underlined {
            Rectangle()
                .fill(borderColor)
                .frame(height: isFocused ? 2 : 1)
        }
    }

    private var borderColor: Color {
        switch effectiveState {
        case .error:
            return theme.colors.error
        case .success:
            return theme.colors.success
        case .disabled:
            return theme.colors.border.opacity(0.5)
        case .default:
            return isFocused ? theme.colors.borderFocused : theme.colors.border
        }
    }
}

// MARK: - Convenience Static Factory

extension TextFieldStyle where Self == VRRTextFieldStyle {

    /// Creates a VRR-themed text field style.
    ///
    /// ```swift
    /// TextField("Name", text: $name)
    ///     .textFieldStyle(.vrr())
    ///
    /// TextField("Email", text: $email)
    ///     .textFieldStyle(.vrr(.filled, state: .error))
    /// ```
    public static func vrr(
        _ variant: VRRTextFieldVariant = .outlined,
        state: VRRTextFieldState = .default
    ) -> VRRTextFieldStyle {
        VRRTextFieldStyle(variant: variant, state: state)
    }
}
