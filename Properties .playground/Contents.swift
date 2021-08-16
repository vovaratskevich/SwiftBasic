import Foundation

class DataImporter {
    /*
     DataImporter - класс для импорта данных из внешних источников
     Считаем, что классу требуется большое количество времени для инициализации
     */
    var fileName = "data.txt"
    // класс DataImporter функционал данных будет описан тут
}
class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
    // класс DataManager обеспечит необходимую функциональность тут
}
 
let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")
// экземпляр класса DataImporter для свойства importer еще не создано

print(manager.importer.fileName)
// экземпляр DataImporter для свойства importer только что был создан
// Выведет "data.txt"

struct Point {
    var x = 0.0
    var y = 0.0
}

struct Size {
    var width = 0.0
    var hith = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var number = 0
    var numberValue = 1
    var center: Point  {
        get {
            let centerX = origin.x + (size.width/2)
            let centerY = origin.y + (size.hith/2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width/2)
            origin.y = newCenter.y - (size.hith/2)
        }
    }
    var coputedVar: Int {
        get {
            return number + numberValue
        }
        set {
            
        }
    }
}

var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 10, hith: 10))
let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)
print(("square.origin is now at (\(square.origin.x), \(square.origin.y))"))

class StepCounter{
    var totalSteps: Int = 0 {
        willSet(newTotalSteps){
            print("Вот-вот значение будет равно \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue {
                print("Добавлено \(totalSteps - oldValue) шагов")
            }
        }
    }
}
let stepCounter = StepCounter()
stepCounter.totalSteps = 200
stepCounter.totalSteps = 360
stepCounter.totalSteps = 896

@propertyWrapper
struct TwelveOrLess {
    private var number = 0
    var wrappedValue: Int {
        get {number}
        set {
            number = min(newValue, 12)
            print("set \(newValue)")
        }
    }
}

struct SmallRectangle {
    @TwelveOrLess var height: Int
    @TwelveOrLess var width: Int
}

var rectangle = SmallRectangle()
print(rectangle.height)

var rect1 = SmallRectangle()
rect1.width = 15



struct NewSmallRectangle {
    private var _height = TwelveOrLess()
    private var _width = TwelveOrLess()
    var height: Int {
        get { return _height.wrappedValue }
        set { _height.wrappedValue = newValue }
    }
    var width: Int {
        get { return _width.wrappedValue }
        set { _width.wrappedValue = newValue }
    }
}
var NewRectangle = NewSmallRectangle()
NewRectangle.height = 15
print(NewRectangle.height)

@propertyWrapper
struct SmallNumber {
    private var maximum: Int
    private var number: Int
    
    var wrappedValue: Int {
        get {number}
        set {number = min(newValue, maximum)}
    }
    
    init() {
        maximum = 12
        number = 0
    }
    init(wrappedValue: Int) {
        maximum = 12
        number = min(wrappedValue, maximum)
    }
    init(wrappedValue: Int, maximum: Int) {
        self.maximum = maximum
        number = min(wrappedValue, maximum)
    }
}

struct ZeroRect {
    @SmallNumber(wrappedValue: 2) var height
    @SmallNumber(maximum: 11) var width: Int = 1
}
var zeroRect = ZeroRect()
print(zeroRect.height, zeroRect.width)
zeroRect.width = 100
print(zeroRect.height, zeroRect.width)

struct SomeStruct {
    static var storedType = "Some value"
    static var computedType: Int {
        get {1}
        set {SomeStruct.storedType = String(newValue)}
    }
}
enum SomeEnum {
    static var storedType = "Some value"
    static var computedType: Int {
        return 6
    }
    static var new = "s"
}

class SomeClass {
    static var storedType = "Some value"
    static var computedType: Int {
        return 27
    }
    class var overridableComputedType: Int {
        return 5
    }
}

class NewClass: SomeClass {
    static var ss: Int {
        3
    }
    static var newComputed: Int {
        computedType/ss
    }
    func newFunc (){
    }
}

SomeStruct.storedType
SomeStruct.computedType
SomeStruct.computedType = 3

var exInstance = SomeStruct()

SomeClass.overridableComputedType

NewClass.newComputed
NewClass.computedType
NewClass.overridableComputedType

var newInstance = NewClass()

class Account {
    
    var capital: Double
    var rate: Double
    
    static var usdRate: Double = 69
    
    init(capital: Double, rate: Double) {
        
        self.capital = capital
        self.rate = rate
    }
    
    func convert() -> Double {
        capital/Account.usdRate
    }
}

var myAcc = Account(capital: 99.9, rate: 0.3)
var capitalInUsd = myAcc.convert()
Account.usdRate = 65
capitalInUsd = myAcc.convert()

struct AudioChannel {
    static let thresholdLevel = 10
    static var maxInput = 0
    
    var currentLevel: Int = 0 {
        didSet {
            if currentLevel > AudioChannel.thresholdLevel {
                currentLevel = AudioChannel.thresholdLevel
            }
            if currentLevel > AudioChannel.maxInput {
                AudioChannel.maxInput = currentLevel
            }
        }
    }
}


