import SwiftUI

// MARK: - Default Elevation Tokens

/// Subtle, Apple-style shadows.
///
/// Apple prefers very subtle shadows combined with background tinting
/// to communicate depth. These defaults are intentionally restrained.
public struct VRRDefaultElevation: VRRElevationTokens, Sendable {

    public init() {}

    public var none: VRRShadow {
        VRRShadow(color: .clear, radius: 0)
    }

    public var sm: VRRShadow {
        VRRShadow(color: .black.opacity(0.08), radius: 4, y: 2)
    }

    public var md: VRRShadow {
        VRRShadow(color: .black.opacity(0.12), radius: 8, y: 4)
    }

    public var lg: VRRShadow {
        VRRShadow(color: .black.opacity(0.16), radius: 16, y: 8)
    }
}
