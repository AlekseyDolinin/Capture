import UIKit

extension StartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Archive.archiveCaptures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let captureCell = tableView.dequeueReusableCell(withIdentifier: "CaptureCell", for: indexPath) as! CaptureCell
        captureCell.capture = Archive.archiveCaptures[indexPath.row]
        captureCell.setCell()
        captureCell.indexCell = indexPath.row
        return captureCell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
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
