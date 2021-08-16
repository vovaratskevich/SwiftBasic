import Foundation

let n = 5
var i = 0
while (i <= n) {
    
    i += 1
}

repeat {
    //
} while (i <= n)

let minutes = 60
let minuteInterval = 5
for trickMark in stride(from: 0, to: minutes, by: minuteInterval) {
    print(trickMark)
}

var desk = [Int]()
let countOfCell = 25
var countPosition = 0
var newIndex = 1
var cube = 0

print("Creating desk with \(countOfCell) cubes")
//creating desk
while (newIndex <= countOfCell) {
    desk.append(newIndex)
    newIndex += 1
}
print("Desk's created. Game start!")

repeat {
    cube = Int.random(in: 1..<7)
    print("Cube value: \(cube)")
    countPosition += cube
    switch countPosition {
    case 3:
        countPosition += 8
    case 6:
        countPosition += 11
    case 9:
        countPosition += 9
    case 10:
        countPosition += 2
    case 14:
        countPosition -= 10
    case 19:
        countPosition -= 11
    case 22:
        countPosition -= 2
    case 24:
        countPosition -= 8
    default:
        countPosition += 0
    }
    print("Current position: \(countPosition)")
} while (countPosition < 1)
print("Game Over")

let intToDesc = 5
var desc = "The number \(intToDesc) is"
switch  intToDesc {
case 2,3,5,7,11,13,17,19:
    desc += " a prime number, and also"
    fallthrough
default:
    desc += " an int"
}
print(desc)

func greet(person: [String: String]) {
    guard let name = person["name"] else {
        return
    }
    print("Hey, \(name)")
    guard let location = person["location"] else {
        print("Hope, its nice day")
        return
    }
    print("Hope in \(location) a good whether")
}

greet(person: ["name": "John"])
greet(person: ["name": "John", "location": "Cupertino"])
