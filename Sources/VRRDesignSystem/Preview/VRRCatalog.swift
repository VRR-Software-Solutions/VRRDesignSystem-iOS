import SwiftUI

// MARK: - Component Catalog

/// A full visual catalog of all VRRDesignSystem components.
///
/// Open this file in Xcode and use Canvas (⌘+Option+P) to preview
/// every component in one scrollable view. Useful for:
/// - Auditing theme overrides visually
/// - Onboarding teammates to the design system
/// - Catching visual regressions
///
/// Two previews are provided:
/// 1. **Default Theme** — standard rounded corners
/// 2. **Capsule Theme** — pill/capsule shapes on every component
@available(iOS 18.0, macOS 15.0, *)
#Preview("VRR — Default (Rounded)") {
    VRRCatalogView()
}

@available(iOS 18.0, macOS 15.0, *)
#Preview("VRR — Capsule Controls") {
    VRRCatalogView()
        .vrrTheme(VRRCapsulePreviewTheme())
}

// MARK: - Capsule Preview Theme

/// A theme that makes `.control` elements capsule-shaped while keeping
/// `.container` surfaces (cards, banners) rounded — the correct capsule pattern.
@available(iOS 18.0, macOS 15.0, *)
private struct VRRCapsulePreviewTheme: VRRTheme, Sendable {
    var colors: any VRRColorTokens { VRRDefaultColors() }
    var typography: any VRRTypographyTokens { VRRDefaultTypography() }
    var spacing: any VRRSpacingTokens { VRRDefaultSpacing() }
    var radius: any VRRRadiusTokens { CapsuleControlsRadius() }
    var elevation: any VRRElevationTokens { VRRDefaultElevation() }
    var animation: any VRRAnimationTokens { VRRDefaultAnimation() }
    var opacity: any VRROpacityTokens { VRRDefaultOpacity() }
}

private struct CapsuleControlsRadius: VRRRadiusTokens, Sendable {
    var sm: CGFloat { 4 }
    var md: CGFloat { 8 }
    var lg: CGFloat { 12 }
    var xl: CGFloat { 20 }
    var full: CGFloat { 9999 }
    var usesContinuousCorners: Bool { true }

    func shape(for role: VRRShapeRole) -> VRRShapeStyle {
        switch role {
        case .control:   return .capsule   // pill buttons, chips, fields, badges
        case .container: return .rounded   // cards & banners stay rounded
        }
    }
}

// MARK: - Catalog View

@available(iOS 18.0, macOS 15.0, *)
struct VRRCatalogView: View {

    @Environment(\.vrrTheme) private var theme

