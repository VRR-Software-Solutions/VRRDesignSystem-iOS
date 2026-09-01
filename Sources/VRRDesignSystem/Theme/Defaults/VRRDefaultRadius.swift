import SwiftUI

// MARK: - Default Radius Tokens

/// Apple-style corner radii with continuous (superellipse) corners enabled.
///
/// All roles default to `.rounded` (via the protocol's default `shape(for:)`).
/// Consuming apps override `shape(for:)` to make controls capsule-shaped while
/// keeping containers rounded.
public struct VRRDefaultRadius: VRRRadiusTokens, Sendable {

    public init() {}

    public var sm: CGFloat { 4 }
    public var md: CGFloat { 8 }
    public var lg: CGFloat { 12 }
    public var xl: CGFloat { 20 }
    public var full: CGFloat { 9999 }
    public var usesContinuousCorners: Bool { true }

    // shape(for:) uses the protocol default → .rounded for every role.
}
