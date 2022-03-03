import UIKit

class TakePhotoView: UIView {
    
    @IBOutlet weak var basicView: UIView!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var indicatorColorView: UIView!
    @IBOutlet weak var indicatorLineColorView: UIView!
    @IBOutlet weak var centerTarget: UIView!
    @IBOutlet weak var previewImageFullScreen: UIImageView!
    @IBOutlet weak var hexLabel: UILabel!
    @IBOutlet weak var rgbLabel: UILabel!
    @IBOutlet weak var bottomContainer: UIView!
    @IBOutlet weak var verticalCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var сontinueButton: UIButton!
    @IBOutlet weak var actionButton: UIButton!
        
    var currentColor: UIColor!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    
    ///
    func updateDataColors() {
        colorView.backgroundColor = currentColor
        indicatorColorView.backgroundColor = currentColor
        indicatorLineColorView.layer.borderColor = currentColor.cgColor
        ///
        hexLabel.text = ConvertColor.hexStringFromColor(color: currentColor)
        rgbLabel.text = ConvertColor.rgbStringFromColor(color: currentColor)
    }
}



extension TakePhotoView {
    func setUI() {
        setLabels()
        ///
        indicatorLineColorView.backgroundColor = .clear
        centerTarget.backgroundColor = .clear
        centerTarget.layer.borderColor = UIColor.white.cgColor
        ///
        centerTarget.layer.cornerRadius = 4.0
        centerTarget.layer.borderWidth = 1.0
        indicatorLineColorView.layer.borderWidth = 3.0
        indicatorColorView.layer.cornerRadius = indicatorColorView.frame.height / 2
        indicatorLineColorView.layer.cornerRadius = indicatorLineColorView.frame.height / 2
        actionButton.layer.cornerRadius = 8.0
        сontinueButton.layer.cornerRadius = 8.0
        
        сontinueButton.isHidden = true
        
        let delta = bottomContainer.frame.height / 2
        verticalCenterConstraint.constant = verticalCenterConstraint.constant - delta
    }
    
    func setLabels() {
        сontinueButton.setTitle("СONTINUE", for: .normal)
        actionButton.setTitle("HOLD", for: .normal)
    }
}
