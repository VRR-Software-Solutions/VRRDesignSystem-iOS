import SwiftUI

// MARK: - VRRTheme (Composition Root)

/// The composed theme protocol that aggregates all token protocols.
///
/// This follows the Interface Segregation Principle — each token domain
/// is its own protocol. `VRRTheme` composes them into a single injectable dependency.
///
/// Apps can:
/// 1. Override the entire theme by conforming to `VRRTheme`
/// 2. Override individual token groups by providing custom conformances
///    to specific protocols (e.g., only customize `VRRColorTokens`)
///
/// ## Usage
/// ```swift
/// struct MyAppTheme: VRRTheme {
///     var colors: VRRColorTokens { MyAppColors() }
///     var typography: VRRTypographyTokens { MyAppTypography() }
///     var spacing: VRRSpacingTokens { VRRDefaultSpacing() } // keep defaults
///     var radius: VRRRadiusTokens { VRRDefaultRadius() }
///     var elevation: VRRElevationTokens { VRRDefaultElevation() }
///     var animation: VRRAnimationTokens { VRRDefaultAnimation() }
///     var opacity: VRROpacityTokens { VRRDefaultOpacity() }
/// }
/// ```
public protocol VRRTheme: Sendable {

    /// The color palette for this theme.
    var colors: any VRRColorTokens { get }

    /// The typography scale for this theme.
    var typography: any VRRTypographyTokens { get }

    /// The spacing scale for this theme.
    var spacing: any VRRSpacingTokens { get }

    /// The corner radius scale for this theme.
    var radius: any VRRRadiusTokens { get }

    /// The elevation / shadow scale for this theme.
    var elevation: any VRRElevationTokens { get }

    /// The animation curves for this theme.
    var animation: any VRRAnimationTokens { get }

    /// The opacity values for this theme.
    var opacity: any VRROpacityTokens { get }
}
