import UIKit
import PlaygroundSupport
import Foundation

PlaygroundPage.current.needsIndefiniteExecution = true

let imageURL = URL(string: "http://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg")!

class DispatchWorkItem1 {
    private let queue = DispatchQueue(label: "queue1", attributes: .concurrent)
    
    func create() {
        let workItem =  DispatchWorkItem {
            print(Thread.current)
            print("start")
        }
        
        workItem.notify(queue: .main) {
            print(Thread.current)
            print("task finished")
        }
        
        queue.async(execute: workItem)
        
    }
}

let workItem1 = DispatchWorkItem1()
//workItem1.create()

class DispatchWorkItem2 {
    private let queue = DispatchQueue(label: "queue1")
    
    func create() {
        queue.async {
            //sleep(1)
            print(Thread.current)
            print("1")
        }
        
        queue.async {
            //sleep(2)
            print(Thread.current)
            print("2")
        }
        
        let workItem = DispatchWorkItem {
            print(Thread.current)
            print("Start work Item")
        }
        
        queue.async(execute: workItem)
        workItem.cancel()
    }
}

let workItem2 = DispatchWorkItem2()
//workItem2.create()

var view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
var eiffelImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))

eiffelImage.backgroundColor = UIColor.yellow
eiffelImage.contentMode = .scaleToFill
view.addSubview(eiffelImage)

PlaygroundPage.current.liveView = view

func fetchImage1() {
    let queue = DispatchQueue.global()
    queue.async {
        if let data = try? Data(contentsOf: imageURL) {
            DispatchQueue.main.async {
                eiffelImage.image = UIImage(data: data)
            }
        }
    }
}
//fetchImage1()

func fetchImage2() {
    var data: Data?
    let queue = DispatchQueue.global(qos: .utility)
    
    let workItem = DispatchWorkItem(qos: .userInteractive) {
        data = try? Data(contentsOf: imageURL)
        print(Thread.current)
    }
    
    queue.async(execute: workItem)
    workItem.notify(queue: DispatchQueue.main) {
        if let imageData = data {
            eiffelImage.image = UIImage(data: imageData)
        }
    }
}
//fetchImage2()

func fetchImage3() {
    let dataTask = URLSession.shared.dataTask(with: imageURL) { data, response, error in
        print(Thread.current)
        
        if let imageData = data {
            DispatchQueue.main.async {
                eiffelImage.image = UIImage(data: imageData)
            }
        }
    }
    dataTask.resume()
}
fetchImage3()
