import Foundation
import UIKit
import PlaygroundSupport

class QueueTest1 {
    private let serialQueue = DispatchQueue(label: "serialTest")
    private let cuncurrentQueue = DispatchQueue(label: "cuncurrentTest", attributes: .concurrent)
}

class QueueTest2 {
    private let globalQueue = DispatchQueue.global()
    private let mainQueue = DispatchQueue.main
}

var value = "😇"
func changeValue(variant: Int) {
    //sleep(1)
    value += "🤡"
    print("\(value) - \(variant)")
}


let mySerialQueue = DispatchQueue.global(qos: .userInitiated)
mySerialQueue.sync {
    changeValue(variant: 1)
}
value

let mySerialQueue1 = DispatchQueue.global(qos: .utility)
value = "🦊"
mySerialQueue1.sync {
    changeValue(variant: 2)
}
value

//глобальная последовательная main queue
let mainQueue = DispatchQueue.main
//глобальные cocurrent dispatch queues
let userInteractiveQueue = DispatchQueue.global(qos: .userInteractive)
let userQueue = DispatchQueue.global(qos: .userInitiated)
let utilityQueue = DispatchQueue.global(qos: .utility)
let backgroundQueue = DispatchQueue.global(qos: .background)



func task(_ symbol: String) {
    for i in 1...10 {
        print("\(symbol) \(i) priority = \(qos_class_self().rawValue)")
    }
}
func taskHigh(_ symbol: String) {
    print("\(symbol) High priority = \(qos_class_self().rawValue)")
}

//userQueue.sync {
//    task("😄")
//}
//task("😈")

//userQueue.async {
//    task("😄")
//}
//task("😈")

//последовательная очередь MySerialQueue
let MySerialQueue = DispatchQueue(label: "com.bestkora.mySerial")
//let MySerialQueue2 = DispatchQueue(label: "com.bestkora.mySerial")

//MySerialQueue.sync {
//    task("😄")
//}
//task("😈")
//MySerialQueue.async {
//    task("😄")
//}
//task("😈")

let serialPriarityQueue = DispatchQueue(label: "com.bestkora.mySerial", qos: .userInitiated)

//serialPriarityQueue.async {
//    task("😄")
//}
//serialPriarityQueue.async {
//    task("😈")
//}

let serialPriarityQueue1 = DispatchQueue(label: "com.bestkora.mySerial", qos: .userInitiated)
let serialPriarityQueue2 = DispatchQueue(label: "com.bestkora.mySerial", qos: .background)

//serialPriarityQueue2.async {
//    task("😄")
//}
//serialPriarityQueue1.async {
//    task("😈")
//}

let workerQueue = DispatchQueue(label: "com.bestkora", qos: .userInitiated, attributes: .concurrent)
//workerQueue.async {
//    task("😄")
//}
//workerQueue.async {
//    task("😈")
//}

let workerQueue1 = DispatchQueue(label: "com.bestkora", qos: .userInitiated, attributes: .concurrent)
let workerQueue2 = DispatchQueue(label: "com.bestkora", qos: .background, attributes: .concurrent)
//workerQueue2.async {
//    task("😄")
//}
//workerQueue1.async {
//    task("😈")
//}

let workerDelayQueue = DispatchQueue(label: "com.bestkora", qos: .userInitiated, attributes: [.concurrent, .initiallyInactive])
//workerDelayQueue.async {task("😄")}
//workerDelayQueue.async {task("😈")}
//workerDelayQueue.activate()

let highPriorityItem = DispatchWorkItem(qos: .userInteractive, flags: [.enforceQoS]) {
    taskHigh("🍄")
}
let workerQueue3 = DispatchQueue(label: "com.bestkora", qos: .userInitiated, attributes: .concurrent)
let workerQueue4 = DispatchQueue(label: "com.bestkora", qos: .background, attributes: .concurrent)

workerQueue3.async {task("😄")}
workerQueue4.async {task("😈")}
workerQueue4.async(execute: highPriorityItem)
workerQueue3.async(execute: highPriorityItem)

//func fetchImage2() {
//    var data: Data?
//    let queue = DispatchQueue.global(qos: .utility)
//    let workItem = DispatchWorkItem {
//        data = try? Data(contentsOf: imageURL)
//    }
//}

PlaygroundPage.current.needsIndefiniteExecution = true

var view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
var eiffelImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
eiffelImage.backgroundColor = UIColor.yellow
eiffelImage.contentMode = .scaleAspectFit
view.addSubview(eiffelImage)

PlaygroundPage.current.liveView = view

let imageURL = URL(string: "http://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg")!

//загрузка классическим способом

func fetchImage() {
    let queue = DispatchQueue.global(qos: .utility)
    queue.async {
        if let data = try? Data(contentsOf: imageURL) {
            DispatchQueue.main.async {
                eiffelImage.image = UIImage(data: data)
            }
        }
    }
}

func fetchImage1() {
    let task = URLSession.shared.dataTask(with: imageURL) { data, response, error in
        if let imageData = data {
            DispatchQueue.main.async {
                print("show image data")
                eiffelImage.image = UIImage(data: imageData)
            }
            print("did download image data")
        }
    }
    task.resume()
}
