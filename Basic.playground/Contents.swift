import Foundation

/*
 Псевдонимы типов задают альтернативное имя для существующего типа.
 Можно задать псевдоним типа с помощью ключевого слова typealias.
*/

typealias AudioSample = UInt16

let httpError = (404, "Not Found")
let httpErrorNew = (code: 404, desc: "Not Found")
print(httpError.1)
print(httpErrorNew.desc)
let (statusCode, statusMessage) = httpError
print(statusCode)
print(statusMessage)

let (justStatusCode, _) = httpError
print(justStatusCode)

let numberToInt: String = "11"
var myNumber = Int(numberToInt)

var serverResponse: Int? = 404
serverResponse = nil

myNumber = nil
if myNumber != nil {
    print("myNumber has value")
} else {
    print("myNumber has nil")
}

if let actualNumber = Int(numberToInt) {
    print("\(numberToInt) has an integer value of \(actualNumber)")
} else {
    print("\(numberToInt) could not be converted to an Int")
}

let possibleString: String? = "An optional"
let forcedString: String = possibleString!

var assumedString: String! = "implicitl optional string"
var implicitString: String = assumedString

//assumedString = nil
//implicitString = nil //Error: is not optional

if assumedString != nil {
    print(assumedString!)
}

if let definiteString = assumedString {
    print(definiteString)
}

func makeASandwich() throws {
    //code
}

do {
    try makeASandwich()
} catch {
    
}

//утверждения вызываются при сборках дебагера
let age = 1
assert(age >= 0)

//предусловия вызываются как при дебаге, так и при релизной сборке
if age > 10 {
    print("somthing")
} else if age > 0 {
    print("u can't to ride a circle")
} else {
    assertionFailure("age can't to be a negative")
}
var index = 1
precondition(index > 0, "cant")


