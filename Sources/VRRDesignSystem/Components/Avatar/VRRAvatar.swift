import SwiftUI

// MARK: - VRR Avatar Size

/// Controls the diameter of the avatar.
public enum VRRAvatarSize: Sendable {
    /// 24pt — inline, compact lists.
    case xs
    /// 32pt — list rows, comments.
    case sm
    /// 40pt — standard.
    case md
    /// 56pt — profile headers.
    case lg
    /// 80pt — profile detail, onboarding.
    case xl
}

// MARK: - VRRAvatar

/// A circular avatar component for user images or initials.
///
/// Leverages Apple's `AsyncImage` for URL-based loading with built-in
/// loading/error states. Falls back to initials when no image is provided.
///
/// ## Usage
/// ```swift
/// // With SF Symbol placeholder
/// VRRAvatar(initials: "JD")
///
/// // With async image
/// VRRAvatar(url: URL(string: "https://..."), initials: "JD")
///
/// // Different sizes
/// VRRAvatar(url: profileURL, initials: "AB", size: .xl)
/// ```
public struct VRRAvatar: View {

    @Environment(\.vrrTheme) private var theme

    private let url: URL?
    private let initials: String
    private let size: VRRAvatarSize
    private let showBorder: Bool

    public init(
        url: URL? = nil,
        initials: String = "",
        size: VRRAvatarSize = .md,
        showBorder: Bool = false
    ) {
        self.url = url
        self.initials = initials
        self.size = size
        self.showBorder = showBorder
    }

    public var body: some View {
        Group {
            if let url {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    case .failure:
                        initialsView
                    case .empty:
                        ProgressView()
                            .frame(width: diameter, height: diameter)
                    @unknown default:
                        initialsView
                    }
                }
            } else {
                initialsView
            }
        }
        .frame(width: diameter, height: diameter)
        .clipShape(Circle())
        .overlay(borderView)
    }

    // MARK: - Subviews

    private var initialsView: some View {
        ZStack {
            Circle()
                .fill(theme.colors.surfaceSecondary)
            Text(String(initials.prefix(2)).uppercased())
                .font(initialsFont)
                .fontWeight(.medium)
                .foregroundStyle(theme.colors.textSecondary)
        }
    }

    @ViewBuilder
    private var borderView: some View {
        if showBorder {
            Circle()
                .strokeBorder(theme.colors.background, lineWidth: borderWidth)
        }
    }

    // MARK: - Sizing

    private var diameter: CGFloat {
        switch size {
        case .xs: return 24
        case .sm: return 32
        case .md: return 40
        case .lg: return 56
        case .xl: return 80
        }
    }

    private var initialsFont: Font {
        switch size {
        case .xs: return theme.typography.caption2
        case .sm: return theme.typography.caption1
        case .md: return theme.typography.subheadline
        case .lg: return theme.typography.title3
        case .xl: return theme.typography.title1
        }
    }

    private var borderWidth: CGFloat {
        switch size {
        case .xs, .sm: return 1.5
        case .md, .lg: return 2
        case .xl: return 3
        }
    }
}
