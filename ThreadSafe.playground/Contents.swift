import UIKit
import Foundation


public func duration(_ block: () -> ()) -> TimeInterval {
    let startTime = Date()
    block()
    return Date().timeIntervalSince(startTime)
}

public class QueuesView: UIView {
    public var labels: [UILabel] = [UILabel] ()
    public var labels_: [UILabel] = [UILabel] ()
    public var numberLines = 0 {didSet{updateUI()}}
    public var step = 30
    
    func updateUI(){
        print (numberLines)
        for i in 0..<numberLines {
            let label = UILabel (frame: CGRect(x: 10, y: 20 + 50 * i, width: Int(self.bounds.size.width), height: 20))
            label.text = ""
            labels.append (label)
            self.addSubview(label)
            
            let label_ = UILabel (frame: CGRect(x: 0, y: 50 * i, width: Int(self.bounds.size.width), height: 20))
            label_.text = ""
            label_.textColor = UIColor.blue
            labels_.append (label_)
            self.addSubview(label_)
        }
    }
    
    public override init (frame: CGRect) {
        super.init (frame: frame)
        updateUI()
    }
    
   public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class ThreadSafeString {
    private var internalString = ""
    //очередь изоляции
    let isolationQueue = DispatchQueue(label: "newQueue", attributes: .concurrent)
    
    func addString(string: String) {
        isolationQueue.async(flags: .barrier) {
            self.internalString += string
        }
    }
    
    func setString(string: String) {
        isolationQueue.async(flags: .barrier) {
            self.internalString = string
        }
    }
    
    init(_ string: String) {
        isolationQueue.async(flags: .barrier) {
            self.internalString = string
        }
    }
    
    var text: String {
        var result = ""
        isolationQueue.sync {
            result = self.internalString
        }
        return result
    }
}

let main = DispatchQueue.main // Глобальная последовательная (serial) main queue

let userQueue = DispatchQueue.global(qos: .userInitiated)  // Глобальная  concurrent.userInitiated dispatch queue
let utilityQueue = DispatchQueue.global(qos: .utility)  // Глобальная concurrent .utility dispatch queue
let background = DispatchQueue.global() // Глобальная concurrent .default dispatch queue


var safeString = ThreadSafeString("")
var usualString = ""

func task(_ symbol: String) {
    for i in 1...10 {
        print("\(symbol) \(i) priority = \(qos_class_self().rawValue)")
        safeString.addString(string: symbol)
        usualString += symbol
        
    }
}

func taskHigh(_ symbol: String) {
    print("\(symbol) High priority = \(qos_class_self().rawValue)")
    safeString.addString(string: symbol)
    usualString += symbol
}

let duration0 = duration {
    DispatchQueue.global().async {
        task("🐞")
    }
    task("🦞")
}

safeString.text + String(Float(duration0))
print(safeString.text)
print(usualString)
