import Foundation

struct Faren {
    var temp: Double
    //дефолтное значение
    var some = 3
    //исходное значение в инициализаторе
    init() {
        temp = 32.0
    }
}

var faren = Faren()

struct Celsius {
    var temperatureIntCels: Double
    init(fromFaren faren: Double) {
        temperatureIntCels = (faren - 32 / 1.8)
    }
    init(fromKelvin kelvin: Double) {
        temperatureIntCels = kelvin  - 273
    }
}
let boiling = Celsius(fromFaren: 212)
let freezing = Celsius(fromKelvin: 273)

class SurveyQuestion {
    let text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}

let cheese = SurveyQuestion(text: "Do u like Cheese???")
cheese.ask()
cheese.response = "Yes"

class SuperClass {
    var surname = "sdsd"
    
    init(surname: String) {
        self.surname = surname
    }
    
}

class ShoppingListItem: SuperClass {
    var name: String?
    var quantity = 1
    var purchased = false
    
    init(name: String, surname: String) {
        super.init(surname: surname)
    }
}
var item = ShoppingListItem(name: "sd", surname: "sf")

class NamedShape {
    var name: String

    init(name: String) {
        self.name = name
    }
}
class Square: NamedShape {
    var sideLength: Double

    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
    }
}

struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    init() {
    }
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let basicRect = Rect()
let originRect = Rect(origin: Point(x: 3, y: 3), size: Size(width: 5, height: 5))
let centerRect = Rect(center: Point(x: 7.0, y: 7.0), size: Size(width: 3, height: 3))

class Animal {
    var numberOfLegs: Int
    init(numberOfLegs: Int) {
        self.numberOfLegs = numberOfLegs
    }
    
    convenience init(type: String) {
        let number = type == "bird" ? 2 : 4
        self.init(numberOfLegs: number)
    }
}

let animal = Animal(type: "bird")

class Wolf: Animal {
    var hasFur: Bool
    init(hasFur: Bool, numberOfLegs: Int) {
        self.hasFur = hasFur
        super.init(numberOfLegs: numberOfLegs)
    }
}
let wolf = Wolf(hasFur: true, numberOfLegs: 3)

class Note {
    var number: String
    init?(number: String) {
        if number.count < 11 {
            return nil
        }
        self.number = number
    }
}

if let note = Note(number: "123456789") {
    type(of: note)
}

class UserScreen {
    var title: String
    
    required init(title: String) {
        self.title = title
    }
}

class ProfileScreen: UserScreen {
    var background: String
    init(background: String) {
        self.background = background
        super.init(title: "Profile Screen")
    }
    
    required init(title: String) {
        background = "black"
        super.init(title: title)
    }
}

class A {
    var valueA: String
    init(valueA: String){
        self.valueA = valueA
    }
}

class B: A {
    var valueB: String
    init(valueB: String, valueA: String){
        self.valueB = valueB
        super.init(valueA: valueA)
    }
    convenience init(number: Int) {
        let value = String(number)
        self.init(valueB: value, valueA: value)
    }
}

class C: B {
    var valueC: String
    init(valueC: String, valueB: String, valueA: String) {
        self.valueC = valueC
        super.init(valueB: valueB, valueA: valueA)
    }
}

var c = C(valueC: "C", valueB: "B", valueA: "A")

class Vehicle {
    var numberOfWheels = 0
    var desc: String {
        return "\(numberOfWheels) wheels"
    }
}

class Bicycle: Vehicle {
    override init() {
        super.init()
        numberOfWheels = 2
    }
}

let bicycle = Bicycle()
print("Bicycle: \(bicycle.desc)")

class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init() {
        self.init(name: "[Unnamed]")
    }
    
//    convenience init(number: Int){
//        //let name = self.name + String(number)
//        self.init(name: name)
//    }
}

let namedMeat = Food(name: "Bacon")
let unnamedMeat = Food()

class RecipeIngridient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}



struct ExchangeRatesSum: Decodable {
    
    var downloadDate: String?
    var rates: [Rates]?
}

struct Rates: Decodable {
    
    var currMnemFrom: String?
    var currMnemTo: String?
    var buy: String?
    var sale: String?
}
 
let one = Rates(currMnemFrom: "Test", currMnemTo: "Test", buy: "Test", sale: "Test")
let two = Rates(currMnemFrom: "Test", currMnemTo: "Test", buy: "Test", sale: "Test")
let three = Rates(currMnemFrom: "Test", currMnemTo: "Test", buy: "Test", sale: "Test")

var mass = [Rates]()
mass.append(one)
mass.append(two)
mass.append(three)


let sum = ExchangeRatesSum(downloadDate: "111", rates: mass)

let newValue = [ExchangeRatesSum]()

print(newValue)

let sss = sum.rates

class SomeClass {
    required init() {
        
    }
}

class SomeSubclass: SomeClass {
    required init() {
        
    }
}

//замыкания в свойствах

struct Chessboard {
    let boardColors: [Bool] = {
       var tempBoard = [Bool]()
       var isBlack = false
        for i in 1...8 {
            for j in 1...8 {
                tempBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return tempBoard
    }()
    func squareIsBlackAt(row: Int, column: Int) -> Bool {
        return boardColors[(row * 8) + column]
    }
}

let board = Chessboard()
print(board.squareIsBlackAt(row: 0, column: 1))
print(board.squareIsBlackAt(row: 7, column: 7))

class FileManager {
    
    init() {
        print("start")
    }
    
    deinit {
        print("file closed")
    }
}

func workWithFileManager() {
    var fileManager = FileManager()
}

workWithFileManager()

class Bank {
    
    static var money = 100_000
    
    static func giveMoney(moneyForPlayer: Int) -> Int {
        let correctMoney = min(moneyForPlayer, money)
        money -= correctMoney
        return correctMoney
    }
    
    static func takeMoney(money: Int) {
        self.money += money
    }
}

class Player {
    var money: Int = 0
    
    func getMoneyForIteration() {
        print("finished circle")
        money = Bank.giveMoney(moneyForPlayer: 2000)
    }
    
    deinit {
        print("game over")
        Bank.takeMoney(money: money)
    }
}

func playMonopoly() {
    let player = Player()
    player.getMoneyForIteration()
    player.getMoneyForIteration()
    player.getMoneyForIteration()
}

playMonopoly()
