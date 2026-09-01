import SwiftUI

// MARK: - VRR Button Variant

/// The visual variant for VRR-themed buttons.
///
/// Matches common design system patterns while staying
/// backed by Apple's native `ButtonStyle` infrastructure.
public enum VRRButtonVariant: Sendable {
    /// Filled with the primary color — highest emphasis.
    case primary
    /// Filled with the secondary color — medium emphasis.
    case secondary
    /// Outlined with a border, transparent fill — lower emphasis.
    case outlined
    /// Text-only, no fill or border — lowest emphasis.
    case ghost
    /// Destructive action — filled with error color.
    case destructive
}

// MARK: - VRR Button Size

/// Controls padding and font size of the button.
public enum VRRButtonSize: Sendable {
    /// Compact — small inline actions.
    case small
    /// Standard — most buttons.
    case medium
    /// Prominent — primary CTAs, onboarding.
    case large
}

// MARK: - VRRButtonStyle

/// A `ButtonStyle` that applies VRRDesignSystem theme tokens to Apple's native `Button`.
///
/// This does NOT replace `Button` — it styles it. All Apple behavior is preserved:
/// accessibility labels, keyboard shortcuts, focus states, haptics, etc.
///
/// When the theme makes the `.control` role capsule-shaped, buttons automatically
/// render as pills. Otherwise they use the standard corner radius.
///
/// ## Usage
/// ```swift
/// Button("Continue") { }
///     .buttonStyle(.vrr(.primary))
///
/// Button("Delete", role: .destructive) { }
///     .buttonStyle(.vrr(.destructive, size: .large))
///
/// Button("Cancel") { }
///     .buttonStyle(.vrr(.ghost))
/// ```
public struct VRRButtonStyle: ButtonStyle {

    @Environment(\.vrrTheme) private var theme
    @Environment(\.isEnabled) private var isEnabled

    private let variant: VRRButtonVariant
    private let size: VRRButtonSize
    private let isFullWidth: Bool

    public init(
        variant: VRRButtonVariant = .primary,
        size: VRRButtonSize = .medium,
        isFullWidth: Bool = false
    ) {
        self.variant = variant
        self.size = size
        self.isFullWidth = isFullWidth
    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(font)
            .fontWeight(.medium)
            .padding(.horizontal, horizontalPadding)
            .padding(.vertical, verticalPadding)
            .frame(maxWidth: isFullWidth ? .infinity : nil)
            .foregroundStyle(foregroundColor)
            .background(backgroundColor, in: backgroundShape)
            .overlay(borderOverlay)
            .opacity(opacity(isPressed: configuration.isPressed))
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(theme.animation.quick, value: configuration.isPressed)
    }

    // MARK: - Shape

    private var backgroundShape: some InsettableShape {
        RoundedRectangle(
            cornerRadius: effectiveCornerRadius,
            style: theme.radius.cornerStyle
        )
    }

    @ViewBuilder
    private var borderOverlay: some View {
        if variant == .outlined {
            RoundedRectangle(
                cornerRadius: effectiveCornerRadius,
                style: theme.radius.cornerStyle
            )
            .strokeBorder(isEnabled ? theme.colors.primary : theme.colors.border, lineWidth: 1.5)
        }
    }

    /// Resolves corner radius respecting the theme's shape style.
    /// When the `.control` role is capsule, uses `full` (9999) so `RoundedRectangle` acts as a capsule.
    private var effectiveCornerRadius: CGFloat {
        theme.radius.effectiveRadius(baseCornerRadius, for: .control)
    }

    private var baseCornerRadius: CGFloat {
        switch size {
        case .small: return theme.radius.sm
        case .medium: return theme.radius.md
        case .large: return theme.radius.lg
        }
    }

    // MARK: - Colors

    private var foregroundColor: Color {
        guard isEnabled else { return theme.colors.textDisabled }
        switch variant {
        case .primary:
            return theme.colors.onPrimary
        case .secondary:
            return theme.colors.onSecondary
        case .outlined:
            return theme.colors.primary
        case .ghost:
            return theme.colors.primary
        case .destructive:
            return theme.colors.onError
        }
    }

    private var backgroundColor: Color {
        guard isEnabled else { return theme.colors.surfaceSecondary }
        switch variant {
        case .primary:
            return theme.colors.primary
        case .secondary:
            return theme.colors.secondary
        case .outlined:
            return .clear
        case .ghost:
            return .clear
        case .destructive:
            return theme.colors.error
        }
    }

    // MARK: - Sizing

    private var horizontalPadding: CGFloat {
        switch size {
        case .small: return theme.spacing.xs
        case .medium: return theme.spacing.md
        case .large: return theme.spacing.xl
        }
    }

    private var verticalPadding: CGFloat {
        switch size {
        case .small: return theme.spacing.xxs
        case .medium: return theme.spacing.xs
        case .large: return theme.spacing.sm
        }
    }

    private var font: Font {
        switch size {
        case .small: return theme.typography.caption1
        case .medium: return theme.typography.body
        case .large: return theme.typography.headline
        }
    }

    private func opacity(isPressed: Bool) -> Double {
        if !isEnabled { return theme.opacity.disabled }
        if isPressed { return theme.opacity.pressed }
        return 1.0
    }
}

// MARK: - Convenience Static Factory

extension ButtonStyle where Self == VRRButtonStyle {

    /// Creates a VRR-themed button style.
    ///
    /// ```swift
    /// Button("Save") { }
    ///     .buttonStyle(.vrr(.primary))
    ///
    /// Button("Learn More") { }
    ///     .buttonStyle(.vrr(.ghost, size: .small))
    /// ```
    public static func vrr(
        _ variant: VRRButtonVariant = .primary,
        size: VRRButtonSize = .medium,
        fullWidth: Bool = false
    ) -> VRRButtonStyle {
        VRRButtonStyle(variant: variant, size: size, isFullWidth: fullWidth)
    }
}
