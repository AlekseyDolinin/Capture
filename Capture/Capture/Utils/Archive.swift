import UIKit

class Archive {
    
    static var archiveCaptures = [Capture]()
    
    class func parse(completion: @escaping (Bool) -> ()) {
        print("parse")
        if let data = UserDefaults.standard.data(forKey: "arrayArchive") {
            print("data: \(data)")
            do {
                let decoder = JSONDecoder()
                let arrayArchive = try decoder.decode([Capture].self, from: data)
                print("arrayArchive: \(arrayArchive)")
                Archive.archiveCaptures = arrayArchive.sorted {$0.date > $1.date}
                print("captures: \(Archive.archiveCaptures)")
                completion (true)
            } catch {
                print("Unable to Decode Notes (\(error))")
            }
        } else {
            completion (false)
        }
    }
    
    ///
    class func saveArchive() {
        print("save: \(Archive.archiveCaptures)")
        DispatchQueue.main.async {
            do {
                let encoder = JSONEncoder()
                let data = try encoder.encode(Archive.archiveCaptures)
                print("data: \(data)")
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
    class func createCapture(imageCaptureData: Data, colorCaptureData: Data, completion: @escaping (Capture) -> ()) {
        completion(Capture(date: Date(), imageCapture: imageCaptureData, colorCapture: colorCaptureData))
    }
    

}
