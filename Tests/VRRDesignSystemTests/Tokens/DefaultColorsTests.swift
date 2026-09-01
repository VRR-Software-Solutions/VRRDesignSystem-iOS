import Testing
import SwiftUI
@testable import VRRDesignSystem

// MARK: - Default Color Token Tests

@Suite("VRRDefaultColors")
struct DefaultColorsTests {

    let colors = VRRDefaultColors()

    // MARK: - Brand Colors

    @Test("Brand colors return expected system colors")
    func brandColors() {
        #expect(colors.primary == .blue)
        #expect(colors.secondary == .indigo)
        #expect(colors.tertiary == .purple)
    }

    // MARK: - Semantic State Colors

    @Test("Semantic state colors return expected system colors")
    func semanticStateColors() {
        #expect(colors.error == .red)
        #expect(colors.warning == .orange)
        #expect(colors.success == .green)
        #expect(colors.info == .cyan)
    }

    // MARK: - On-Color Tokens

    @Test("On-color tokens for filled surfaces")
    func onColorTokens() {
        #expect(colors.onPrimary == .white)
        #expect(colors.onSecondary == .white)
        #expect(colors.onTertiary == .white)
        #expect(colors.onError == .white)
    }

    // MARK: - Border & Tint

    @Test("Border focused matches primary")
    func borderFocused() {
        #expect(colors.borderFocused == .blue)
    }

    @Test("Tint matches primary")
    func tint() {
        #expect(colors.tint == .blue)
    }

    // MARK: - Protocol Conformance

    @Test("Conforms to VRRColorTokens and Sendable")
    func conformance() {
        let tokens: any VRRColorTokens = colors
        #expect(tokens.primary == .blue)
    }
}
