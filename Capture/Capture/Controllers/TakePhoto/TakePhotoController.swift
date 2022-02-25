import UIKit
import AVFoundation

class TakePhotoController: UIViewController, AVCapturePhotoCaptureDelegate {
    
    var viewSelf: TakePhotoView! {
        guard isViewLoaded else { return nil }
        return (view as! TakePhotoView)
    }
    
    var captureSession = AVCaptureSession()
    var currentCamera: AVCaptureDevice?
    var sampleBuffer: CMSampleBuffer!
    var currentColor: UIColor!
    var currentImage: UIImage!
    
    enum StateApp {
        case capture
        case hold
    }
    
    var stateApp: StateApp = .capture
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCaptureSession()
        setDevice()
        setInputOutput()
        startRunningCaptureSession()
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
    func renderCurrentImage() {
        currentImage = UIImage()
    }
    
    ///
    func holdCapture() {
        captureSession.stopRunning()
        viewSelf.сontinueButton.isHidden = false
        viewSelf.actionButton.setTitle("SAVE", for: .normal)
        stateApp = .hold
    }
    
    ///
    func saveColor() {
        self.dismiss(animated: true)
    }
    
    ///
    @IBAction func actions(_ sender: UIButton) {
        stateApp == .capture ? holdCapture() : saveColor()
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
