import SwiftUI

// MARK: - VRR Chip Variant

/// Visual style for chips.
public enum VRRChipVariant: Sendable {
    /// Filled background when selected, outlined when deselected.
    case filter
    /// Always outlined, dismissable.
    case input
    /// Subtle filled background, non-interactive display.
    case suggestion
}

// MARK: - VRRChip

/// A compact, interactive element for filters, selections, and tags.
///
/// Chips are commonly used in filter bars, tag inputs, and category selectors.
/// They follow Apple's HIG for compact interactive elements.
///
/// ## Usage
/// ```swift
/// // Filter chip (toggleable)
/// VRRChip("Swift", isSelected: $isSwiftSelected)
///
/// // With icon
/// VRRChip("Location", isSelected: $locationOn, icon: Image(systemName: "location"))
///
/// // Input chip (dismissable)
/// VRRChip("tag-name", variant: .input, onDismiss: { removeTag() })
///
/// // Suggestion chip
/// VRRChip("Try this", variant: .suggestion) { handleSuggestion() }
/// ```
public struct VRRChip: View {

    @Environment(\.vrrTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    private let label: String
    private let variant: VRRChipVariant
    private let icon: Image?
    @Binding private var isSelected: Bool
    private let onDismiss: (() -> Void)?
    private let onTap: (() -> Void)?

    /// Creates a filter chip with a binding for selection state.
    public init(
        _ label: String,
        isSelected: Binding<Bool>,
        variant: VRRChipVariant = .filter,
        icon: Image? = nil
    ) {
        self.label = label
        self._isSelected = isSelected
        self.variant = variant
        self.icon = icon
        self.onDismiss = nil
        self.onTap = nil
    }

    /// Creates an input chip with a dismiss action.
    public init(
        _ label: String,
        variant: VRRChipVariant = .input,
        icon: Image? = nil,
        onDismiss: @escaping () -> Void
    ) {
        self.label = label
        self._isSelected = .constant(true)
        self.variant = variant
        self.icon = icon
        self.onDismiss = onDismiss
        self.onTap = nil
    }

    /// Creates a suggestion chip with a tap action.
    public init(
        _ label: String,
        variant: VRRChipVariant = .suggestion,
        icon: Image? = nil,
        onTap: @escaping () -> Void
    ) {
        self.label = label
        self._isSelected = .constant(false)
        self.variant = variant
        self.icon = icon
        self.onDismiss = nil
        self.onTap = onTap
    }

    public var body: some View {
        Button {
            switch variant {
            case .filter:
                isSelected.toggle()
            case .input:
                break // dismiss handled by x button
            case .suggestion:
                onTap?()
            }
        } label: {
            HStack(spacing: theme.spacing.xxs) {
                if let icon {
                    icon
                        .font(theme.typography.caption1)
                }

                Text(label)
                    .font(theme.typography.subheadline)
                    .lineLimit(1)

                if variant == .input, onDismiss != nil {
                    Button {
                        onDismiss?()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 10, weight: .bold))
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, theme.spacing.sm)
            .padding(.vertical, theme.spacing.xxs + 2)
            .foregroundStyle(foregroundColor)
            .background(backgroundColor, in: capsuleShape)
            .overlay(borderOverlay)
        }
        .buttonStyle(.plain)
        .opacity(isEnabled ? 1.0 : theme.opacity.disabled)
        .animation(theme.animation.quick, value: isSelected)
    }

    // MARK: - Appearance

    private var capsuleShape: some InsettableShape {
        Capsule(style: theme.radius.usesContinuousCorners ? .continuous : .circular)
    }

    @ViewBuilder
    private var borderOverlay: some View {
        if !isSelected || variant == .input || variant == .suggestion {
            Capsule(style: theme.radius.usesContinuousCorners ? .continuous : .circular)
                .strokeBorder(
                    isSelected ? theme.colors.primary : theme.colors.border,
                    lineWidth: 1
                )
        }
    }

    private var foregroundColor: Color {
        if isSelected && variant == .filter {
            return theme.colors.onPrimary
        }
        return theme.colors.textPrimary
    }

    private var backgroundColor: Color {
        switch variant {
        case .filter:
            return isSelected ? theme.colors.primary : .clear
        case .input:
            return theme.colors.surfaceSecondary
        case .suggestion:
            return theme.colors.surfaceSecondary.opacity(0.5)
        }
    }
}
