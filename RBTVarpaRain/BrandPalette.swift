import SwiftUI

enum BrandPalette {
    static let ink = Color(hex: 0x08120F)
    static let midnight = Color(hex: 0x12201D)
    static let panel = Color(hex: 0x172923)
    static let panelSoft = Color(hex: 0x263B34)
    static let rainBlue = Color(hex: 0x46A6B8)
    static let glowBlue = Color(hex: 0x7DD7E7)
    static let cyan = Color(hex: 0x8BE0D0)
    static let gold = Color(hex: 0xD9B765)
    static let mint = Color(hex: 0x72D494)
    static let coral = Color(hex: 0xE37B64)
    static let clay = Color(hex: 0xA76E45)
    static let white = Color.white
    static let text = Color(hex: 0xF4FAF7)
    static let textSoft = Color(hex: 0xB7CBC3)
    static let textMuted = Color(hex: 0x7A938A)
}

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: alpha
        )
    }
}

extension LinearGradient {
    static let rainSurface = LinearGradient(
        colors: [BrandPalette.panel, BrandPalette.panelSoft],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let rainAction = LinearGradient(
        colors: [BrandPalette.rainBlue, BrandPalette.glowBlue],
        startPoint: .leading,
        endPoint: .trailing
    )
}
