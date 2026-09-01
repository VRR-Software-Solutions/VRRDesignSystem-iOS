import SwiftUI

// MARK: - VRRLabeledRow

/// A themed key-value row for settings screens, detail views, and forms.
///
/// Wraps Apple's `LabeledContent` pattern with consistent theme-driven
/// typography and spacing. Supports leading icons, multiline values, and accessories.
///
/// ## Usage
/// ```swift
/// VRRLabeledRow("Name", value: "John Doe")
///
/// VRRLabeledRow("Status") {
///     VRRBadge("Active", role: .success, variant: .tinted)
/// }
///
/// VRRLabeledRow("Email", value: "john@example.com", icon: Image(systemName: "envelope"))
/// ```
public struct VRRLabeledRow<Value: View>: View {

    @Environment(\.vrrTheme) private var theme

    private let label: String
    private let icon: Image?
    private let value: Value

    /// Creates a labeled row with a text value.
    public init(
        _ label: String,
        value: String,
        icon: Image? = nil
    ) where Value == Text {
        self.label = label
        self.icon = icon
        self.value = Text(value)
    }

    /// Creates a labeled row with a custom value view.
    public init(
        _ label: String,
        icon: Image? = nil,
        @ViewBuilder value: () -> Value
    ) {
        self.label = label
        self.icon = icon
        self.value = value()
    }

    public var body: some View {
        HStack(spacing: theme.spacing.sm) {
            if let icon {
                icon
                    .font(theme.typography.body)
                    .foregroundStyle(theme.colors.textSecondary)
                    .frame(width: 24)
            }

            Text(label)
                .font(theme.typography.body)
                .foregroundStyle(theme.colors.textPrimary)

            Spacer(minLength: theme.spacing.xs)

            value
                .font(theme.typography.body)
                .foregroundStyle(theme.colors.textSecondary)
                .multilineTextAlignment(.trailing)
        }
        .padding(.vertical, theme.spacing.xs)
    }
}
