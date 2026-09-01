import Testing
import SwiftUI
@testable import VRRDesignSystem

// MARK: - Default Opacity Token Tests

@Suite("VRRDefaultOpacity")
struct DefaultOpacityTests {

    let opacity = VRRDefaultOpacity()

    @Test("Default opacity values")
    func defaultValues() {
        #expect(opacity.disabled == 0.38)
        #expect(opacity.pressed == 0.7)
        #expect(opacity.hovered == 0.85)
    }

    @Test("Disabled is the most transparent")
    func disabledMostTransparent() {
        #expect(opacity.disabled < opacity.pressed)
        #expect(opacity.pressed < opacity.hovered)
    }

    @Test("All opacity values are between 0 and 1")
    func validRange() {
        let values = [opacity.disabled, opacity.pressed, opacity.hovered]
        for value in values {
            #expect(value > 0 && value < 1, "Opacity \(value) should be between 0 and 1")
        }
    }
}
