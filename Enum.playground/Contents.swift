import Foundation

enum Social: Double, CaseIterable {
    case steam = 4.7
    case twitter = 4.3
    case instagram = 3.9
}

for platforms in Social.allCases {
    print(platforms)
}

enum SocialPlatform {
    case steam(followersType: FollowersType)
    case twitter(followers: Int)
    case instagram(followers: Int)
    case linkedIn
    
    enum FollowersType {
        case newby
        case member
        case fullMember
    }
}

let followersValue = SocialPlatform.steam(followersType: .newby)
let newFollowersValue = SocialPlatform.FollowersType.newby

func getEligibility(for platform: SocialPlatform) {
    switch platform {
    case .instagram(let followers) where followers > 10_000:
        print("Inst Eligibility")
    case .twitter(let followers) where followers > 2_000:
        print("Twitter Eligibility")
    case .steam, .linkedIn, .instagram, .twitter:
        print("Not Eligibility")
    }
}

getEligibility(for: .twitter(followers: 15000))

func getNumber() -> Int {
    print("Fetching number...")
    return 5
}

func printStatement(_ result: () -> Bool) {
    //print("Here is the number: \(result())")
    print("Nothing to see here.")
}

printStatement(){() -> Bool in getNumber() == 5 }

enum Cars {
    case BMW(color: Colors, maxSpeed: Int)
    case WV(color: Colors, maxSpeed: Int)
    case Toyota(color: Colors, maxSpeed: Int)
    
    enum Colors {
        case red
        case black
    }
}

var garage = [Cars]()
garage.append(.BMW(color: .black, maxSpeed: 290))
garage.append(.WV(color: .red, maxSpeed: 330))
garage.append(.Toyota(color: .red, maxSpeed: 350))

func printCars(_ cars: [Cars]) {
    for (i, car) in cars.enumerated() {
        print(i)
    }
}
printCars(garage)

enum Beverage: CaseIterable {
   case coffee, tea, juice
    case water, smuzi
}
let numberOfChoices = Beverage.allCases.count
for i in Beverage.allCases {
    print(i)
}

enum Barcode {
    case upc(Int, Int, Int, Int)
    case qeCode(String)
}

var productBarcode = Barcode.qeCode("FKJFLFASAFKN")
productBarcode = Barcode.upc(8, 85909, 51226, 3)

switch productBarcode {
    case let .upc(num1, num2, num3, num4):
    print("UPC: \(num1), \(num2), \(num3), \(num4).")
case .qeCode(let qeString):
    print(qeString)
}

enum ASCIChar: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriage = "\r"
    
    init?(rawValue: Int) {
        switch rawValue {
        case 0:
            self = .tab
        case 1:
            self = .lineFeed
        case 2:
            self = .carriage
        default:
            return nil
        }
    }
}

let asciValue = ASCIChar.tab.rawValue
let newAsci = ASCIChar(rawValue: 0)
newAsci?.rawValue

//Recursive Enum

enum ArithmeticExp {
    case number(Int)
    indirect case addition(ArithmeticExp, ArithmeticExp)
    indirect case multiplication(ArithmeticExp, ArithmeticExp)
}

indirect enum ArithmeticExpression {
    case number(Int)
    case addition(ArithmeticExpression, ArithmeticExpression)
    case multiplication(ArithmeticExpression, ArithmeticExpression)
}

let three = ArithmeticExpression.number(3)
let one = ArithmeticExpression.number(1)
let sum = ArithmeticExpression.addition(three, one)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

func evaluate(_ exp: ArithmeticExpression) -> Int {
    switch exp {
    case .number(let value):
        return value
        
        
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}

evaluate(product)
