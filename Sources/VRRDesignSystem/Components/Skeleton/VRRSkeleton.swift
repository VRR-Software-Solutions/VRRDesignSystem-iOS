import SwiftUI

// MARK: - VRR Skeleton Shape

/// The shape of the skeleton placeholder.
public enum VRRSkeletonShape: Sendable {
    /// Rounded rectangle (cards, text lines, buttons).
    case rectangle
    /// Circle (avatars, icons).
    case circle
    /// Capsule (chips, tags, short text).
    case capsule
}

// MARK: - VRRSkeleton

/// An animated shimmer loading placeholder.
///
/// Displays a pulsing/shimmering shape that indicates content is loading.
/// Uses Apple's native animation system for smooth, 60fps shimmer.
///
/// ## Usage
/// ```swift
/// // Text line placeholder
/// VRRSkeleton(width: 200, height: 16)
///
/// // Avatar placeholder
/// VRRSkeleton(width: 40, height: 40, shape: .circle)
///
/// // Full card skeleton
/// VStack(alignment: .leading, spacing: 12) {
///     VRRSkeleton(width: 120, height: 16)
///     VRRSkeleton(height: 14)
///     VRRSkeleton(width: 180, height: 14)
/// }
/// ```
public struct VRRSkeleton: View {

    @Environment(\.vrrTheme) private var theme
    @State private var isAnimating = false

    private let width: CGFloat?
    private let height: CGFloat
    private let shape: VRRSkeletonShape

    public init(
        width: CGFloat? = nil,
        height: CGFloat = 16,
        shape: VRRSkeletonShape = .rectangle
    ) {
        self.width = width
        self.height = height
        self.shape = shape
    }

    public var body: some View {
        shimmerShape
            .frame(width: resolvedWidth, height: height)
            .opacity(isAnimating ? 0.4 : 0.7)
            .animation(
                .easeInOut(duration: 1.0).repeatForever(autoreverses: true),
                value: isAnimating
            )
            .onAppear { isAnimating = true }
    }

    // MARK: - Shape

    @ViewBuilder
    private var shimmerShape: some View {
        switch shape {
        case .rectangle:
            RoundedRectangle(
                cornerRadius: theme.radius.sm,
                style: theme.radius.usesContinuousCorners ? .continuous : .circular
            )
            .fill(theme.colors.surfaceSecondary)
        case .circle:
            Circle()
                .fill(theme.colors.surfaceSecondary)
        case .capsule:
            Capsule(style: theme.radius.usesContinuousCorners ? .continuous : .circular)
                .fill(theme.colors.surfaceSecondary)
        }
    }

    private var resolvedWidth: CGFloat? {
        if shape == .circle { return height }
        return width
    }
}

// MARK: - Skeleton Group Convenience

/// A pre-built skeleton layout mimicking common list rows.
///
/// ```swift
/// VRRSkeletonRow()       // avatar + 2 text lines
/// VRRSkeletonRow(lines: 3, showAvatar: false)
/// ```
public struct VRRSkeletonRow: View {

    @Environment(\.vrrTheme) private var theme

    private let lines: Int
    private let showAvatar: Bool

    public init(lines: Int = 2, showAvatar: Bool = true) {
        self.lines = lines
        self.showAvatar = showAvatar
    }

    public var body: some View {
        HStack(alignment: .top, spacing: theme.spacing.sm) {
            if showAvatar {
                VRRSkeleton(width: 40, height: 40, shape: .circle)
            }

            VStack(alignment: .leading, spacing: theme.spacing.xs) {
                ForEach(0..<lines, id: \.self) { index in
                    VRRSkeleton(
                        width: index == 0 ? nil : lineWidth(for: index),
                        height: index == 0 ? 16 : 14
                    )
                }
            }
        }
    }

    private func lineWidth(for index: Int) -> CGFloat? {
        // Vary widths to look natural
        switch index % 3 {
        case 1: return 200
        case 2: return 140
        default: return nil
        }
    }
}
