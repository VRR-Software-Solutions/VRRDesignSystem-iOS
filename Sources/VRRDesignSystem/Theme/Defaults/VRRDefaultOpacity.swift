import SwiftUI

// MARK: - Default Opacity Tokens

/// Apple-standard opacity values for interactive states.
public struct VRRDefaultOpacity: VRROpacityTokens, Sendable {

    public init() {}

    public var disabled: Double { 0.38 }
    public var pressed: Double { 0.7 }
    public var hovered: Double { 0.85 }
}
