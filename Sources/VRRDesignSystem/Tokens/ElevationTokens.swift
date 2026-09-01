import SwiftUI

// MARK: - Shadow / Elevation Value

/// A concrete shadow definition used across the elevation scale.
public struct VRRShadow: Sendable, Equatable {
    public let color: Color
    public let radius: CGFloat
    public let x: CGFloat
    public let y: CGFloat

    public init(color: Color, radius: CGFloat, x: CGFloat = 0, y: CGFloat = 0) {
        self.color = color
        self.radius = radius
        self.x = x
        self.y = y
    }
}

// MARK: - Elevation Token Protocol (Interface Segregation)

/// Defines elevation (shadow) levels for depth and layering.
///
/// Elevation communicates hierarchy — higher elevation means the surface
/// is visually "closer" to the user. Apple platforms use subtle shadows
/// combined with background tinting for elevation cues.
public protocol VRRElevationTokens: Sendable {

    /// No elevation — flat, embedded content.
    var none: VRRShadow { get }

    /// Low elevation — subtle lift (cards in a list).
    var sm: VRRShadow { get }

    /// Medium elevation — popovers, dropdowns.
    var md: VRRShadow { get }

    /// High elevation — modals, floating action buttons.
    var lg: VRRShadow { get }
}
