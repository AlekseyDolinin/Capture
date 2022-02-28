import UIKit

class Archive {
    
    static var archiveCaptures = [Capture]()
    
    class func parse(completion: @escaping ([Capture]) -> ()) {
        if let data = UserDefaults.standard.data(forKey: "arrayArchive") {
            do {
                let decoder = JSONDecoder()
                var arrayArchive = try decoder.decode([Capture].self, from: data)
                arrayArchive = arrayArchive.sorted {$0.date > $1.date}
                completion (arrayArchive)
            } catch {
                print("Unable to Decode Notes (\(error))")
            }
        } else {
            completion ([])
        }
    }
    
    ///
    class func saveArchive() {
        print("save: \(Archive.archiveCaptures)")
        DispatchQueue.main.async {
            do {
                let encoder = JSONEncoder()
                let data = try encoder.encode(Archive.archiveCaptures)
                UserDefaults.standard.set(data, forKey: "arrayArchive")
            } catch {
                print("Unable to Encode Note (\(error))")
            }
        }
    }
    
    ///
    class func addCaptureInArchive(capture: Capture, completion: @escaping (Bool) -> ()) {
        Archive.archiveCaptures.append(capture)
        Archive.archiveCaptures.reverse()
        saveArchive()
        completion(true)
    }
    
    ///
    class func createCapture(imageCapture: UIImage, colorCapture: UIColor, completion: @escaping (Capture) -> ()) {
        completion(Capture(date: Date(), imageCapture: imageCapture, colorCapture: colorCapture))
    }
}
