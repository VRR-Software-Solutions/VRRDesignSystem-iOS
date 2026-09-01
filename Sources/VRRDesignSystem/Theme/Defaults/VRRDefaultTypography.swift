import SwiftUI

// MARK: - Default Typography Tokens

/// Apple's native Dynamic Type scale using San Francisco (SF Pro).
///
/// This directly mirrors the system `Font` hierarchy, ensuring:
/// - Full Dynamic Type accessibility support
/// - Automatic scaling with user's text size preferences
/// - Consistent with platform conventions
///
/// Consuming apps override with custom fonts using `.custom(_:size:relativeTo:)`
/// to maintain Dynamic Type scaling with custom typefaces.
public struct VRRDefaultTypography: VRRTypographyTokens, Sendable {

    public init() {}

    // MARK: - Display & Title Scale

    public var largeTitle: Font { .largeTitle }
    public var title1: Font { .title }
    public var title2: Font { .title2 }
    public var title3: Font { .title3 }

    // MARK: - Body Scale

    public var headline: Font { .headline }
    public var body: Font { .body }
    public var callout: Font { .callout }
    public var subheadline: Font { .subheadline }

    // MARK: - Caption Scale

    public var footnote: Font { .footnote }
    public var caption1: Font { .caption }
    public var caption2: Font { .caption2 }
}
