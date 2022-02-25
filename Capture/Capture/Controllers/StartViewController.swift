import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func captureColor(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "TakePhotoController") as! TakePhotoController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}