    @State private var toggleOn = true
    @State private var toggleOff = false
    @State private var textValue = ""
    @State private var chipSelected = true
    @State private var chipUnselected = false
    @State private var toast: VRRToastData?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                shapeIndicator
                colorsSection
                typographySection
                buttonsSection
                textFieldSection
                toggleSection
                cardSection
                badgeSection
                chipSection
                avatarSection
                bannerSection
                progressSection
                dividerSection
                skeletonSection
                emptyStateSection
                toastSection
            }
            .padding(24)
        }
        .vrrToast($toast)
    }

    // MARK: - Shape Indicator

    private var shapeIndicator: some View {
        let controlIsCapsule = theme.radius.shape(for: .control) == .capsule
        let containerIsCapsule = theme.radius.shape(for: .container) == .capsule
        return HStack(spacing: 8) {
            Image(systemName: controlIsCapsule ? "capsule.fill" : "rectangle.roundedtop.fill")
                .foregroundStyle(theme.colors.primary)
            VStack(alignment: .leading, spacing: 2) {
                Text("Controls: \(controlIsCapsule ? "Capsule" : "Rounded")")
                    .vrrText(.subheadline)
                Text("Containers: \(containerIsCapsule ? "Capsule" : "Rounded")")
                    .vrrText(.subheadline, color: .secondary)
            }
        }
        .padding(theme.spacing.sm)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(theme.colors.primary.opacity(0.08), in: RoundedRectangle(
            cornerRadius: theme.radius.effectiveRadius(theme.radius.md, for: .container),
            style: theme.radius.cornerStyle
        ))
    }

    // MARK: - Colors

    private var colorsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionHeader("Colors")

            LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))], spacing: 8) {
                colorSwatch("Primary", color: \.primary)
                colorSwatch("Secondary", color: \.secondary)
                colorSwatch("Tertiary", color: \.tertiary)
                colorSwatch("Error", color: \.error)
                colorSwatch("Warning", color: \.warning)
                colorSwatch("Success", color: \.success)
                colorSwatch("Info", color: \.info)
                colorSwatch("Surface", color: \.surface)
                colorSwatch("Border", color: \.border)
            }
        }
    }

    private func colorSwatch(_ name: String, color keyPath: KeyPath<any VRRColorTokens, Color>) -> some View {
        ColorSwatchView(name: name, keyPath: keyPath)
    }

    // MARK: - Typography

    private var typographySection: some View {
        VStack(alignment: .leading, spacing: 8) {
            sectionHeader("Typography")

            Text("Large Title").vrrText(.largeTitle)
            Text("Title 1").vrrText(.title1)
            Text("Title 2").vrrText(.title2)
            Text("Title 3").vrrText(.title3)
            Text("Headline").vrrText(.headline)
            Text("Body").vrrText(.body)
            Text("Callout").vrrText(.callout)
            Text("Subheadline").vrrText(.subheadline, color: .secondary)
            Text("Footnote").vrrText(.footnote, color: .secondary)
            Text("Caption 1").vrrText(.caption, color: .tertiary)
            Text("Caption 2").vrrText(.caption2, color: .tertiary)
        }
    }

    // MARK: - Buttons

    private var buttonsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionHeader("Buttons")

            Text("Variants").vrrText(.subheadline, color: .secondary)
            HStack(spacing: 12) {
                Button("Primary") {}.buttonStyle(.vrr(.primary))
                Button("Secondary") {}.buttonStyle(.vrr(.secondary))
                Button("Outlined") {}.buttonStyle(.vrr(.outlined))
            }

            HStack(spacing: 12) {
                Button("Ghost") {}.buttonStyle(.vrr(.ghost))
                Button("Destructive") {}.buttonStyle(.vrr(.destructive))
                Button("Disabled") {}.buttonStyle(.vrr(.primary)).disabled(true)
            }

            Text("Sizes").vrrText(.subheadline, color: .secondary)
            VStack(spacing: 8) {
                Button("Small") {}.buttonStyle(.vrr(.primary, size: .small))
                Button("Medium") {}.buttonStyle(.vrr(.primary, size: .medium))
                Button("Large") {}.buttonStyle(.vrr(.primary, size: .large))
                Button("Full Width") {}.buttonStyle(.vrr(.primary, size: .large, fullWidth: true))
            }
        }
    }

    // MARK: - Text Fields

    private var textFieldSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionHeader("Text Fields")

            TextField("Outlined", text: $textValue)
                .textFieldStyle(.vrr(.outlined))

            TextField("Filled", text: $textValue)
                .textFieldStyle(.vrr(.filled))

            TextField("Underlined", text: $textValue)
                .textFieldStyle(.vrr(.underlined))

            TextField("Error State", text: $textValue)
                .textFieldStyle(.vrr(.outlined, state: .error))

            VRRTextField(
                "With Label & Helper",
                text: $textValue,
                prompt: "Enter email",
                state: .default,
                helperText: "We'll never share your email.",
                leadingIcon: Image(systemName: "envelope")
            )
        }
    }

    // MARK: - Toggles

    private var toggleSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionHeader("Toggles")

            Toggle("Primary Toggle (On)", isOn: $toggleOn)
                .toggleStyle(.vrr)

            Toggle("Secondary Toggle", isOn: $toggleOff)
                .toggleStyle(.vrr(tint: .secondary))

            Toggle("Disabled", isOn: .constant(true))
                .toggleStyle(.vrr)
                .disabled(true)
        }
    }

    // MARK: - Cards

    private var cardSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionHeader("Cards")

            VRRCard(.elevated) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Elevated Card").vrrText(.headline)
                    Text("With shadow and surface background.").vrrText(.body, color: .secondary)
                }
            }

            VRRCard(.outlined) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Outlined Card").vrrText(.headline)
                    Text("Border only, no shadow.").vrrText(.body, color: .secondary)
                }
            }

            VRRCard(.filled) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Filled Card").vrrText(.headline)
                    Text("Secondary surface, no border.").vrrText(.body, color: .secondary)
                }
            }
        }
    }

    // MARK: - Badges

    private var badgeSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionHeader("Badges")

            HStack(spacing: 8) {
                VRRBadge("Primary", role: .primary)
                VRRBadge("Error", role: .error)
                VRRBadge("Warning", role: .warning)
                VRRBadge("Success", role: .success)
                VRRBadge("Info", role: .info)
            }

            HStack(spacing: 8) {
                VRRBadge("Tinted", role: .primary, variant: .tinted)
                VRRBadge("Outlined", role: .error, variant: .outlined)
                VRRBadge("Icon", role: .warning, icon: Image(systemName: "star.fill"))
            }
        }
    }

    // MARK: - Chips

    private var chipSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionHeader("Chips")

            HStack(spacing: 8) {
                VRRChip("Selected", isSelected: $chipSelected)
                VRRChip("Unselected", isSelected: $chipUnselected)
                VRRChip("With Icon", isSelected: $chipSelected, icon: Image(systemName: "tag"))
            }

            HStack(spacing: 8) {
                VRRChip("Dismissable", variant: .input, onDismiss: {})
                VRRChip("Suggestion", variant: .suggestion, onTap: {})
            }
        }
    }

    // MARK: - Avatar

    private var avatarSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionHeader("Avatars")

            HStack(spacing: 16) {
                VRRAvatar(initials: "XS", size: .xs)
                VRRAvatar(initials: "SM", size: .sm)
                VRRAvatar(initials: "MD", size: .md)
                VRRAvatar(initials: "LG", size: .lg)
                VRRAvatar(initials: "XL", size: .xl, showBorder: true)
            }
        }
    }

    // MARK: - Banners

    private var bannerSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionHeader("Banners")

            VRRBanner("This is an informational message.", role: .info)
            VRRBanner("Changes saved successfully!", role: .success)
            VRRBanner("Your trial expires in 3 days.", role: .warning)
            VRRBanner(
                "Unable to load data.",
                role: .error,
                action: ("Retry", {}),
                isDismissable: true,
                onDismiss: {}
            )
        }
    }

    // MARK: - Progress

    private var progressSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionHeader("Progress")

            HStack(spacing: 24) {
                ProgressView().progressViewStyle(.vrr)
                ProgressView().progressViewStyle(.vrr(.circular, tint: .secondary))
            }

            ProgressView(value: 0.65)
                .progressViewStyle(.vrr(.linear))

            ProgressView(value: 0.4)
                .progressViewStyle(.vrr(.linear, tint: .success))
        }
    }

    // MARK: - Divider

    private var dividerSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionHeader("Dividers")

            VRRDivider()
            VRRDivider(leadingInset: 16)
            VRRDivider(thickness: 2)
        }
    }

    // MARK: - Skeleton

    private var skeletonSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionHeader("Skeleton / Loading")

            VRRSkeletonRow()
            VRRSkeletonRow(lines: 3, showAvatar: false)

            HStack(spacing: 8) {
                VRRSkeleton(width: 60, height: 60, shape: .circle)
                VStack(alignment: .leading, spacing: 6) {
                    VRRSkeleton(width: 140, height: 16)
                    VRRSkeleton(width: 200, height: 14)
                }
            }
        }
    }

    // MARK: - Empty State

    private var emptyStateSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionHeader("Empty State (ContentUnavailableView)")

            VRREmptyState(
                systemImage: "tray",
                title: "No Messages",
                description: "When you receive messages, they'll appear here.",
                actionTitle: "Compose"
            ) {}
                .frame(height: 280)
                .background(Color.gray.opacity(0.05))
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }

    // MARK: - Toast

    private var toastSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionHeader("Toast")

            HStack(spacing: 8) {
                Button("Info") {
                    toast = VRRToastData(message: "Item added to cart", role: .info)
                }.buttonStyle(.vrr(.outlined, size: .small))

                Button("Success") {
                    toast = VRRToastData(message: "Saved!", role: .success)
                }.buttonStyle(.vrr(.outlined, size: .small))

                Button("Error") {
                    toast = VRRToastData(message: "Something went wrong", role: .error)
                }.buttonStyle(.vrr(.outlined, size: .small))
            }
        }
    }

    // MARK: - Helpers

    private func sectionHeader(_ title: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .vrrText(.title2)
            VRRDivider()
        }
    }
}

// MARK: - Color Swatch Helper

@available(iOS 18.0, macOS 15.0, *)
private struct ColorSwatchView: View {

    @Environment(\.vrrTheme) private var theme

    let name: String
    let keyPath: KeyPath<any VRRColorTokens, Color>

    var body: some View {
        VStack(spacing: 4) {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(theme.colors[keyPath: keyPath])
                .frame(width: 48, height: 48)
                .overlay(
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .strokeBorder(Color.gray.opacity(0.2), lineWidth: 0.5)
                )
            Text(name)
                .font(.system(size: 9))
                .foregroundStyle(.secondary)
                .lineLimit(1)
        }
    }
}
