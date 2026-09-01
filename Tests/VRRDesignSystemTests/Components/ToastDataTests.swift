import Testing
import SwiftUI
@testable import VRRDesignSystem

// MARK: - VRRToastData Tests

@Suite("VRRToastData")
struct ToastDataTests {

    @Test("Default init values")
    func defaultInit() {
        let toast = VRRToastData(message: "Hello")
        #expect(toast.message == "Hello")
        #expect(toast.role == .info)
        #expect(toast.icon == nil)
        #expect(toast.duration == 3.0)
    }

    @Test("Custom init values")
    func customInit() {
        let toast = VRRToastData(
            message: "Error",
            role: .error,
            icon: "xmark.circle",
            duration: 5.0
        )
        #expect(toast.message == "Error")
        #expect(toast.role == .error)
        #expect(toast.icon == "xmark.circle")
        #expect(toast.duration == 5.0)
    }

    @Test("Equatable compares message and duration")
    func equatable() {
        let a = VRRToastData(message: "Hello", role: .info, duration: 3.0)
        let b = VRRToastData(message: "Hello", role: .error, duration: 3.0)
        let c = VRRToastData(message: "World", role: .info, duration: 3.0)
        let d = VRRToastData(message: "Hello", role: .info, duration: 5.0)

        #expect(a == b, "Same message + duration should be equal regardless of role")
        #expect(a != c, "Different messages should not be equal")
        #expect(a != d, "Different durations should not be equal")
    }
}
