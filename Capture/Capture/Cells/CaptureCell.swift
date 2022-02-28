import UIKit

class CaptureCell: UITableViewCell {

    @IBOutlet weak var colorIndicator: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var hexLabel: UILabel!
    @IBOutlet weak var rgbLabel: UILabel!
    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var openImageButtom: UIButton!
    
    var indexCell: Int!
    var capture: Capture!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setCell() {
        setColorIndicator()
        setImagePreview()
        setHEX()
        setRGB()
        setDate()
    }
    
    ///
    func setColorIndicator() {
        colorIndicator.backgroundColor = UIColor.color(data: capture.colorCapture)
    }
    
    ///
    func setImagePreview() {
        previewImage.layer.cornerRadius = 4.0
        previewImage.clipsToBounds = true
        previewImage.isUserInteractionEnabled = true
        previewImage.image = UIImage(data: capture.imageCapture, scale: 1.0)
    }
    
    ///
    func setHEX() {
        hexLabel.text = ConvertColor.hexStringFromColor(color: UIColor.color(data: capture.colorCapture)!)
    }
    
    ///
    func setRGB() {
        rgbLabel.text = ConvertColor.rgbStringFromColor(color: UIColor.color(data: capture.colorCapture)!)
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
        NotificationCenter.default.post(name: nShowImage, object: nil, userInfo: ["index": indexCell!])
    }
    
}
