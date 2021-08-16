import Foundation

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniela"]

func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}
var reversedNames = names.sorted(by: backward)
reversedNames = names.sorted(by: { $0 > $1 })
reversedNames = names.sorted(by: >)

func someFunctionThatTakesAClosure(closure: () -> Void) {
    //code
}

someFunctionThatTakesAClosure(closure: {
  //code
})

someFunctionThatTakesAClosure {
    //тело замыкания
}

let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]

let strings = numbers.map() { number -> String in
    var number = number
    var output = ""
    repeat {
        output = digitNames[number % 10]! + output
        number /= 10
    } while number > 0
    return output
}

/*
func loadPicture(from server: Server, completion: (Picture) -> Void, onFailure: () -> Void) {
    if let picture = download("photo.jpg", from: server) {
        completion(picture)
    } else {
        onFailure()
    }
}
loadPicture(from: someServer) { picture in
    someView.currentPicture = picture
} onFailure: {
    print("Couldn't download the next picture.")
}
*/

func makeIncrementer(forIncrement amount: Int) -> () -> Int {
   var runningTotal = 0
   func incrementer() -> Int {
      runningTotal += amount
      return runningTotal
   }
   return incrementer
}

let test = makeIncrementer(forIncrement: 3)
test()

let test1 = makeIncrementer(forIncrement: 5)
test1()
test()
test1()

var complitionHandlers: [() -> Void] = []
func someFuncWithEsqClosure(complitionHandler: @escaping () -> Void) {
    complitionHandlers.append(complitionHandler)
}

func someFunctionWithNonescapingClosure(number: Int, closure: () -> Void) {
    closure()
}

class SomeClass {
    var x = 10
    func doSomething() {
        someFuncWithEsqClosure {
            self.x = 100
        }
        someFunctionWithNonescapingClosure(number: 10) {
            x = 200
        }
    }
}
let instance = SomeClass()
instance.doSomething()
print(instance.x)

complitionHandlers.first?()
print(instance.x)

class SomeOtherClass {
    var x = 10
    func doSomthing() {
        someFuncWithEsqClosure {
            [self] in x = 100
        }
        someFunctionWithNonescapingClosure(number: 10) {
            x = 200
        }
    }
}

struct SomeStruct {
    var x = 10
    mutating func doSomthing() {
        someFuncWithEsqClosure {
            print("")
        }
        someFunctionWithNonescapingClosure(number: 10) {
            x = 200
        }
    }
}

