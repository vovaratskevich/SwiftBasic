import Foundation

func minMax(array: [Int]) -> (min: Int, max: Int, first: Int) {
    var currentMin = array[0]
    var currentMax = array[0]
    let currentFirst = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax, currentFirst)
}

func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}
arithmeticMean(1, 2, 3, 4, 5)
arithmeticMean()

func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var firstInt = 11
var secInt = 15
swapTwoInts(&firstInt, &secInt)
print(firstInt)

func addTwoInts(a: Int, _ b: Int) -> Int{
  return a + b
}
var mathFunc: (Int, Int) -> Int = addTwoInts

func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print(mathFunction(a, b))
}
printMathResult(addTwoInts, 3, 4)

func stepForward(_ input: Int) -> Int {
    return input + 1
}
func stepBackward(_ input: Int) -> Int {
    return input - 1
}
func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    return backward ? stepBackward : stepForward
}
var currentValue = 3
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
while currentValue != 0 {
    print(currentValue)
    currentValue = moveNearerToZero(currentValue)
}

func chooseStepFunctionNew(backward: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int { return input + 1 }
    func stepBackward(input: Int) -> Int { return input - 1 }
    return backward ? stepBackward : stepForward
}
var currentValueNew = -4
let moveNearerToZeroNew = chooseStepFunctionNew(backward: currentValueNew > 0)
while currentValueNew != 0 {
    print(currentValueNew)
    currentValueNew = moveNearerToZeroNew(currentValueNew)
}

func myFunc(_ value: Bool) -> (Int) -> Int {
    func myPulsFunc(input: Int) -> Int {
        return input + 1
    }
    func myMinusFunc(input: Int) -> Int {
        return input - 1
    }
    let funcValue = myPulsFunc
    return value ? funcValue : myMinusFunc
}

let minusValue = myFunc(true)
minusValue(3)
