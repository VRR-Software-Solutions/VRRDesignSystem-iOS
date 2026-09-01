import SwiftUI

// MARK: - Opacity Token Protocol (Interface Segregation)

/// Defines opacity values for interactive and disabled states.
///
/// Ensures consistent visual feedback across all components
/// when elements are pressed, disabled, or hovered.
public protocol VRROpacityTokens: Sendable {

    /// Fully disabled state.
    var disabled: Double { get }

    /// Pressed / highlighted state.
    var pressed: Double { get }

    /// Hover state (macOS pointer, iPadOS trackpad).
    var hovered: Double { get }
}
