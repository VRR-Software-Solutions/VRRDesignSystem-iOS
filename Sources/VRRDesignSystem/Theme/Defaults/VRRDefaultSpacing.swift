import SwiftUI

// MARK: - Default Spacing Tokens

/// 4pt grid-based spacing scale aligned with Apple HIG.
///
/// Apple's layout system works on an 8pt grid for larger elements,
/// with 4pt for fine adjustments. This scale covers both.
public struct VRRDefaultSpacing: VRRSpacingTokens, Sendable {

    public init() {}

    public var xxs: CGFloat { 4 }
    public var xs: CGFloat { 8 }
    public var sm: CGFloat { 12 }
    public var md: CGFloat { 16 }
    public var lg: CGFloat { 20 }
    public var xl: CGFloat { 24 }
    public var xxl: CGFloat { 32 }
    public var xxxl: CGFloat { 40 }
}
