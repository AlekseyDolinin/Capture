import UIKit

class PreviewImageViewController: UIViewController {

    @IBOutlet weak var previewImageFullScreen: UIImageView!

    var previewImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        previewImageFullScreen.image = previewImage
    }
    
    ///
    @IBAction func back(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
