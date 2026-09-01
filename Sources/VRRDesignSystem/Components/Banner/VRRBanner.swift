import SwiftUI

// MARK: - VRR Banner Role

/// Semantic role determining banner appearance.
public enum VRRBannerRole: Sendable {
    case info
    case success
    case warning
    case error
}

// MARK: - VRRBanner

/// An inline message banner for contextual feedback.
///
/// Unlike `Alert` (which is a modal sheet), `VRRBanner` is embedded inline
/// within your view hierarchy — ideal for form validation, feature announcements,
/// and non-blocking status messages.
///
/// Uses the `.container` shape role — banners stay rounded even under capsule
/// themes (they hold multi-line content, so a pill shape would look wrong).
///
/// ## Usage
/// ```swift
/// VRRBanner("Your changes have been saved.", role: .success)
///
/// VRRBanner(
///     "Unable to connect. Check your network.",
///     role: .error,
///     icon: Image(systemName: "wifi.slash"),
///     action: ("Retry", { viewModel.retry() })
/// )
///
/// VRRBanner(
///     "New update available",
///     role: .info,
///     isDismissable: true,
///     onDismiss: { showBanner = false }
/// )
/// ```
public struct VRRBanner: View {

    @Environment(\.vrrTheme) private var theme

    private let message: String
    private let role: VRRBannerRole
    private let icon: Image?
    private let actionTitle: String?
    private let action: (() -> Void)?
    private let isDismissable: Bool
    private let onDismiss: (() -> Void)?

    public init(
        _ message: String,
        role: VRRBannerRole = .info,
        icon: Image? = nil,
        action: (String, () -> Void)? = nil,
        isDismissable: Bool = false,
        onDismiss: (() -> Void)? = nil
    ) {
        self.message = message
        self.role = role
        self.icon = icon
        self.actionTitle = action?.0
        self.action = action?.1
        self.isDismissable = isDismissable
        self.onDismiss = onDismiss
    }

    public var body: some View {
        HStack(alignment: .center, spacing: theme.spacing.xs) {
            // Icon
            iconView

            // Message
            Text(message)
                .font(theme.typography.subheadline)
                .foregroundStyle(roleColor)
                .frame(maxWidth: .infinity, alignment: .leading)

            // Action button
            if let actionTitle, let action {
                Button(actionTitle, action: action)
                    .font(theme.typography.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(roleColor)
            }

            // Dismiss
            if isDismissable {
                Button {
                    onDismiss?()
                } label: {
                    Image(systemName: "xmark")
                        .font(theme.typography.caption1)
                        .foregroundStyle(roleColor.opacity(0.7))
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, horizontalPadding)
        .padding(.vertical, theme.spacing.sm)
        .background(
            roleColor.opacity(0.1),
            in: bannerShape
        )
        .overlay(
            bannerShape
                .strokeBorder(roleColor.opacity(0.3), lineWidth: 1)
        )
    }

    // MARK: - Shape

    private var effectiveCornerRadius: CGFloat {
        theme.radius.effectiveRadius(theme.radius.md, for: .container)
    }

    private var bannerShape: some InsettableShape {
        RoundedRectangle(
            cornerRadius: effectiveCornerRadius,
            style: theme.radius.cornerStyle
        )
    }

    /// Extra horizontal padding when the container role is capsule, to keep text
    /// clear of the curves.
    private var horizontalPadding: CGFloat {
        theme.radius.shape(for: .container) == .capsule ? theme.spacing.md : theme.spacing.sm
    }

    // MARK: - Subviews

    @ViewBuilder
    private var iconView: some View {
        let resolvedIcon = icon ?? defaultIcon
        resolvedIcon
            .font(theme.typography.body)
            .foregroundStyle(roleColor)
    }

    private var defaultIcon: Image {
        switch role {
        case .info: return Image(systemName: "info.circle.fill")
        case .success: return Image(systemName: "checkmark.circle.fill")
        case .warning: return Image(systemName: "exclamationmark.triangle.fill")
        case .error: return Image(systemName: "xmark.circle.fill")
        }
    }

    // MARK: - Colors

    private var roleColor: Color {
        switch role {
        case .info: return theme.colors.info
        case .success: return theme.colors.success
        case .warning: return theme.colors.warning
        case .error: return theme.colors.error
        }
    }
}
