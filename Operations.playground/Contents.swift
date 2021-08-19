import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

let operation1 =  {
    print("Operation 1 started")
    print("Operation 1 finished")
}

let queue = OperationQueue()
queue.addOperation(operation1)
//print("s")

var result: String?
let concatenationOperation = BlockOperation {
    result = "hey" + "joe"
}

let myQueue = DispatchQueue(label: "serial")

func firstMethod() {
    print("A")
    myQueue.sync {
        print("B")
    }
    print("C")
}
firstMethod()

//aibfghced
