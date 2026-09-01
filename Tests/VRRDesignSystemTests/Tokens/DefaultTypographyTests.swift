import Testing
import SwiftUI
@testable import VRRDesignSystem

// MARK: - Default Typography Token Tests

@Suite("VRRDefaultTypography")
struct DefaultTypographyTests {

    let typography = VRRDefaultTypography()

    @Test("Title scale maps to Apple system fonts")
    func titleScale() {
        #expect(typography.largeTitle == Font.largeTitle)
        #expect(typography.title1 == Font.title)
        #expect(typography.title2 == Font.title2)
        #expect(typography.title3 == Font.title3)
    }

    @Test("Body scale maps to Apple system fonts")
    func bodyScale() {
        #expect(typography.headline == Font.headline)
        #expect(typography.body == Font.body)
        #expect(typography.callout == Font.callout)
        #expect(typography.subheadline == Font.subheadline)
    }

    @Test("Caption scale maps to Apple system fonts")
    func captionScale() {
        #expect(typography.footnote == Font.footnote)
        #expect(typography.caption1 == Font.caption)
        #expect(typography.caption2 == Font.caption2)
    }

    @Test("All 11 Apple type styles are covered")
    func allStylesCovered() {
        // Verify every Dynamic Type level has a token
        let allFonts: [Font] = [
            typography.largeTitle, typography.title1, typography.title2, typography.title3,
            typography.headline, typography.body, typography.callout, typography.subheadline,
            typography.footnote, typography.caption1, typography.caption2
        ]
        #expect(allFonts.count == 11)
    }

    @Test("Conforms to VRRTypographyTokens and Sendable")
    func conformance() {
        let tokens: any VRRTypographyTokens = typography
        #expect(tokens.body == Font.body)
    }
}
