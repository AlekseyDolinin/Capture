import UIKit

extension StartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Archive.archiveCaptures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let captureCell = tableView.dequeueReusableCell(withIdentifier: "CaptureCell", for: indexPath) as! CaptureCell
        captureCell.capture = Archive.archiveCaptures[indexPath.row]
        captureCell.setCell()
        captureCell.index = indexPath.row
        return captureCell
    }
}
