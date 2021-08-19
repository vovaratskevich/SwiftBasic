import UIKit
import PlaygroundSupport
import Foundation

PlaygroundPage.current.needsIndefiniteExecution = true

//let queue = DispatchQueue(label: "queue1", attributes: .concurrent)
//
//let semaphore = DispatchSemaphore(value: 0)
//
//queue.async {
//    semaphore.wait() // value -1
//    sleep(1)
//    print("method1")
//    semaphore.signal()
//}
//
//queue.async {
//    semaphore.wait() // value -1
//    sleep(1)
//    print("method2")
//    semaphore.signal()
//}
//
//queue.async {
//    semaphore.wait() // value -1
//    sleep(1)
//    print("method3")
//    semaphore.signal()
//}
//
//let sem = DispatchSemaphore(value: 0)
//
//DispatchQueue.concurrentPerform(iterations: 10) { (id: Int) in
//    sem.wait()
//    sleep(1)
//    print(Thread.current)
//    print("Block", String(id))
//    sem.signal()
//}

class SemaphoreTest {
    private var semaphore = DispatchSemaphore(value: 1)
    private var array = [Int]()
    
    private func methodWork(_ id: Int) {
        semaphore.wait()
        array.append(id)
        print("\(id) is added. Count: \(array.count)")
        Thread.sleep(forTimeInterval: 1)
        semaphore.signal()
    }
    func startAllThread() {
        DispatchQueue.global().async {
            self.methodWork(111)
            print(Thread.current)
        }
        DispatchQueue.global().async {
            self.methodWork(15)
            print(Thread.current)
        }
        DispatchQueue.global().async {
            self.methodWork(73)
            print(Thread.current)
        }
        DispatchQueue.global().async {
            self.methodWork(95)
            print(Thread.current)
        }
        DispatchQueue.global().async {
            self.methodWork(173)
            print(Thread.current)
        }
    }
}

let semaphore = SemaphoreTest()
semaphore.startAllThread()
