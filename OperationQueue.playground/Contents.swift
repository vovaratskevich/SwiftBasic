import UIKit
import PlaygroundSupport
import Foundation

PlaygroundPage.current.needsIndefiniteExecution = true

//let block1 = {
//    print("Start")
//    print("Finish")
//}
//
//var operationQueue = OperationQueue()
//operationQueue.addOperation(block1)

//var result: String?
//let cocncatOperation = BlockOperation {
//    result = "result"
//    print(Thread.current)
//}

//cocncatOperation.start()
//print(result!)

//let queue = OperationQueue()
//queue.addOperation{
//    print("test")
//}

class MyThread: Thread {
    override func main() {
        print("test main thread")
    }
}

let myThread = MyThread()
//myThread.start()


class OperationA: Operation {
    override func main() {
        print(Thread.current)
        print("test operation")
    }
}

let operationA = OperationA()
//operationA.start()

let queue1 = OperationQueue()
//queue1.addOperation(operationA)

let operationQueue1 = OperationQueue()

class OperationCancelTest: Operation {
    override func main() {
        if isCancelled {
            print( isCancelled)
            return
        }
        print("test1")
        sleep(1)
        
        if isCancelled {
            print(isCancelled)
            return
        }
        print("test2")
    }
}

func cancelOperationMethod() {
    let cancelOperation = OperationCancelTest()
    operationQueue1.addOperation(cancelOperation)
    cancelOperation.cancel()
}
//cancelOperationMethod()

class WaitOperationTest {
    private let operationQueue = OperationQueue()
    
    func test() {
        operationQueue.addOperation {
            sleep(1)
            print("test1")
        }
        operationQueue.addOperation {
            sleep(1)
            print("test2")
        }
        operationQueue.waitUntilAllOperationsAreFinished()
        operationQueue.addOperation {
            print("test3")
        }
        operationQueue.addOperation {
            print("test4")
        }
    }
}

let waitOperationTest = WaitOperationTest()
//waitOperationTest.test()

class WaitOperationTest2 {
    private let operationQueue = OperationQueue()
    
    func test() {
        let operation1 = BlockOperation {
            sleep(1)
            print(1)
        }
        let operation2 = BlockOperation {
            sleep(2)
            print(2)
        }
        
        operationQueue.addOperations([operation1, operation2], waitUntilFinished: true)
    }
}

let waitOperationTest2 = WaitOperationTest2()
//waitOperationTest2.test()

class ComplitionBlockTest {
    private let operationQueue = OperationQueue()
    
    func test() {
        let operation1 = BlockOperation {
            print("test complition")
        }
        operation1.completionBlock = {
            print("finished")
        }
        operationQueue.addOperation(operation1)
    }
}
let complitionBlockTest = ComplitionBlockTest()
//complitionBlockTest.test()

var str: String?
let concatenationOp = BlockOperation {
    str = "operation"
}
concatenationOp.start()
//str

class FilterOperation: Operation {
    var inputImage: UIImage?
    var outputImagage: UIImage?
    
    override func main() {
       // outputImagage = filter(image: inputImage)
    }
}

//let operation3

let printerQueue = OperationQueue()

printerQueue.maxConcurrentOperationCount = 3

let concOp = BlockOperation {
    print("💧💧💧")
    sleep(1)
}
concOp.qualityOfService = .userInitiated

printerQueue.addOperation { print("🙈"); sleep(1)}
printerQueue.addOperation { print("🪳"); sleep(1)}
printerQueue.addOperation { print("🐐"); sleep(1)}
printerQueue.addOperation { print("🌚"); sleep(1)}
printerQueue.addOperation { print("✨"); sleep(1)}

printerQueue.addOperation(concOp)

//printerQueue.waitUntilAllOperationsAreFinished()
