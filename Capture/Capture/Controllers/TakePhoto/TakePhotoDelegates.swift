import AVFoundation
import UIKit

extension TakePhotoController: AVCaptureVideoDataOutputSampleBufferDelegate {
    ///
    func captureOutput(_ output: AVCaptureOutput, didOutput buffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        self.sampleBuffer = buffer
        
        DispatchQueue.main.async {
            let imageFromBuffer = self.getImageFromSapleBuffer()
            self.viewSelf.previewImageFullScreen.image = imageFromBuffer
            let position = (imageFromBuffer?.size.height)! / 2
            let delta = self.viewSelf.bottomContainer.frame.height / 2 + 24
            self.currentColor = imageFromBuffer?.getPixelColor(pos: CGPoint(x: position - delta, y: position))
            self.viewSelf.currentColor = self.currentColor
            self.viewSelf.updateDataColors()
        }
    }
}
