import Testing
import SwiftUI
@testable import VRRDesignSystem

// MARK: - Default Radius Token Tests

@Suite("VRRDefaultRadius")
struct DefaultRadiusTests {

    let radius = VRRDefaultRadius()

    @Test("Default radius values")
    func defaultValues() {
        #expect(radius.sm == 4)
        #expect(radius.md == 8)
        #expect(radius.lg == 12)
        #expect(radius.xl == 20)
        #expect(radius.full == 9999)
    }

    @Test("Radius values are strictly ascending")
    func strictlyAscending() {
        let values = [radius.sm, radius.md, radius.lg, radius.xl, radius.full]
        for i in 1..<values.count {
            #expect(values[i] > values[i - 1])
        }
    }

    @Test("Uses continuous corners by default")
    func continuousCorners() {
        #expect(radius.usesContinuousCorners == true)
    }

    @Test("All roles are rounded by default")
    func defaultShapePerRole() {
        #expect(radius.shape(for: .control) == .rounded)
        #expect(radius.shape(for: .container) == .rounded)
    }

    @Test("cornerStyle returns continuous when usesContinuousCorners is true")
    func cornerStyleContinuous() {
        #expect(radius.cornerStyle == .continuous)
    }

    @Test("effectiveRadius returns input for both roles when rounded")
    func effectiveRadiusRounded() {
        #expect(radius.effectiveRadius(8, for: .control) == 8)
        #expect(radius.effectiveRadius(12, for: .control) == 12)
        #expect(radius.effectiveRadius(8, for: .container) == 8)
        #expect(radius.effectiveRadius(12, for: .container) == 12)
    }
}

// MARK: - Capsule Controls Radius Tests

@Suite("Capsule Controls Radius Behavior")
struct CapsuleControlsRadiusTests {

    /// Realistic capsule brand: pill controls, rounded containers.
    struct CapsuleControls: VRRRadiusTokens, Sendable {
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

    let radius = CapsuleControls()

    @Test("Control role is capsule, container role is rounded")
    func perRoleShape() {
        #expect(radius.shape(for: .control) == .capsule)
        #expect(radius.shape(for: .container) == .rounded)
    }

    @Test("effectiveRadius returns full for capsule controls")
    func controlUsesFull() {
        #expect(radius.effectiveRadius(4, for: .control) == 9999)
        #expect(radius.effectiveRadius(8, for: .control) == 9999)
        #expect(radius.effectiveRadius(12, for: .control) == 9999)
    }

    @Test("effectiveRadius returns input for rounded containers")
    func containerKeepsRadius() {
        // This is the key fix — cards do NOT become ovals under capsule themes.
        #expect(radius.effectiveRadius(12, for: .container) == 12)
        #expect(radius.effectiveRadius(8, for: .container) == 8)
        #expect(radius.effectiveRadius(20, for: .container) == 20)
    }
}

// MARK: - Full-Capsule (both roles) Tests

@Suite("Both Roles Capsule")
struct BothRolesCapsuleTests {

    struct AllCapsule: VRRRadiusTokens, Sendable {
        var sm: CGFloat { 4 }
        var md: CGFloat { 8 }
        var lg: CGFloat { 12 }
        var xl: CGFloat { 20 }
        var full: CGFloat { 9999 }
        var usesContinuousCorners: Bool { true }
        func shape(for role: VRRShapeRole) -> VRRShapeStyle { .capsule }
    }

    let radius = AllCapsule()

    @Test("Both roles resolve to full when explicitly capsule")
    func bothRolesFull() {
        #expect(radius.effectiveRadius(8, for: .control) == 9999)
        #expect(radius.effectiveRadius(12, for: .container) == 9999)
    }
}

// MARK: - Non-Continuous Corner Tests

@Suite("Non-Continuous Corners")
struct NonContinuousRadiusTests {

    struct CircularRadius: VRRRadiusTokens, Sendable {
        var sm: CGFloat { 4 }
        var md: CGFloat { 8 }
        var lg: CGFloat { 12 }
        var xl: CGFloat { 20 }
        var full: CGFloat { 9999 }
        var usesContinuousCorners: Bool { false }
        // shape(for:) uses protocol default → .rounded
    }

    let circular = CircularRadius()

    @Test("cornerStyle returns circular when usesContinuousCorners is false")
    func cornerStyleCircular() {
        #expect(circular.cornerStyle == .circular)
    }

    @Test("Protocol default shape is rounded for all roles")
    func protocolDefaultShape() {
        #expect(circular.shape(for: .control) == .rounded)
        #expect(circular.shape(for: .container) == .rounded)
    }
}
