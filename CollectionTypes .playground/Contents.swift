import Foundation

var threeDoubles = Array(repeating: 3, count: 5)

threeDoubles + [1, 2, 3]

/*
 threeDoubles.count
 threeDoubles.isEmpty
*/
var shoppingList = [String]()
shoppingList.append("Cherry")
shoppingList += ["Eggs", "Cake"]
shoppingList[1...2] = ["Bananas", "Apples"]
shoppingList.insert("New", at: 0)
shoppingList.remove(at: 1)
print(shoppingList)
let apples = shoppingList.removeLast()

for (index, value) in shoppingList.enumerated() {
    print(index, value)
}

var letters = Set<Character>()
letters.insert("a")
letters = []

var favoritGen: Set<String> = ["Rock", "Classical", "Hip hop"]
var favoritGeners: Set = ["Rock", "Classical", "Hip hop"]

favoritGen.removeAll()
favoritGeners.contains("Rock")

let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]
 
oddDigits.union(evenDigits).sorted()
// [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
oddDigits.intersection(evenDigits).sorted()
// []
oddDigits.subtracting(singleDigitPrimeNumbers).sorted()
// [1, 9]
oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted()
// [1, 2, 9]

let houseAnimals: Set = ["собака", "кошка"]
let farmAnimals: Set = ["корова", "курица", "баран", "собака", "кошка"]
let cityAnimals: Set = ["ворона", "мышь"]
 
houseAnimals.isSubset(of: farmAnimals)
// true
farmAnimals.isSuperset(of: houseAnimals)
// true
farmAnimals.isDisjoint(with: cityAnimals)
// true

var airports = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]

if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
  print("The old value for DUB was \(oldValue).")
}
// Выведет "The old value for DUB was Dublin."

if let removedValue = airports.removeValue(forKey: "DUB") {
  print("The removed airport's name is \(removedValue).")
} else {
  print("The airports dictionary does not contain a value for DUB.")
}

airports["NEW"] = "New airport"

for (key, values) in airports {
    if key == "YYZ" {
        print(values)
    }
}
