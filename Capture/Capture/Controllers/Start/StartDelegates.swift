import UIKit

extension StartViewController: UITableViewDelegate, UITableViewDataSource {
    ///
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewSelf.descriptionImage.isHidden = Archive.archiveCaptures.isEmpty ? false : true
        viewSelf.title.isHidden = Archive.archiveCaptures.isEmpty ? true : false
        return Archive.archiveCaptures.count
    }
    
    ///
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let captureCell = tableView.dequeueReusableCell(withIdentifier: "CaptureCell", for: indexPath) as! CaptureCell
        captureCell.capture = Archive.archiveCaptures[indexPath.row]
        captureCell.setCell()
        return captureCell
    }
    
    ///
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PreviewCaptureViewController") as! PreviewCaptureViewController
        vc.modalPresentationStyle = .pageSheet
        vc.capture = Archive.archiveCaptures[indexPath.row]
        present(vc, animated: true)
    }
    
    ///
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    ///
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: nil) { (action, view, completion) in
            Archive.archiveCaptures.remove(at: indexPath.row)
            /// запись нового массива
            Archive.saveArchive()
            self.viewSelf.capturesTable.reloadData()
        }
        deleteAction.image = UIImage(named: "trash.png")
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction/*, muteAction*/])
    }
}
