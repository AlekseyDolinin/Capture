import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var versionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        versionLabel.text = GetVersionApp.get()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "StartViewController")
            self.navigationController?.pushViewController(vc!, animated: false)
        }
    }
}
