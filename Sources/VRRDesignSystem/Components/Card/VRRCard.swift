import SwiftUI

// MARK: - VRR Card Variant

/// Visual style for card surfaces.
public enum VRRCardVariant: Sendable {
    /// Elevated card with shadow — the most common pattern.
    case elevated
    /// Flat card with a subtle border, no shadow.
    case outlined
    /// Filled card with secondary background, no border or shadow.
    case filled
}

// MARK: - VRRCard

/// A themed surface container that wraps any content with consistent
/// padding, corner radius, elevation, and background from the theme.
///
/// Uses the `.container` shape role — cards stay properly rounded even under
/// capsule themes (a full radius on a large surface would produce an oval).
///
/// ## Usage
/// ```swift
/// VRRCard {
///     VStack(alignment: .leading) {
///         Text("Title").vrrText(.headline)
///         Text("Description").vrrText(.body)
///     }
/// }
///
/// VRRCard(.outlined, padding: .lg) {
///     HStack { ... }
/// }
/// ```
public struct VRRCard<Content: View>: View {

    @Environment(\.vrrTheme) private var theme

    private let variant: VRRCardVariant
    private let padding: VRRCardPadding
    private let content: Content

    public init(
        _ variant: VRRCardVariant = .elevated,
        padding: VRRCardPadding = .medium,
        @ViewBuilder content: () -> Content
    ) {
        self.variant = variant
        self.padding = padding
        self.content = content()
    }

    public var body: some View {
        content
            .padding(paddingValue)
            .background(backgroundColor, in: shape)
            .overlay(borderOverlay)
            .shadow(
                color: shadowToken.color,
                radius: shadowToken.radius,
                x: shadowToken.x,
                y: shadowToken.y
            )
    }

    // MARK: - Shape

    private var effectiveCornerRadius: CGFloat {
        theme.radius.effectiveRadius(theme.radius.lg, for: .container)
    }

    private var shape: some InsettableShape {
        RoundedRectangle(
            cornerRadius: effectiveCornerRadius,
            style: theme.radius.cornerStyle
        )
    }

    // MARK: - Appearance

    private var backgroundColor: Color {
        switch variant {
        case .elevated, .outlined:
            return theme.colors.surface
        case .filled:
            return theme.colors.surfaceSecondary
        }
    }

    @ViewBuilder
    private var borderOverlay: some View {
        if variant == .outlined {
            RoundedRectangle(
                cornerRadius: effectiveCornerRadius,
                style: theme.radius.cornerStyle
            )
            .strokeBorder(theme.colors.border, lineWidth: 1)
        }
    }

    private var shadowToken: VRRShadow {
        switch variant {
        case .elevated:
            return theme.elevation.sm
        case .outlined, .filled:
            return theme.elevation.none
        }
    }

    private var paddingValue: CGFloat {
        switch padding {
        case .none: return 0
        case .small: return theme.spacing.xs
        case .medium: return theme.spacing.md
        case .large: return theme.spacing.xl
        }
    }
}

// MARK: - Card Padding

/// Controls internal padding of a `VRRCard`.
public enum VRRCardPadding: Sendable {
    case none
    case small
    case medium
    case large
}
