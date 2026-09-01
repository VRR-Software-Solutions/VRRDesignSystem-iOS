import Testing
import SwiftUI
@testable import VRRDesignSystem

// MARK: - Style Instantiation Tests

/// Verifies that all ButtonStyle/TextFieldStyle/ToggleStyle/ProgressViewStyle
/// conformances can be created through their convenience factories.

@Suite("ButtonStyle Factory")
@MainActor
struct ButtonStyleFactoryTests {

    @Test("All variant + size combinations instantiate")
    func allCombinations() {
        let variants: [VRRButtonVariant] = [.primary, .secondary, .outlined, .ghost, .destructive]
        let sizes: [VRRButtonSize] = [.small, .medium, .large]

        for variant in variants {
            for size in sizes {
                let _ = VRRButtonStyle(variant: variant, size: size, isFullWidth: false)
            }
        }
    }

    @Test("Full width instantiates")
    func fullWidth() {
        let _ = VRRButtonStyle(variant: .primary, size: .large, isFullWidth: true)
    }

    @Test("Static factory .vrr creates correct style")
    func staticFactory() {
        // Compile-time check: these must return VRRButtonStyle
        let _: VRRButtonStyle = .vrr(.primary)
        let _: VRRButtonStyle = .vrr(.ghost, size: .small)
        let _: VRRButtonStyle = .vrr(.destructive, size: .large, fullWidth: true)
    }
}

@Suite("TextFieldStyle Factory")
@MainActor
struct TextFieldStyleFactoryTests {

    @Test("All variant + state combinations instantiate")
    func allCombinations() {
        let variants: [VRRTextFieldVariant] = [.outlined, .filled, .underlined]
        let states: [VRRTextFieldState] = [.default, .error, .success, .disabled]

        for variant in variants {
            for state in states {
                let _ = VRRTextFieldStyle(variant: variant, state: state)
            }
        }
    }

    @Test("Static factory .vrr creates correct style")
    func staticFactory() {
        let _: VRRTextFieldStyle = .vrr()
        let _: VRRTextFieldStyle = .vrr(.filled, state: .error)
    }
}

@Suite("ToggleStyle Factory")
@MainActor
struct ToggleStyleFactoryTests {

    @Test("Default tint instantiates")
    func defaultTint() {
        let _ = VRRToggleStyle()
    }

    @Test("All tint values instantiate")
    func allTints() {
        let _ = VRRToggleStyle(tint: .primary)
        let _ = VRRToggleStyle(tint: .secondary)
        let _ = VRRToggleStyle(tint: .success)
        let _ = VRRToggleStyle(tint: .custom(.orange))
    }

    @Test("Static factory .vrr creates correct style")
    func staticFactory() {
        let _: VRRToggleStyle = .vrr
        let _: VRRToggleStyle = .vrr(tint: .secondary)
    }
}

@Suite("ProgressViewStyle Factory")
@MainActor
struct ProgressViewStyleFactoryTests {

    @Test("All variant + tint combinations instantiate")
    func allCombinations() {
        let variants: [VRRProgressVariant] = [.circular, .linear]
        let tints: [VRRProgressTint] = [.primary, .secondary, .success, .custom(.mint)]

        for variant in variants {
            for tint in tints {
                let _ = VRRProgressViewStyle(variant: variant, tint: tint)
            }
        }
    }

    @Test("Static factory .vrr creates correct style")
    func staticFactory() {
        let _: VRRProgressViewStyle = .vrr
        let _: VRRProgressViewStyle = .vrr(.linear, tint: .success)
    }
}
