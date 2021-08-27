import Foundation

let arr: Array = [Int]()

func swapToInts<W>(_ a: inout W, _ b: inout W) {
    let temp = a
    a = b
    b = temp
}

var someInt = 3
var anotherInt = 107
swapToInts(&someInt, &anotherInt)
someInt

struct Stack<Element> {
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

var stackOfStrings = Stack<Any>()
stackOfStrings.push(1)
stackOfStrings.push(3)
stackOfStrings.pop()

extension Stack {
    var topItem: Element? {
        items.isEmpty ? nil: items[items.count - 1]
    }
}

if let topItem = stackOfStrings.topItem {
  //  print(topItem)
}

func findIndex<T: Equatable>(ofString valueToFind: T, in array: [T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let str = ["cat", "dog", "lama", "parakeet", "terrapin"]
if let foundIndex = findIndex(ofString: "lama", in: str) {
    print(foundIndex)
}

protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int {get}
    subscript(i: Int) -> Item { get }
}

//struct NewStr: Container {
//
//    typealias Item = String
//
//    var count: Int
//
//    mutating func append(_ item: String) {
//        <#code#>
//    }
//
//    subscript(i: Int) -> String {
//        <#code#>
//    }
//}

struct SecondStack<Element>: Container {
    
    typealias Item = Element
    
    var items = [Element]()
    
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() {
        items.removeLast()
    }
    
    var count: Int {
        items.count
    }
    
    mutating func append(_ item: Element) {
        self.push(item)
    }
    
    subscript(i: Int) -> Element {
        items[i]
    }
}

var newStack = SecondStack<Int>()

protocol SuffixableContainer: Container {
    associatedtype Suffix: SuffixableContainer where Suffix.Item == Item
    func suffix(_ size: Int) -> Suffix
}

extension SecondStack: SuffixableContainer {
    func suffix(_ size: Int) -> SecondStack {
        var result = SecondStack()
        for index in (count - size)..<count {
            result.append(self[index])
        }
        return result
    }
}

var stackOfInts = SecondStack<Int>()
stackOfInts.append(10)
stackOfInts.append(20)
stackOfInts.append(30)
let suffix = stackOfInts.suffix(2)

func allItemsMatch<C1: Container, C2: Container>(_ someContainer: C1, _ anotherContainer: C2) -> Bool where C1.Item == C2.Item, C1.Item: Equatable {
    if someContainer.count != anotherContainer.count {
        return false
    }
    
    for i in 0..<someContainer.count {
        if someContainer[i] != anotherContainer[i] {
            return false
        }
    }
    return true
}

var stackOfStrings2 = SecondStack<String>()
stackOfStrings2.push("UNO")
stackOfStrings2.push("DOS")
stackOfStrings2.push("TRES")

var arrayOfStrings = ["UNO", "DOS", "TRES"]

//if allItemsMatch(stackOfStrings2, arrayOfStrings) {
//    print("all item is match")
//} else {
//    print("Not all items match")
//}

protocol Countable {
    associatedtype Absolute: Numeric
    var absolute: Absolute { get }
}

protocol Wallet {
    associatedtype Currency: Countable where Currency.Absolute == Double
    var cash: [Currency] { get }
}

struct Bitcoin: Countable {
    typealias Absolute = Double
    
    var absolute: Absolute
}

struct BitcoinWallet: Wallet {
    typealias Currency = Bitcoin
    
    var cash: [Currency]
}


