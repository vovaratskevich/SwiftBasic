import Foundation

struct Header {
    
    enum TitlePosition: String {
        case topLeft = "top left position", center = "centered", topRight = "top right position"
    }
}

let titlePosition = Header.TitlePosition.topRight.rawValue

class Message {
    enum Status {
        case Sent
        case Received
        case Read
    }
    
    var status = Status.Sent
}

let message = Message()
message.status = .Read

class EmailBox {
    var messageStatus: Message.Status?
}

let emailBox = EmailBox()
emailBox.messageStatus = .Read

struct BlackjackCard {
    
    enum Suit: Character {
        case spades = "1"
        case hearts = "2"
        case diamonds = "3"
        case clubs = "4"
    }
    
    enum Rank: Int {
        case two = 2, three, four, five
        case jack, queen, king, ace
        struct Values {
            let first: Int
            let second: Int?
        }
        var values: Values {
            switch self {
            case .ace:
                return Values(first: 1, second: 2)
            case .jack, .queen, .king:
                return Values(first: 10, second: nil)
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
    }
    
    let rank: Rank
    let suit: Suit
    var description: String {
        var output = "suit is \(suit.rawValue)"
        if let second = rank.values.second {
            output += " or \(second)"
        }
        return output
    }
}


var counter = 0

let lock = NSLock()
let dispathcGroup = DispatchGroup()

dispathcGroup.enter()
let thread1 = Thread {
    for _ in 1...10000 {
        counter += 1
    }
    print("leave 1")
    dispathcGroup.leave()
}

dispathcGroup.enter()
let thread2 = Thread {
    for _ in 1...10000 {
        counter += 1
    }
    print("leave 2")
    dispathcGroup.leave()
}

DispatchQueue.global(qos: .userInitiated).sync {
    thread1.start()
    thread2.start()
    
    dispathcGroup.notify(queue: .global(qos: .userInitiated)) {
        print(counter)
    }
}





