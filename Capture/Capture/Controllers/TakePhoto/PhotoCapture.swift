import UIKit
import AVFoundation

extension TakePhotoController {
    
    ///
    func setCaptureSession() {
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
    }
    
    ///
    func setDevice() {
        var backCamera: AVCaptureDevice?
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera],
                                                                      mediaType: .video,
                                                                      position: .back)
        let devices = deviceDiscoverySession.devices
        for device in devices {
            if device.position == .back {
                backCamera = device
            }
        }
        currentCamera = backCamera
    }
    
    ///
    func setInputOutput() {
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
            captureSession.addInput(captureDeviceInput)
            let photoOutput = AVCapturePhotoOutput()
            photoOutput.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey : AVVideoCodecType.jpeg])], completionHandler: { (bool, error) in
                print("bool: \(bool)")
                print("error: \(String(describing: error))")
            })
        } catch {
            print(error)
        }
    }
    
    ///
    func startRunningCaptureSession() {
        captureSession.startRunning()
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as NSString):NSNumber(value: kCVPixelFormatType_32BGRA)] as [String : Any]
        dataOutput.alwaysDiscardsLateVideoFrames = true
        if captureSession.canAddOutput(dataOutput) {
            captureSession.addOutput(dataOutput)
        }
        captureSession.commitConfiguration()
        let queue = DispatchQueue(label: "com.alekseydolinin.Capture")
        dataOutput.setSampleBufferDelegate(self, queue: queue)
    }
}
