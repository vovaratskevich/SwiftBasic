import UIKit
import PlaygroundSupport
import Foundation

PlaygroundPage.current.needsIndefiniteExecution = true

class DispatchGroupTest1 {
    private let queueSerial = DispatchQueue(label: "queue1")
    
    private let groupRed = DispatchGroup()
    
    func loadMethod() {
        queueSerial.async(group: groupRed) {
            sleep(1)
            print(1)
        }
        queueSerial.async(group: groupRed) {
            sleep(1)
            print(2)
        }
        groupRed.notify(queue: .main) {
            print("groupRed finished")
        }
    }
}
let groupTest1 = DispatchGroupTest1()
//groupTest1.loadMethod()

class DispatchGroupTest2 {
    private let queueCuncurrent = DispatchQueue(label: "queue3", attributes: .concurrent)
    
    private let groupBlack = DispatchGroup()
    
    func loadMethod() {
        groupBlack.enter()
        queueCuncurrent.async {
            sleep(1)
            print(1)
            self.groupBlack.leave()
        }
        groupBlack.enter()
        queueCuncurrent.async {
            sleep(1)
            print(2)
            self.groupBlack.leave()
        }
        groupBlack.wait()
   //     print("finished")
        groupBlack.notify(queue: .main) {
            print("groupRed finished")
        }
    }
}
let groupTest2 = DispatchGroupTest2()
//groupTest2.loadMethod()

class EightImage: UIView {
    public var ivs = [UIImageView]()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        ivs.append(UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100)))
        ivs.append(UIImageView(frame: CGRect(x: 0, y: 100, width: 100, height: 100)))
        ivs.append(UIImageView(frame: CGRect(x: 100, y: 0, width: 100, height: 100)))
        ivs.append(UIImageView(frame: CGRect(x: 100, y: 100, width: 100, height: 100)))
        
        ivs.append(UIImageView(frame: CGRect(x: 0, y: 300, width: 100, height: 100)))
        ivs.append(UIImageView(frame: CGRect(x: 100, y: 300, width: 100, height: 100)))
        ivs.append(UIImageView(frame: CGRect(x: 0, y: 400, width: 100, height: 100)))
        ivs.append(UIImageView(frame: CGRect(x: 100, y: 400, width: 100, height: 100)))
        for i in 0...7 {
            ivs[i].contentMode = .scaleAspectFit
            self.addSubview(ivs[i])
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("error")
    }
}

var view = EightImage(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
view.backgroundColor = UIColor.red

let imageURLs = ["http://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg",
                 "http://adriatic-lines.com/wp-content/uploads/2015/04/canal-of-Venice.jpg",
                 "http://bestkora.com/IosDeveloper/wp-content/uploads/2016/12/Screen-Shot-2017-01-17-at-9.33.52-PM.png",
                 "http://www.picture-newsletter.com/arctic/arctic-12.jpg"]
var images = [UIImage]()

PlaygroundPage.current.liveView = view

func asyncLoadImage(imageURL: URL, runQueue: DispatchQueue, complitionQueue: DispatchQueue, complition: @escaping (UIImage?, Error?) -> ()) {
    runQueue.async {
        do {
            let data = try Data(contentsOf: imageURL)
            complitionQueue.async {
                complition(UIImage(data: data), nil)
            }
        } catch let error {
            complitionQueue.async {
                complition(nil, error)
            }
        }
    }
}

func asyncGroup() {
    let aGroup = DispatchGroup()
    
    for i in 0...2 {
        aGroup.enter()
        asyncLoadImage(imageURL: URL(string: imageURLs[i ])!,
                       runQueue: .global(),
                       complitionQueue: .main) { result, error in
            guard let image1 = result else {
                return
            }
            images.append(image1)
            aGroup.leave()
        }
    }
    aGroup.notify(queue: .main) {
        for i in 0...2 {
            view.ivs[i].image = images[i]
        }
    }
}
func asyncUrlSession() {
    for i in 4...7 {
        let url = URL(string: imageURLs[i - 4])
        let request = URLRequest(url: url!)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                view.ivs[i].image = UIImage(data: data!)
            }
        }
        task.resume()
    }
}
asyncGroup()
//asyncUrlSession()
