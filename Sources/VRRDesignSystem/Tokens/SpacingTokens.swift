import SwiftUI

// MARK: - Spacing Token Protocol (Interface Segregation)

/// Defines the spatial rhythm of the design system.
///
/// Based on a 4pt grid system that aligns with Apple's HIG recommendations.
/// Spacing tokens ensure consistent padding, margins, and gaps across all components.
///
/// ## Override Example
/// ```swift
/// struct CompactSpacing: VRRSpacingTokens {
///     var xxs: CGFloat { 2 }
///     var xs: CGFloat { 4 }
///     // ... tighter spacing for dense UIs
/// }
/// ```
public protocol VRRSpacingTokens: Sendable {

    /// 4pt — tightest (icon-to-label inline, dense lists).
    var xxs: CGFloat { get }

    /// 8pt — compact (internal component padding).
    var xs: CGFloat { get }

    /// 12pt — small (related element grouping).
    var sm: CGFloat { get }

    /// 16pt — base/default (standard content padding).
    var md: CGFloat { get }

    /// 20pt — medium-large (section inner padding).
    var lg: CGFloat { get }

    /// 24pt — large (between sections).
    var xl: CGFloat { get }

    /// 32pt — extra large (major section breaks).
    var xxl: CGFloat { get }

    /// 40pt — jumbo (page-level margins on iPad).
    var xxxl: CGFloat { get }
}
