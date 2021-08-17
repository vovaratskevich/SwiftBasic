import Foundation

class Adress {
    let street = "Lenina"
    let number = 19
}

class Home {
    let adress = Adress()
    let room: Int? = 3
    var parking: Parking? = Parking()
    
    func printRooms(){
        print("Thr number of rooms is \(room)")
    }
}

struct Parking {
    var carPlace = 5
}

class Parents {
    var cars: [String]? = ["Mers"]
    var home: Home? = Home()
}

let parents = Parents()

//parents.cars![0]
//print(parents.home!)

//parents.home!.parking!.carPlace

parents.home?.parking?.carPlace

if (parents.home?.parking?.carPlace = 7) != nil {
    print("property was set")
} else {
    print("property was't set")
}

parents.cars?[0]
if (parents.home?.printRooms()) != nil {
    print("room is ready to print")
} else {
    print("room isn't ready to print")
}

class Person {
    var residence: Residence?
}

class Residence {
    var numberOfRooms = 1
}

let john = Person()
var roomCount = john.residence?.numberOfRooms
john.residence = Residence()
roomCount = john.residence?.numberOfRooms

class MyPerson {
    var myResidence: MyResidence?
}

class MyResidence {
    var rooms: [Room] = []
    var numberOfRooms: Int {
        return rooms.count
    }
    
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    var adress: Address?
}

class Room {
    let name: String
    init(name: String) {
        self.name = name
    }
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    
    func buildingId() -> String? {
        if let buildingNumber = buildingNumber, let street = street {
            return "\(buildingNumber) \(street)"
        } else if buildingName != nil {
            return buildingName
        } else {
            return nil
        }
    }
}

let joe = MyPerson()
if let roomCount = joe.myResidence?.numberOfRooms{
    print("Joe's residence has \(roomCount)")
} else {
    print("Unable to retrieve the number of room")
}

let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
joe.myResidence?.adress = someAddress


