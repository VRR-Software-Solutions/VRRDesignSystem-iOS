import Testing
import SwiftUI
@testable import VRRDesignSystem

// MARK: - Theme Composition Tests

@Suite("VRRTheme Composition")
struct ThemeCompositionTests {

    @Test("VRRDefaultTheme provides all token groups")
    func defaultThemeProvidesAllGroups() {
        let theme = VRRDefaultTheme()

        // Verify each token group is accessible (non-nil via existential)
        let _: any VRRColorTokens = theme.colors
        let _: any VRRTypographyTokens = theme.typography
        let _: any VRRSpacingTokens = theme.spacing
        let _: any VRRRadiusTokens = theme.radius
        let _: any VRRElevationTokens = theme.elevation
        let _: any VRRAnimationTokens = theme.animation
        let _: any VRROpacityTokens = theme.opacity

        // Spot-check values flow through
        #expect(theme.colors.primary == .blue)
        #expect(theme.spacing.md == 16)
        #expect(theme.radius.md == 8)
        #expect(theme.opacity.disabled == 0.38)
    }

    @Test("Custom theme can override only colors")
    func partialOverrideColors() {
        struct RedColors: VRRColorTokens, Sendable {
            var primary: Color { .red }
            var secondary: Color { .red }
            var tertiary: Color { .red }
            var error: Color { .red }
            var warning: Color { .orange }
            var success: Color { .green }
            var info: Color { .cyan }
            var background: Color { .white }
            var surface: Color { .white }
            var surfaceSecondary: Color { .gray }
            var onPrimary: Color { .white }
            var onSecondary: Color { .white }
            var onTertiary: Color { .white }
            var onBackground: Color { .black }
            var onSurface: Color { .black }
            var onError: Color { .white }
            var textPrimary: Color { .black }
            var textSecondary: Color { .gray }
            var textTertiary: Color { .gray }
            var textDisabled: Color { .gray }
            var border: Color { .gray }
            var borderFocused: Color { .red }
            var separator: Color { .gray }
            var tint: Color { .red }
            var scrim: Color { .black.opacity(0.3) }
        }

        struct RedTheme: VRRTheme, Sendable {
            var colors: any VRRColorTokens { RedColors() }
            var typography: any VRRTypographyTokens { VRRDefaultTypography() }
            var spacing: any VRRSpacingTokens { VRRDefaultSpacing() }
            var radius: any VRRRadiusTokens { VRRDefaultRadius() }
            var elevation: any VRRElevationTokens { VRRDefaultElevation() }
            var animation: any VRRAnimationTokens { VRRDefaultAnimation() }
            var opacity: any VRROpacityTokens { VRRDefaultOpacity() }
        }

        let theme = RedTheme()
        // Colors overridden
        #expect(theme.colors.primary == .red)
        // Other groups still default
        #expect(theme.spacing.md == 16)
        #expect(theme.radius.md == 8)
        #expect(theme.typography.body == Font.body)
    }

    @Test("Custom theme can set capsule controls with rounded containers")
    func capsuleControlsOverride() {
        struct CapsuleControlsRadius: VRRRadiusTokens, Sendable {
            var sm: CGFloat { 4 }
            var md: CGFloat { 8 }
            var lg: CGFloat { 12 }
            var xl: CGFloat { 20 }
            var full: CGFloat { 9999 }
            var usesContinuousCorners: Bool { true }
            func shape(for role: VRRShapeRole) -> VRRShapeStyle {
                switch role {
                case .control:   return .capsule
                case .container: return .rounded
                }
            }
        }

        struct CapsuleTheme: VRRTheme, Sendable {
            var colors: any VRRColorTokens { VRRDefaultColors() }
            var typography: any VRRTypographyTokens { VRRDefaultTypography() }
            var spacing: any VRRSpacingTokens { VRRDefaultSpacing() }
            var radius: any VRRRadiusTokens { CapsuleControlsRadius() }
            var elevation: any VRRElevationTokens { VRRDefaultElevation() }
            var animation: any VRRAnimationTokens { VRRDefaultAnimation() }
            var opacity: any VRROpacityTokens { VRRDefaultOpacity() }
        }

        let theme = CapsuleTheme()
        // Controls become pills
        #expect(theme.radius.shape(for: .control) == .capsule)
        #expect(theme.radius.effectiveRadius(8, for: .control) == 9999)
        // Containers stay rounded — the key fix
        #expect(theme.radius.shape(for: .container) == .rounded)
        #expect(theme.radius.effectiveRadius(12, for: .container) == 12)
        // Colors still default
        #expect(theme.colors.primary == .blue)
    }

    @Test("VRRDefaultTheme conforms to Sendable")
    func sendableConformance() {
        let theme: any Sendable = VRRDefaultTheme()
        #expect(theme is VRRDefaultTheme)
    }
}
