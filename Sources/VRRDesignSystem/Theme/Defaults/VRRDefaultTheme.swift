import SwiftUI

// MARK: - Default Theme (Composition of All Defaults)

/// The out-of-the-box theme that ships with VRRDesignSystem.
///
/// Provides Apple-native defaults for all token groups. Apps override
/// individual token groups or the entire theme by conforming to `VRRTheme`.
///
/// ## Partial Override Example
/// ```swift
/// struct MyAppTheme: VRRTheme {
///     // Override only colors — keep everything else default
///     var colors: any VRRColorTokens { MyBrandColors() }
///     var typography: any VRRTypographyTokens { VRRDefaultTypography() }
///     var spacing: any VRRSpacingTokens { VRRDefaultSpacing() }
///     var radius: any VRRRadiusTokens { VRRDefaultRadius() }
///     var elevation: any VRRElevationTokens { VRRDefaultElevation() }
///     var animation: any VRRAnimationTokens { VRRDefaultAnimation() }
///     var opacity: any VRROpacityTokens { VRRDefaultOpacity() }
/// }
/// ```
public struct VRRDefaultTheme: VRRTheme, Sendable {

    public init() {}

    public var colors: any VRRColorTokens { VRRDefaultColors() }
    public var typography: any VRRTypographyTokens { VRRDefaultTypography() }
    public var spacing: any VRRSpacingTokens { VRRDefaultSpacing() }
    public var radius: any VRRRadiusTokens { VRRDefaultRadius() }
    public var elevation: any VRRElevationTokens { VRRDefaultElevation() }
    public var animation: any VRRAnimationTokens { VRRDefaultAnimation() }
    public var opacity: any VRROpacityTokens { VRRDefaultOpacity() }
}
