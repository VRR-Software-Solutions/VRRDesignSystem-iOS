import Testing
import SwiftUI
@testable import VRRDesignSystem

// MARK: - Default Spacing Token Tests

@Suite("VRRDefaultSpacing")
struct DefaultSpacingTests {

    let spacing = VRRDefaultSpacing()

    @Test("Spacing follows 4pt grid progression")
    func gridProgression() {
        #expect(spacing.xxs == 4)
        #expect(spacing.xs == 8)
        #expect(spacing.sm == 12)
        #expect(spacing.md == 16)
        #expect(spacing.lg == 20)
        #expect(spacing.xl == 24)
        #expect(spacing.xxl == 32)
        #expect(spacing.xxxl == 40)
    }

    @Test("Spacing values are strictly ascending")
    func strictlyAscending() {
        let values = [spacing.xxs, spacing.xs, spacing.sm, spacing.md,
                      spacing.lg, spacing.xl, spacing.xxl, spacing.xxxl]
        for i in 1..<values.count {
            #expect(values[i] > values[i - 1], "spacing[\(i)] should be > spacing[\(i-1)]")
        }
    }

    @Test("All values are positive")
    func allPositive() {
        #expect(spacing.xxs > 0)
        #expect(spacing.xs > 0)
        #expect(spacing.sm > 0)
        #expect(spacing.md > 0)
        #expect(spacing.lg > 0)
        #expect(spacing.xl > 0)
        #expect(spacing.xxl > 0)
        #expect(spacing.xxxl > 0)
    }

    @Test("Conforms to VRRSpacingTokens and Sendable")
    func conformance() {
        let tokens: any VRRSpacingTokens = spacing
        #expect(tokens.md == 16)
    }
}
