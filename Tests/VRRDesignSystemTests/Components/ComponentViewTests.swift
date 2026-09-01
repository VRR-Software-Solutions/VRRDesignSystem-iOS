import Testing
import SwiftUI
@testable import VRRDesignSystem

// MARK: - Component View Body Tests

/// These tests verify that all component Views can be instantiated
/// and their body computed without crashing. This catches init issues,
/// missing environment values, and build-time regressions.

@Suite("Component Instantiation")
@MainActor
struct ComponentViewTests {

    // MARK: - VRRCard

    @Test("VRRCard elevated instantiates")
    func cardElevated() {
        let _ = VRRCard(.elevated) {
            Text("Test")
        }
    }

    @Test("VRRCard outlined instantiates")
    func cardOutlined() {
        let _ = VRRCard(.outlined, padding: .large) {
            Text("Test")
        }
    }

    @Test("VRRCard filled instantiates")
    func cardFilled() {
        let _ = VRRCard(.filled, padding: .none) {
            Text("Test")
        }
    }

    // MARK: - VRRBadge

    @Test("VRRBadge all roles instantiate")
    func badgeAllRoles() {
        let roles: [VRRBadgeRole] = [.primary, .secondary, .error, .warning, .success, .info]
        for role in roles {
            let _ = VRRBadge("Test", role: role)
        }
    }

    @Test("VRRBadge all variants instantiate")
    func badgeAllVariants() {
        let _ = VRRBadge("Filled", role: .primary, variant: .filled)
        let _ = VRRBadge("Tinted", role: .primary, variant: .tinted)
        let _ = VRRBadge("Outlined", role: .primary, variant: .outlined)
    }

    @Test("VRRBadge with icon instantiates")
    func badgeWithIcon() {
        let _ = VRRBadge("Icon", role: .warning, icon: Image(systemName: "star"))
    }

    // MARK: - VRRBanner

    @Test("VRRBanner all roles instantiate")
    func bannerAllRoles() {
        let roles: [VRRBannerRole] = [.info, .success, .warning, .error]
        for role in roles {
            let _ = VRRBanner("Message", role: role)
        }
    }

    @Test("VRRBanner with action and dismiss instantiates")
    func bannerWithActionAndDismiss() {
        let _ = VRRBanner(
            "Error",
            role: .error,
            action: ("Retry", {}),
            isDismissable: true,
            onDismiss: {}
        )
    }

    // MARK: - VRRAvatar

    @Test("VRRAvatar all sizes instantiate")
    func avatarAllSizes() {
        let sizes: [VRRAvatarSize] = [.xs, .sm, .md, .lg, .xl]
        for size in sizes {
            let _ = VRRAvatar(initials: "AB", size: size)
        }
    }

    @Test("VRRAvatar with URL instantiates")
    func avatarWithURL() {
        let _ = VRRAvatar(url: URL(string: "https://example.com/image.png"), initials: "AB")
    }

    @Test("VRRAvatar with border instantiates")
    func avatarWithBorder() {
        let _ = VRRAvatar(initials: "CD", size: .xl, showBorder: true)
    }

    // MARK: - VRRDivider

    @Test("VRRDivider horizontal instantiates")
    func dividerHorizontal() {
        let _ = VRRDivider()
    }

    @Test("VRRDivider vertical instantiates")
    func dividerVertical() {
        let _ = VRRDivider(axis: .vertical)
    }

    @Test("VRRDivider with custom thickness and insets")
    func dividerCustom() {
        let _ = VRRDivider(thickness: 2, leadingInset: 16, trailingInset: 8, color: .red)
    }

    // MARK: - VRRSkeleton

    @Test("VRRSkeleton all shapes instantiate")
    func skeletonShapes() {
        let _ = VRRSkeleton(width: 100, height: 16, shape: .rectangle)
        let _ = VRRSkeleton(width: 40, height: 40, shape: .circle)
        let _ = VRRSkeleton(width: 80, height: 24, shape: .capsule)
    }

    @Test("VRRSkeletonRow instantiates")
    func skeletonRow() {
        let _ = VRRSkeletonRow()
        let _ = VRRSkeletonRow(lines: 3, showAvatar: false)
    }

    // MARK: - VRREmptyState

    @Test("VRREmptyState without action instantiates")
    func emptyStateNoAction() {
        let _ = VRREmptyState(
            systemImage: "tray",
            title: "No Items",
            description: "Nothing here."
        )
    }

    @Test("VRREmptyState with action instantiates")
    func emptyStateWithAction() {
        let _ = VRREmptyState(
            systemImage: "wifi.slash",
            title: "Offline",
            description: "Check connection.",
            actionTitle: "Retry"
        ) {}
    }

    // MARK: - VRRLabeledRow

    @Test("VRRLabeledRow with string value instantiates")
    func labeledRowString() {
        let _ = VRRLabeledRow("Name", value: "John")
    }

    @Test("VRRLabeledRow with icon instantiates")
    func labeledRowIcon() {
        let _ = VRRLabeledRow("Email", value: "test@test.com", icon: Image(systemName: "envelope"))
    }

    @Test("VRRLabeledRow with custom value view instantiates")
    func labeledRowCustomView() {
        let _ = VRRLabeledRow("Status") {
            VRRBadge("Active", role: .success, variant: .tinted)
        }
    }
}
