import SwiftUI

// MARK: - VRR Badge Variant

/// Visual variant for badges.
public enum VRRBadgeVariant: Sendable {
    /// Filled background with on-color text.
    case filled
    /// Subtle/tinted background with matching text.
    case tinted
    /// Outlined with border only.
    case outlined
}

// MARK: - VRR Badge Role

/// Semantic role determining the badge color.
public enum VRRBadgeRole: Sendable {
    case primary
    case secondary
    case error
    case warning
    case success
    case info
}

// MARK: - VRRBadge

/// A small status indicator for counts, labels, and tags.
///
/// Uses the `.control` shape role — capsule themes render badges as pills.
///
/// ## Usage
/// ```swift
/// VRRBadge("New")
///
/// VRRBadge("3", role: .error)
///
/// VRRBadge("Shipped", role: .success, variant: .tinted)
///
/// // With an icon
/// VRRBadge("Warning", role: .warning, icon: Image(systemName: "exclamationmark.triangle"))
/// ```
public struct VRRBadge: View {

    @Environment(\.vrrTheme) private var theme

    private let text: String
    private let role: VRRBadgeRole
    private let variant: VRRBadgeVariant
    private let icon: Image?

    public init(
        _ text: String,
        role: VRRBadgeRole = .primary,
        variant: VRRBadgeVariant = .filled,
        icon: Image? = nil
    ) {
        self.text = text
        self.role = role
        self.variant = variant
        self.icon = icon
    }

    public var body: some View {
        HStack(spacing: theme.spacing.xxs) {
            if let icon {
                icon
                    .font(theme.typography.caption2)
            }
            Text(text)
                .font(theme.typography.caption1)
                .fontWeight(.medium)
        }
        .padding(.horizontal, theme.spacing.xs)
        .padding(.vertical, theme.spacing.xxs)
        .foregroundStyle(foregroundColor)
        .background(backgroundColor, in: backgroundShape)
        .overlay(borderOverlay)
    }

    // MARK: - Shape

    private var effectiveCornerRadius: CGFloat {
        theme.radius.effectiveRadius(theme.radius.sm, for: .control)
    }

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
            .strokeBorder(roleColor, lineWidth: 1)
        }
    }

    // MARK: - Colors

    private var foregroundColor: Color {
        switch variant {
        case .filled: return onRoleColor
        case .tinted: return roleColor
        case .outlined: return roleColor
        }
    }

    private var backgroundColor: Color {
        switch variant {
        case .filled: return roleColor
        case .tinted: return roleColor.opacity(0.12)
        case .outlined: return .clear
        }
    }

    private var roleColor: Color {
        switch role {
        case .primary: return theme.colors.primary
        case .secondary: return theme.colors.secondary
        case .error: return theme.colors.error
        case .warning: return theme.colors.warning
        case .success: return theme.colors.success
        case .info: return theme.colors.info
        }
    }

    private var onRoleColor: Color {
        switch role {
        case .primary: return theme.colors.onPrimary
        case .secondary: return theme.colors.onSecondary
        case .error: return theme.colors.onError
        case .warning: return .white
        case .success: return .white
        case .info: return .white
        }
    }
}
