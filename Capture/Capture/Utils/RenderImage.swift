import Foundation
import UIKit

class RenderImage {
    
    class func render(viewTarget: UIView) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: viewTarget.bounds.size)
        let imageRender = renderer.image { ctx in
            viewTarget.drawHierarchy(in: viewTarget.bounds, afterScreenUpdates: true)
        }
        return imageRender
    }
}
