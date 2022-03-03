import UIKit
import AVFoundation
import GoogleMobileAds

class TakePhotoController: UIViewController, AVCapturePhotoCaptureDelegate, GADBannerViewDelegate {
    
    var viewSelf: TakePhotoView! {
        guard isViewLoaded else { return nil }
        return (view as! TakePhotoView)
    }
    
    var captureSession = AVCaptureSession()
    var currentCamera: AVCaptureDevice?
    var sampleBuffer: CMSampleBuffer!
    var currentColor: UIColor!
    var currentImage: UIImage!
    var stateApp: StateApp = .capture
    var bannerView: GADBannerView!
    
    enum StateApp {
        case capture
        case hold
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCaptureSession()
        setDevice()
        setInputOutput()
        startRunningCaptureSession()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setGadBanner()
    }
    
    ///
    func getImageFromSapleBuffer() -> UIImage? {
        guard let smplBuffer = self.sampleBuffer else {return UIImage()}
        if let pixelBuffer = CMSampleBufferGetImageBuffer(smplBuffer) {
            let ciImage = CIImage(cvImageBuffer: pixelBuffer)
            let context = CIContext()
            let imageRect = CGRect(x: 0, y: 0, width: CVPixelBufferGetWidth(pixelBuffer), height: CVPixelBufferGetHeight(pixelBuffer))
            if let image = context.createCGImage(ciImage, from: imageRect) {
                return UIImage(cgImage: image, scale: 1.0, orientation: .right)
            }
        }
        return nil
    }
        
    ///
    func saveCapture(completion: @escaping (Bool) -> ()) {
        guard let pngDataImage: Data = self.currentImage.pngData() else {return}
        guard let pngDataColor: Data = self.currentColor.encode() else {return}
        Archive.createCapture(imageCaptureData: pngDataImage, colorCaptureData: pngDataColor) { capture in
            Archive.addCaptureInArchive(capture: capture) { bool in
                if bool == true {
                    completion(true)
                }
            }
        }
    }
    
    ///
    func holdCapture() {
        captureSession.stopRunning()
        viewSelf.сontinueButton.isHidden = false
        viewSelf.actionButton.setTitle("SAVE", for: .normal)
        stateApp = .hold
        currentImage = RenderImage.render(viewTarget: viewSelf.basicView)
    }
    
    ///
    func saveCapture() {
        saveCapture { bool in
            if bool == true {
                NotificationCenter.default.post(name: nReloadTableArchive, object: nil)
                self.dismiss(animated: true)
            }
        }
    }
    
    ///
    @IBAction func actions(_ sender: UIButton) {
        stateApp == .capture ? holdCapture() : saveCapture()
    }
    
    ///
    @IBAction func сontinueCapture(_ sender: UIButton) {
        stateApp = .capture
        startRunningCaptureSession()
        viewSelf.actionButton.setTitle("HOLD", for: .normal)
        viewSelf.сontinueButton.isHidden = true
    }
    
    ///
    @IBAction func back(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
