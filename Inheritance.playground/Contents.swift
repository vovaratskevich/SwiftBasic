import Foundation

class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "speed \(currentSpeed)"
    }
    func makeNoise() {
        print("super class")
    }
}

let vehicle = Vehicle()
vehicle.description

class Bicycle: Vehicle {
    var hasBasket = false
}

let bicycle = Bicycle()
bicycle.hasBasket = true

class Tandem: Bicycle {
  var currentNumberOfPassengers = 0
}

let tandem = Tandem()
tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2
tandem.currentSpeed = 22.0
tandem.description

class Train: Vehicle {
    override func makeNoise() {
        print("its work. subclass")
    }
}
let train = Train()
train.makeNoise()

class Car: Vehicle {
    var gear = 1
    override var description: String {
        return super.description + " some \(gear)"
    }
}

let car = Car()
car.gear = 3
car.currentSpeed = 27
car.description

class AutomaticCar: Car {
    override var currentSpeed: Double  {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}

