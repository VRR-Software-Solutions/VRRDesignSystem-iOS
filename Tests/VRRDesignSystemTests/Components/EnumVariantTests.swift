import Testing
import SwiftUI
@testable import VRRDesignSystem

// MARK: - Enum Variant Tests

/// Validates that all public enums have the expected cases and don't
/// accidentally lose members during refactoring.

@Suite("Button Enums")
struct ButtonEnumTests {

    @Test("VRRButtonVariant has 5 cases")
    func variantCases() {
        let cases: [VRRButtonVariant] = [.primary, .secondary, .outlined, .ghost, .destructive]
        #expect(cases.count == 5)
    }

    @Test("VRRButtonSize has 3 cases")
    func sizeCases() {
        let cases: [VRRButtonSize] = [.small, .medium, .large]
        #expect(cases.count == 3)
    }
}

@Suite("TextField Enums")
struct TextFieldEnumTests {

    @Test("VRRTextFieldVariant has 3 cases")
    func variantCases() {
        let cases: [VRRTextFieldVariant] = [.outlined, .filled, .underlined]
        #expect(cases.count == 3)
    }

    @Test("VRRTextFieldState has 4 cases")
    func stateCases() {
        let cases: [VRRTextFieldState] = [.default, .error, .success, .disabled]
        #expect(cases.count == 4)
    }
}

@Suite("Card Enums")
struct CardEnumTests {

    @Test("VRRCardVariant has 3 cases")
    func variantCases() {
        let cases: [VRRCardVariant] = [.elevated, .outlined, .filled]
        #expect(cases.count == 3)
    }

    @Test("VRRCardPadding has 4 cases")
    func paddingCases() {
        let cases: [VRRCardPadding] = [.none, .small, .medium, .large]
        #expect(cases.count == 4)
    }
}

@Suite("Badge Enums")
struct BadgeEnumTests {

    @Test("VRRBadgeVariant has 3 cases")
    func variantCases() {
        let cases: [VRRBadgeVariant] = [.filled, .tinted, .outlined]
        #expect(cases.count == 3)
    }

    @Test("VRRBadgeRole has 6 cases")
    func roleCases() {
        let cases: [VRRBadgeRole] = [.primary, .secondary, .error, .warning, .success, .info]
        #expect(cases.count == 6)
    }
}

@Suite("Banner Enums")
struct BannerEnumTests {

    @Test("VRRBannerRole has 4 cases")
    func roleCases() {
        let cases: [VRRBannerRole] = [.info, .success, .warning, .error]
        #expect(cases.count == 4)
    }
}

@Suite("Toast Enums")
struct ToastEnumTests {

    @Test("VRRToastRole has 4 cases")
    func roleCases() {
        let cases: [VRRToastRole] = [.info, .success, .warning, .error]
        #expect(cases.count == 4)
    }
}

@Suite("Chip Enums")
struct ChipEnumTests {

    @Test("VRRChipVariant has 3 cases")
    func variantCases() {
        let cases: [VRRChipVariant] = [.filter, .input, .suggestion]
        #expect(cases.count == 3)
    }
}

@Suite("Avatar Enums")
struct AvatarEnumTests {

    @Test("VRRAvatarSize has 5 cases")
    func sizeCases() {
        let cases: [VRRAvatarSize] = [.xs, .sm, .md, .lg, .xl]
        #expect(cases.count == 5)
    }
}

@Suite("Skeleton Enums")
struct SkeletonEnumTests {

    @Test("VRRSkeletonShape has 3 cases")
    func shapeCases() {
        let cases: [VRRSkeletonShape] = [.rectangle, .circle, .capsule]
        #expect(cases.count == 3)
    }
}

@Suite("Shape Style Enum")
struct ShapeStyleEnumTests {

    @Test("VRRShapeStyle has 2 cases")
    func cases() {
        let cases: [VRRShapeStyle] = [.rounded, .capsule]
        #expect(cases.count == 2)
    }

    @Test("VRRShapeStyle Equatable")
    func equatable() {
        #expect(VRRShapeStyle.rounded == VRRShapeStyle.rounded)
        #expect(VRRShapeStyle.capsule == VRRShapeStyle.capsule)
        #expect(VRRShapeStyle.rounded != VRRShapeStyle.capsule)
    }
}

@Suite("Shape Role Enum")
struct ShapeRoleEnumTests {

    @Test("VRRShapeRole has 2 cases")
    func cases() {
        let cases: [VRRShapeRole] = [.control, .container]
        #expect(cases.count == 2)
    }

    @Test("VRRShapeRole Equatable")
    func equatable() {
        #expect(VRRShapeRole.control == VRRShapeRole.control)
        #expect(VRRShapeRole.container == VRRShapeRole.container)
        #expect(VRRShapeRole.control != VRRShapeRole.container)
    }
}

@Suite("Text Style Enums")
struct TextStyleEnumTests {

    @Test("VRRTextStyle has 11 cases matching Apple type scale")
    func textStyleCases() {
        let cases: [VRRTextStyle] = [
            .largeTitle, .title1, .title2, .title3,
            .headline, .body, .callout, .subheadline,
            .footnote, .caption, .caption2
        ]
        #expect(cases.count == 11)
    }

    @Test("VRRTextColor has 8 cases")
    func textColorCases() {
        let cases: [VRRTextColor] = [
            .primary, .secondary, .tertiary, .disabled,
            .onPrimary, .error, .success, .custom(.red)
        ]
        #expect(cases.count == 8)
    }
}

@Suite("Progress Enums")
struct ProgressEnumTests {

    @Test("VRRProgressVariant has 2 cases")
    func variantCases() {
        let cases: [VRRProgressVariant] = [.circular, .linear]
        #expect(cases.count == 2)
    }

    @Test("VRRProgressTint has 4 cases")
    func tintCases() {
        let cases: [VRRProgressTint] = [.primary, .secondary, .success, .custom(.red)]
        #expect(cases.count == 4)
    }
}

@Suite("Toggle Enums")
struct ToggleEnumTests {

    @Test("VRRToggleTint has 4 cases")
    func tintCases() {
        let cases: [VRRToggleTint] = [.primary, .secondary, .success, .custom(.red)]
        #expect(cases.count == 4)
    }
}
