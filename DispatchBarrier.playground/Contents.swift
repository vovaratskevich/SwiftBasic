import UIKit
import PlaygroundSupport
import Foundation

PlaygroundPage.current.needsIndefiniteExecution = true

var arr = [Int]()

//for i in 0...9 {
//    arr.append(i)
//}
//print(arr)
//print(arr.count)

//DispatchQueue.concurrentPerform(iterations: 10) { index in
//    arr.append(index)
//}
//
//print(arr)
//print(arr.count)

class SafeArr<T> {
    private var array = [T]()
    private let queue = DispatchQueue(label: "queue1", attributes: .concurrent)
    
    public func append(_ value: T) {
        queue.async(flags: .barrier) {
            self.array.append(value)
        }
    }
    
    public var valueArr: [T] {
        var result = [T]()
        queue.sync {
            result = self.array
        }
        return result
    }
}

var arrSafe = SafeArr<Int>()
DispatchQueue.concurrentPerform(iterations: 10) { index in
    arrSafe.append(index)
}

print("arrSafe: ", arrSafe.valueArr)
print("arrSafeCount: ", arrSafe.valueArr.count)
