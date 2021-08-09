import Foundation

func makeArray<Item>(repeating item: Item, numberOfTimes: Int) -> [Item] {
    var  result = [Item]()
    for _ in 0..<numberOfTimes {
        result.append(item)
    }
    return result
}

makeArray(repeating: { (name: String) -> String in "Hello, \(name)" }, numberOfTimes: 5)
makeArray(repeating: "cool", numberOfTimes: 5)

enum OptionalValue<Wrapped> {
    case none
    case some(Wrapped)
}
var possibleInteger: OptionalValue<Int> = OptionalValue.none
possibleInteger = OptionalValue.some(100)

func anyEl<T: Sequence, U: Sequence>(_ lhs: T, _ rhs: U) -> Bool where T.Element: Equatable, T.Element == U.Element {
    for lhsItem in lhs {
        for rhsItem in rhs {
            if lhsItem == rhsItem {
                return true
            }
        }
    }
    return false
}

anyEl([1, 2, 3], [1, 2, 3])




