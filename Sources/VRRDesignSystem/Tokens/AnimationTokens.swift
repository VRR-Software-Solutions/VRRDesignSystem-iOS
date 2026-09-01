import SwiftUI

// MARK: - Animation Token Protocol (Interface Segregation)

/// Defines motion and animation curves for the design system.
///
/// Consistent animation tokens ensure the UI feels cohesive.
/// Default values leverage Apple's spring animations introduced in iOS 17+
/// for natural, responsive motion.
public protocol VRRAnimationTokens: Sendable {

    /// Quick micro-interaction (button press feedback, toggle).
    var quick: Animation { get }

    /// Default interactive animation (tab switch, expand/collapse).
    var standard: Animation { get }

    /// Emphasized entrance/exit (sheet presentation, page transitions).
    var emphasized: Animation { get }

    /// Spring-based bouncy feel for playful interactions.
    var spring: Animation { get }
}
