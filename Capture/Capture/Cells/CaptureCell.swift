import UIKit

class CaptureCell: UITableViewCell {

    @IBOutlet weak var colorIndicator: UIView!
    @IBOutlet weak var numberCapture: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var hexLabel: UILabel!
    @IBOutlet weak var rgbLabel: UILabel!
    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var openImageButtom: UIButton!
    
    var index: Int!
    var capture: Capture!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    func setCell() {
        setColorIndicator()
        setImagePreview()
        setHEX()
        setRGB()
        setNumberCapture()
        setDate()
    }
    
    ///
    func setColorIndicator() {
        colorIndicator.backgroundColor = capture.colorCapture
    }
    
    ///
    func setImagePreview() {
        previewImage.image = capture.imageCapture
        previewImage.layer.cornerRadius = 4.0
        previewImage.clipsToBounds = true
        previewImage.isUserInteractionEnabled = true
    }
    
    ///
    func setHEX() {
        numberCapture.text = ConvertColor.hexStringFromColor(color: capture.colorCapture)
    }
    
    ///
    func setRGB() {
        numberCapture.text = ConvertColor.rgbStringFromColor(color: capture.colorCapture)
    }
    
    ///
    func setNumberCapture() {
        guard let index = self.index else {return}
        numberCapture.text = "#\(index + 1)"
    }
    
    ///
    func setDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        dateLabel.text = dateFormatter.string(from: capture.date)
    }

    ///
    @IBAction func openImage(_ sender: UIButton) {
        NotificationCenter.default.post(name: nShowImage, object: nil, userInfo: ["index": index!])
    }
    
}
