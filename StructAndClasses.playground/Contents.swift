import Foundation

struct NewStruct {
    let name: String
    var age: Int
}

var emploeeStruct = NewStruct(name: "Joe", age: 21)
emploeeStruct.age = 23
print(emploeeStruct)

class NewClass {
    let name: String
    var age: Int
    
    init(name1: String, age1: Int) {
        name = name1
        age = age1
    }
}

let emploeeClass = NewClass(name1: "sad",age1: 19)
emploeeClass.age = 23
print(emploeeClass.age)
