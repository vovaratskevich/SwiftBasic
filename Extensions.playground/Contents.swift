import Foundation


extension String {
    func sayHello() {
        print("Hello")
    }
}

var hello = "Hi"
hello.sayHello()

class Volodya {
    var nick = "The nick"
}

let vova = Volodya()
vova.nick

extension Volodya {
    func allSelf() -> String {
        return "My name \(nick)"
    }
}
vova.allSelf()

struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
}

extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

extension Int {
    subscript(index: Int) -> Int {
        return (self % 10)
    }
}

let rem = 1.5.truncatingRemainder(dividingBy: 10)
print(rem) // 0.3

protocol Togglable {
    mutating func toggle()
}

enum OnOffSwitch: Togglable {
    case off, on
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}
    
var lightSwitch = OnOffSwitch.off
lightSwitch.toggle()
