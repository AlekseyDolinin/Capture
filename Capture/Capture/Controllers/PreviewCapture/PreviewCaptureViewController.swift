import UIKit
import GoogleMobileAds

class PreviewCaptureViewController: UIViewController, GADInterstitialDelegate {

    var viewSelf: PreviewCaptureView! {
        guard isViewLoaded else { return nil }
        return (view as! PreviewCaptureView)
    }
    
    var capture: Capture!
    var interstitial: GADInterstitial!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSelf.capture = self.capture
        viewSelf.setView()
        addTap()
        setGadFullView()
    }
    
    ///
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        viewSelf.bottomContainer.isHidden = !viewSelf.bottomContainer.isHidden
        viewSelf.topBar.isHidden = !viewSelf.topBar.isHidden
    }
    
    ///
    func addTap() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        viewSelf.previewImageFullScreen.isUserInteractionEnabled = true
        viewSelf.previewImageFullScreen.addGestureRecognizer(tapGestureRecognizer)
    }
        
    ///
    func showControllerShare() {
        viewSelf.topBar.isHidden = true
        let imageForShare = RenderImage.render(viewTarget: viewSelf)
        
        let shareController = UIActivityViewController(activityItems: [imageForShare as Any], applicationActivities: nil)
        shareController.completionWithItemsHandler = {_, bool, _, _ in
            self.viewSelf.topBar.isHidden = false
            bool ? print("it is done!") : print("error send")
        }
        present(shareController, animated: true, completion: nil)
    }
    
    ///
    @IBAction func shareAaction(_ sender: UIButton) {
        if interstitial.isReady == true {
            interstitial.present(fromRootViewController: self)
        } else {
            showControllerShare()
        }
    }
    
    ///
    @IBAction func back(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
