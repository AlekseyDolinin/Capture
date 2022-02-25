import UIKit

class ConvertColor {
    ///
    class func hexStringFromColor(color: UIColor) -> String {
        let components = color.cgColor.components
        let r: CGFloat = components?[0] ?? 0.0
        let g: CGFloat = components?[1] ?? 0.0
        let b: CGFloat = components?[2] ?? 0.0
        let hexString = String.init(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
        return "HEX: \(hexString)"
    }
    
    ///
    class func rgbStringFromColor(color: UIColor) -> String {
        let ciColor = CIColor(color: color)
        let redValue: Int = Int(ciColor.red * 255)
        let greenValue: Int = Int(ciColor.green * 255)
        let blueValue: Int = Int(ciColor.blue * 255)
        return "R: \(redValue)  G: \(greenValue)  B: \(blueValue)"
    }
}
