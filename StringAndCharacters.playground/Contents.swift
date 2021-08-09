import Foundation

let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"
let dollarSign = "\u{24}"
let testLiteral = #"Line 1\nLine 2"#

var emptyString = ""
var anotherEmptyString = String()

emptyString.isEmpty

for char in "dog" {
    print(char)
}

let exampleChar: Character = "s"
let catCharacters: [Character] = ["C", "a", "t"]
var catString = String(catCharacters)
print(catString)
let newCarString = [Character](catString)

catString += "s"
let exMark: Character = "!"
catString.append(exMark)
catString + String(exMark)

catString.count

catString.map({ (number: Character) -> Character in
    return number
})

for (index, _) in catString.enumerated() {
    print(index)
}

let greeting = "hola"
greeting[greeting.startIndex]
greeting[greeting.index(before: greeting.endIndex)]
greeting[greeting.index(after: greeting.startIndex)]
greeting[greeting.index(greeting.startIndex, offsetBy: 3)]

var welcome = "hello"
welcome.insert("!", at: welcome.endIndex)
welcome.insert(contentsOf: " there", at: welcome.index(before: welcome.endIndex))

welcome.remove(at: welcome.index(before: welcome.endIndex))
let range = welcome.index(welcome.endIndex, offsetBy: -6) ..< welcome.endIndex
welcome.removeSubrange(range)

let greetingNew = "hello world!"
let index = greetingNew.firstIndex(of: ",") ?? greetingNew.endIndex
let beginning = greetingNew[..<index]
let newSring = String(beginning)

let romeoAndJuliet = [
 "Act 1 Scene 1: Verona, A public place",
 "Act 1 Scene 2: Capulet's mansion",
 "Act 1 Scene 3: A room in Capulet's mansion",
 "Act 1 Scene 4: A street outside Capulet's mansion",
 "Act 1 Scene 5: The Great Hall in Capulet's mansion",
 "Act 2 Scene 1: Outside Capulet's mansion",
 "Act 2 Scene 2: Capulet's orchard",
 "Act 2 Scene 3: Outside Friar Lawrence's cell",
 "Act 2 Scene 4: A street in Verona",
 "Act 2 Scene 5: Capulet's mansion",
 "Act 2 Scene 6: Friar Lawrence's cell"
 ]

var act1SceneCount = 0
for scene in romeoAndJuliet {
    if scene.hasPrefix("Act 1") {
        act1SceneCount += 1
    }
}
print("Count of scene in act 1: \(act1SceneCount)")

var mansionCount = 0
var cellCount = 0
for scene in romeoAndJuliet {
    if scene.hasSuffix("Capulet's mansion") {
        mansionCount += 1
    } else if scene.hasSuffix("Friar Lawrence's cell") {
        cellCount += 1
    }
}
print("\(mansionCount) сцен в особняке; \(cellCount) тюремные сцены")
