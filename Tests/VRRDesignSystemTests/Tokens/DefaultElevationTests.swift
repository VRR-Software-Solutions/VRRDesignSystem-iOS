import Testing
import SwiftUI
@testable import VRRDesignSystem

// MARK: - Default Elevation Token Tests

@Suite("VRRDefaultElevation")
struct DefaultElevationTests {

    let elevation = VRRDefaultElevation()

    @Test("None elevation has no shadow")
    func noneElevation() {
        let shadow = elevation.none
        #expect(shadow.color == .clear)
        #expect(shadow.radius == 0)
    }

    @Test("Small elevation values")
    func smallElevation() {
        let shadow = elevation.sm
        #expect(shadow.radius == 4)
        #expect(shadow.y == 2)
        #expect(shadow.x == 0)
    }

    @Test("Medium elevation values")
    func mediumElevation() {
        let shadow = elevation.md
        #expect(shadow.radius == 8)
        #expect(shadow.y == 4)
    }

    @Test("Large elevation values")
    func largeElevation() {
        let shadow = elevation.lg
        #expect(shadow.radius == 16)
        #expect(shadow.y == 8)
    }

    @Test("Shadow radius increases with elevation level")
    func radiusProgression() {
        #expect(elevation.none.radius < elevation.sm.radius)
        #expect(elevation.sm.radius < elevation.md.radius)
        #expect(elevation.md.radius < elevation.lg.radius)
    }

    @Test("Shadow y-offset increases with elevation level")
    func yOffsetProgression() {
        #expect(elevation.sm.y < elevation.md.y)
        #expect(elevation.md.y < elevation.lg.y)
    }
}

// MARK: - VRRShadow Value Tests

@Suite("VRRShadow")
struct VRRShadowTests {

    @Test("Init with defaults")
    func initDefaults() {
        let shadow = VRRShadow(color: .black, radius: 10)
        #expect(shadow.x == 0)
        #expect(shadow.y == 0)
        #expect(shadow.radius == 10)
    }

    @Test("Init with custom x and y")
    func initCustom() {
        let shadow = VRRShadow(color: .red, radius: 5, x: 2, y: 3)
        #expect(shadow.x == 2)
        #expect(shadow.y == 3)
        #expect(shadow.radius == 5)
        #expect(shadow.color == .red)
    }

    @Test("Equatable conformance")
    func equatable() {
        let a = VRRShadow(color: .black, radius: 4, y: 2)
        let b = VRRShadow(color: .black, radius: 4, y: 2)
        let c = VRRShadow(color: .red, radius: 4, y: 2)
        #expect(a == b)
        #expect(a != c)
    }
}
