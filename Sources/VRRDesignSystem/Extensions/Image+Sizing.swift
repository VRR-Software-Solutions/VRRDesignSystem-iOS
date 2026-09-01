import SwiftUI

// MARK: - VRR Icon Size

/// Consistent icon sizing tied to the design system spacing scale.
public enum VRRIconSize: Sendable {
    /// 12pt — inline micro icons.
    case xs
    /// 16pt — compact list icons, badges.
    case sm
    /// 20pt — standard inline icons.
    case md
    /// 24pt — navigation icons, tab bar.
    case lg
    /// 32pt — prominent feature icons.
    case xl
    /// 48pt — hero/empty state icons.
    case xxl
}

// MARK: - View Extension

extension Image {

    /// Sizes an SF Symbol or image consistently using the design system scale.
    ///
    /// ```swift
    /// Image(systemName: "bell.fill")
    ///     .vrrIcon(.md)
    ///
    /// Image(systemName: "star.fill")
    ///     .vrrIcon(.lg, color: .yellow)
    /// ```
    public func vrrIcon(_ size: VRRIconSize, color: Color? = nil) -> some View {
        self
            .resizable()
            .scaledToFit()
            .frame(width: size.points, height: size.points)
            .foregroundStyle(color ?? .primary)
    }
}

extension VRRIconSize {

    /// The point size for this icon scale.
    public var points: CGFloat {
        switch self {
        case .xs: return 12
        case .sm: return 16
        case .md: return 20
        case .lg: return 24
        case .xl: return 32
        case .xxl: return 48
        }
    }
}
