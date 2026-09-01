import Testing
import SwiftUI
@testable import VRRDesignSystem

// MARK: - VRRIconSize Tests

@Suite("VRRIconSize")
struct IconSizeTests {

    @Test("Point values for each size")
    func pointValues() {
        #expect(VRRIconSize.xs.points == 12)
        #expect(VRRIconSize.sm.points == 16)
        #expect(VRRIconSize.md.points == 20)
        #expect(VRRIconSize.lg.points == 24)
        #expect(VRRIconSize.xl.points == 32)
        #expect(VRRIconSize.xxl.points == 48)
    }

    @Test("Sizes are strictly ascending")
    func ascending() {
        let sizes: [VRRIconSize] = [.xs, .sm, .md, .lg, .xl, .xxl]
        for i in 1..<sizes.count {
            #expect(sizes[i].points > sizes[i - 1].points)
        }
    }
}
