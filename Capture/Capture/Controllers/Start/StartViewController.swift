import UIKit

class StartViewController: UIViewController {

    var viewSelf: StartView! {
        guard isViewLoaded else { return nil }
        return (view as! StartView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSelf.capturesTable.delegate = self
        viewSelf.capturesTable.dataSource = self
        
        Archive.parse { bool in
            if bool == true {
                self.viewSelf.capturesTable.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(forName: nReloadTableArchive, object: nil, queue: nil) { notification in
            self.viewSelf.capturesTable.reloadData()
        }
        
        NotificationCenter.default.addObserver(forName: nShowImage, object: nil, queue: nil) { notification in
            guard let index = notification.userInfo?["index"] else {return}
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PreviewImageViewController") as! PreviewImageViewController
            vc.modalPresentationStyle = .pageSheet
            vc.previewImage = UIImage(data: Archive.archiveCaptures[index as! Int].imageCapture, scale: 1.0)
            self.present(vc, animated: true)
        }
    }
    
    ///
    @IBAction func captureColor(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "TakePhotoController") as! TakePhotoController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}
