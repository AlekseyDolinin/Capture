import UIKit

class PreviewCaptureView: UIView {
    
    @IBOutlet weak var basicView: UIView!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var indicatorColorView: UIView!
    @IBOutlet weak var indicatorLineColorView: UIView!
    @IBOutlet weak var previewImageFullScreen: UIImageView!
    @IBOutlet weak var hexLabel: UILabel!
    @IBOutlet weak var rgbLabel: UILabel!
    @IBOutlet weak var bottomContainer: UIView!
    @IBOutlet weak var topBar: UIView!
    
    var capture: Capture!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    
    func setView() {
        guard let currentColor: UIColor = UIColor.color(data: capture.colorCapture) else {return}
        colorView.backgroundColor = currentColor
        indicatorColorView.backgroundColor = currentColor
        indicatorLineColorView.layer.borderColor = currentColor.cgColor
        ///
        hexLabel.text = ConvertColor.hexStringFromColor(color: currentColor)
        rgbLabel.text = ConvertColor.rgbStringFromColor(color: currentColor)
        ///
        previewImageFullScreen.image = UIImage(data: capture.imageCapture, scale: 1.0)
    }
    
}

extension PreviewCaptureView {
    func setUI() {
        ///
        indicatorLineColorView.backgroundColor = .clear
        ///
        indicatorLineColorView.layer.borderWidth = 3.0
        indicatorColorView.layer.cornerRadius = indicatorColorView.frame.height / 2
        indicatorLineColorView.layer.cornerRadius = indicatorLineColorView.frame.height / 2
    }
}
