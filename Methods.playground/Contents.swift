import Foundation

protocol ForClass {
    static func protocolFunc()
}

class SomeClass: ForClass {
    class func someTypeMethod(){
        //здесь идет реализация метода
    }
}
 
SomeClass.someTypeMethod()

extension SomeClass {
    class func someType(){
        
    }
    static func protocolFunc() {
        print("default")
    }
}

SomeClass.protocolFunc()


struct LevelTracker {
    static var highestUnlocked = 1
    var currentlevel = 1
    
    static func unlock(_ level: Int) {
        if level > highestUnlocked {
            highestUnlocked = level
        }
    }
    
    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlocked
    }
    
    @discardableResult mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentlevel = level
            return true
        } else {
            return false
        }
    }
}

class Player {
    var tracker = LevelTracker()
    let playerName: String
    func complete(level: Int) {
        LevelTracker.unlock(level + 1)
        tracker.advance(to: level + 1)
    }
    init(playerName: String) {
        self.playerName = playerName
    }
}

var player = Player(playerName: "Joe")
player.complete(level: 1)
LevelTracker.highestUnlocked


