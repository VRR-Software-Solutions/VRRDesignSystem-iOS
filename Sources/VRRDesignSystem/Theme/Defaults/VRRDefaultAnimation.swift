import SwiftUI

// MARK: - Default Animation Tokens

/// Apple-native animation curves leveraging Spring animations.
///
/// Since iOS 17+, Apple recommends spring-based animations as the default.
/// These provide natural, physics-based motion that feels native.
public struct VRRDefaultAnimation: VRRAnimationTokens, Sendable {

    public init() {}

    public var quick: Animation {
        .spring(duration: 0.2, bounce: 0.0)
    }

    public var standard: Animation {
        .spring(duration: 0.35, bounce: 0.0)
    }

    public var emphasized: Animation {
        .spring(duration: 0.5, bounce: 0.1)
    }

    public var spring: Animation {
        .spring(duration: 0.6, bounce: 0.25)
    }
}
