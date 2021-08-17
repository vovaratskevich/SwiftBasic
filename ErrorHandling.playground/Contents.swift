import Foundation

enum VendingMAchineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

//throw VendingMAchineError.insufficientFunds(coinsNeeded: 5)

func canThrowErrors() throws {}
func cannotThrowErrors() {}

struct Item {
    var price: Int
    var count: Int
}

class VendingMAchine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11),
    ]
    var coinsDeposited = 0
    
    func vend(itemNamed name: String) throws {
        guard  let item = inventory[name] else {
            throw VendingMAchineError.invalidSelection
        }
        
        guard item.count > 0 else {
            throw VendingMAchineError.outOfStock
        }
        
        guard item.price <= coinsDeposited else {
            throw VendingMAchineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        
        coinsDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        
        print("Dispensing \(name)")
    }
}

let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
]
func buyFavoriteSnack(person: String, vendingMachine: VendingMAchine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)
}

struct PurchasedSnack {
    let name: String
    init(name: String, vendingMachine: VendingMAchine) throws {
        try vendingMachine.vend(itemNamed: name)
        self.name = name
    }
}
let vending = VendingMAchine()
let snack = try? PurchasedSnack(name: "Bob", vendingMachine: vending)
print(snack ?? "nothing")


var vendingMachine = VendingMAchine()
vendingMachine.coinsDeposited = 10
do {
    try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
    print("Success! Yum.")
} catch VendingMAchineError.invalidSelection {
    print("Invalid Selection")
} catch VendingMAchineError.outOfStock {
    print("Out of Stock")
} catch VendingMAchineError.insufficientFunds(let coinsNeeded) {
    print("Insufficient fund. Please insert an additional \(coinsNeeded) coins")
} catch {
    print("Unexpected error: \(error)")
}

func nourish(with item: String) throws {
    do {
        try vendingMachine.vend(itemNamed: item)
    } catch is VendingMAchineError {
        print("couldnt")
    }
}

do {
    try nourish(with: "Beet-Flav")
} catch {
    print("Unexpeced")
}

func eat(item: String) throws {
    do {
        try vendingMachine.vend(itemNamed: item)
    } catch VendingMAchineError.invalidSelection, VendingMAchineError.insufficientFunds, VendingMAchineError.outOfStock {
        print("Invalid selection")
    }
}

func someFunc() throws -> Int {
    5
}

let x = try? someFunc()

let y: Int?
do {
    y = try someFunc()
} catch {
    y = nil
}


/*
func fetchDataFromServer() -> Data? {return data}
func fetchDataFromDisk() -> Data? {return data}

func fetchData() -> Data? {
    if let data = try? fetchDataFromDisk() {
        return data
    }
    if let data = try? fetchDataFromServer() {
        return data
    }
    return nil
}
*/

func deferExample() {
    defer {print ("This is deferred")}
    print ("action")
}
deferExample()
