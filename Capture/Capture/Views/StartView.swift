import UIKit

class StartView: UIView {
    
    @IBOutlet weak var capturesTable: UITableView!
    @IBOutlet weak var startCaptureButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    

}



extension StartView {
    func setUI() {
        setLabels()

        startCaptureButton.layer.cornerRadius = 8.0
    }
    
    func setLabels() {

    }
}
