import UIKit
import PlaygroundSupport
import Foundation

PlaygroundPage.current.needsIndefiniteExecution = true

open class AsyncOperation: Operation {
    public enum State: String {
        case ready, executing, finished
        
        fileprivate var keyPath: String {
            return "is" + rawValue.capitalized
        }
    }
    
    public var state = State.ready {
        willSet {
            willChangeValue(forKey: newValue.keyPath)
            willChangeValue(forKey: state.keyPath)
        }
        didSet {
            didChangeValue(forKey: oldValue.keyPath)
            didChangeValue(forKey: state.keyPath)
        }
    }
}

extension AsyncOperation {
    override open var isReady: Bool {
        return super.isReady && state == .ready
    }
    
    override open var isExecuting: Bool {
        return state == .executing
    }
    
    override open var isFinished: Bool {
        return state == .finished
    }
    
    override open var isAsynchronous: Bool {
        return true
    }
    
    override open func start() {
        if isCancelled {
            state = .finished
            return
        }
        
        main()
        state = .executing
    }
    
    override open func cancel() {
        super.cancel()
        state = .finished
    }
}

public func asyncAdd(lhs: Int, rhs: Int, callback: @escaping (Int) -> ()) {
    let additionQueue = OperationQueue()
    additionQueue.addOperation {
        sleep(1)
        callback(lhs + rhs)
    }
}

class SumOperation: AsyncOperation {
    let lhs: Int
    let rhs: Int
    var result: Int?
    
    init(lhs: Int, rhs: Int) {
        self.lhs = lhs
        self.rhs = rhs
        super.init()
    }
    
    override func main() {
        asyncAdd(lhs: lhs, rhs: rhs) { result in
            self.result = result
            self.state = .finished
        }
    }
}


let additionalQueue = OperationQueue()

let input = [(1,5), (5,7), (3,9)]

for (lhs, rhs) in input {
    let operation = SumOperation(lhs: lhs, rhs: rhs)
    operation.completionBlock = {
        guard let result = operation.result else {return}
        print("\(lhs) + \(rhs) = \(result)")
    }
    additionalQueue.addOperation(operation)
}

func topAndBottomGradient(size: CGSize, clearLocations: [CGFloat] = [0.35, 0.65], innerIntensity: CGFloat = 0.5) -> UIImage {
  
  let context = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: 8, bytesPerRow: 0, space: CGColorSpaceCreateDeviceGray(), bitmapInfo: CGImageAlphaInfo.none.rawValue)

  let colors = [
    .white,
    UIColor(white: innerIntensity, alpha: 1.0),
    .black,
    UIColor(white: innerIntensity, alpha: 1.0),
    .white
    ].map { $0.cgColor }
  let colorLocations : [CGFloat] = [0, clearLocations[0], (clearLocations[0] + clearLocations[1]) / 2.0, clearLocations[1], 1]
  
  let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceGray(), colors: colors as CFArray, locations: colorLocations)
  
  let startPoint = CGPoint(x: 0, y: 0)
  let endPoint = CGPoint(x: 0, y: size.height)
  
  context?.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: CGGradientDrawingOptions())
  let cgImage = context!.makeImage()
  
  return UIImage(cgImage: cgImage!)

}

public func filterImage(image: UIImage?) -> UIImage? {
    guard let image = image else { return .none }
    sleep(1)
    let mask = topAndBottomGradient(size: image.size)
    return mask
}

func asyncImageLoad(urlString: String?,callback: @escaping (UIImage?) -> ()) {
    guard let urlString = urlString,
          let imageURL = URL(string: urlString) else { return callback (nil) }
    
    let task = URLSession.shared.dataTask(with: imageURL){
        (data, response, error) in
        if let data = data {
            callback (UIImage(data: data))
        }
    }
    task.resume()
}

class ImageLoadOperation: AsyncOperation {
    var urlString: String?
    var outputImage: UIImage?
    
    init(urlString: String?) {
        self.urlString = urlString
        super.init()
    }
    override func main() {
        asyncImageLoad (urlString: self.urlString) { [unowned self] (image) in
            self.outputImage = image
            self.state = .finished
        }
    }
}

protocol ImagePass {
    var image: UIImage? {get}
}

extension ImageLoadOperation: ImagePass {
    var image: UIImage? {return outputImage}
}

class FilterOperation: Operation {
    var otputImage: UIImage?
    private let _inputImage: UIImage?
    
    init(_ image: UIImage?) {
        _inputImage = image
        super.init()
    }
    
    var inputImage: UIImage? {
        var image: UIImage?
        if let inputImage = _inputImage {
            image = inputImage
        } else if let dataProvider = dependencies
                    .filter({ $0 is ImagePass})
                    .first as? ImagePass {
                    image = dataProvider.image
        }
        return image
    }
    
    override func main() {
        otputImage = filterImage(image: inputImage)
    }
}

let urlString = "http://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg"
let imageLoad = ImageLoadOperation(urlString:  urlString)
let filter = FilterOperation(nil)

filter.addDependency(imageLoad)

let queue = OperationQueue()
queue.addOperations([imageLoad, filter], waitUntilFinished: true)

imageLoad.outputImage
filter.otputImage


fileprivate var lastStartTime = Date()

public func startClock(){
  lastStartTime = Date()
}

public func stopClock() -> TimeInterval {
  return Date().timeIntervalSince(lastStartTime)
}


public func slowAdd(_ input: (Int, Int)) -> Int {
  sleep(1)
  return input.0 + input.1
}

public func slowAddArray(_ input: [(Int, Int)],
                         progress: ((Double) -> (Bool))? = nil) -> [Int] {
  var results = [Int]()
  for pair in input {
    results.append(slowAdd(pair))
    if let progress = progress {
      if !progress(Double(results.count) / Double(input.count)) { return results }
    }
  }
  return results
}


class ArraySumOperation: Operation {
    let inputArray: [(Int, Int)]
    var outputArray = [Int]()
    
    init(input: [(Int,Int)]) {
        inputArray = input
        super.init()
    }
    
    override func main() {
        for pair in inputArray {
            if isCancelled {return}
            outputArray.append(slowAdd(pair))
        }
    }
}

let numberArr = [(1, 2), (3, 4), (5, 6)]

let sumOperation = ArraySumOperation(input: numberArr)
let sumQueue = OperationQueue()



startClock()
queue.addOperation(sumOperation)

sleep(2)
sumOperation.cancel()

sumOperation.completionBlock = {
    stopClock()
    sumOperation.outputArray
    PlaygroundPage.current.finishExecution()
}
