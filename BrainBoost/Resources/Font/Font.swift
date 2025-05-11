import UIKit

// Family: Manrope, Font names: ["Manrope-Regular", "Manrope-Medium", "Manrope-SemiBold", "Manrope-Bold", "Manrope-ExtraBold"]

struct Font {
    let font: UIFont

    static func getFont(fontType: FontType, size: CGFloat) -> UIFont {
        let font = UIFont(name: fontType.rawValue, size: size)
        return font ?? .systemFont(ofSize: 16)
    }
}

enum FontType: String {
    case regular = "Manrope-Regular"
    case medium = "Manrope-Medium"
    case bold = "Manrope-Bold"
}

extension Font {
    static let heading = Font(font: getFont(fontType: .bold, size: 30))
    static let subtitle = Font(font: getFont(fontType: .medium, size: 15))
    static let caption = Font(font: getFont(fontType: .medium, size: 13))
}
