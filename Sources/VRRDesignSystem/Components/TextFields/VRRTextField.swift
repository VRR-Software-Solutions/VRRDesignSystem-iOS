import SwiftUI

// MARK: - VRRTextField (Composition Wrapper)

/// A themed text field that composes Apple's native `TextField` with common patterns:
/// label, leading/trailing icons, helper text, and error messages.
///
/// This does NOT replace `TextField` — it wraps it. All native behavior
/// (keyboard, autocomplete, VoiceOver, Writing Tools) is fully preserved.
///
/// For simple cases, use `TextField` directly with `.textFieldStyle(.vrr())`.
/// Use `VRRTextField` when you need the full label + helper + icon layout.
///
/// ## Usage
/// ```swift
/// // Simple
/// VRRTextField("Email", text: $email)
///
/// // With all options
/// VRRTextField(
///     "Password",
///     text: $password,
///     variant: .outlined,
///     state: .error,
///     helperText: "Must be at least 8 characters",
///     leadingIcon: Image(systemName: "lock"),
///     isSecure: true
/// )
/// ```
public struct VRRTextField: View {

    @Environment(\.vrrTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    private let label: String
    @Binding private var text: String
    private let prompt: String?
    private let variant: VRRTextFieldVariant
    private let state: VRRTextFieldState
    private let helperText: String?
    private let leadingIcon: Image?
    private let trailingIcon: Image?
    private let isSecure: Bool

    public init(
        _ label: String,
        text: Binding<String>,
        prompt: String? = nil,
        variant: VRRTextFieldVariant = .outlined,
        state: VRRTextFieldState = .default,
        helperText: String? = nil,
        leadingIcon: Image? = nil,
        trailingIcon: Image? = nil,
        isSecure: Bool = false
    ) {
        self.label = label
        self._text = text
        self.prompt = prompt
        self.variant = variant
        self.state = state
        self.helperText = helperText
        self.leadingIcon = leadingIcon
        self.trailingIcon = trailingIcon
        self.isSecure = isSecure
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: theme.spacing.xxs) {
            // Label
            Text(label)
                .font(theme.typography.subheadline)
                .foregroundStyle(labelColor)

            // Field row
            HStack(spacing: theme.spacing.xs) {
                if let leadingIcon {
                    leadingIcon
                        .font(theme.typography.body)
                        .foregroundStyle(iconColor)
                }

                fieldView

                if let trailingIcon {
                    trailingIcon
                        .font(theme.typography.body)
                        .foregroundStyle(iconColor)
                }
            }
            .textFieldStyle(.vrr(variant, state: state))

            // Helper / Error text
            if let helperText {
                Text(helperText)
                    .font(theme.typography.caption1)
                    .foregroundStyle(helperColor)
            }
        }
    }

    // MARK: - Field

    @ViewBuilder
    private var fieldView: some View {
        if isSecure {
            SecureField(
                prompt ?? label,
                text: $text,
                prompt: promptText
            )
        } else {
            TextField(
                prompt ?? label,
                text: $text,
                prompt: promptText
            )
        }
    }

    private var promptText: Text? {
        if let prompt {
            return Text(prompt)
                .foregroundStyle(theme.colors.textTertiary)
        }
        return nil
    }

    // MARK: - Colors

    private var labelColor: Color {
        guard isEnabled else { return theme.colors.textDisabled }
        switch state {
        case .error: return theme.colors.error
        case .success: return theme.colors.success
        default: return theme.colors.textSecondary
        }
    }

    private var helperColor: Color {
        switch state {
        case .error: return theme.colors.error
        case .success: return theme.colors.success
        default: return theme.colors.textTertiary
        }
    }

    private var iconColor: Color {
        guard isEnabled else { return theme.colors.textDisabled }
        switch state {
        case .error: return theme.colors.error
        case .success: return theme.colors.success
        default: return theme.colors.textSecondary
        }
    }
}
