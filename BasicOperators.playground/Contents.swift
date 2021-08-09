import Foundation

let names = ["Anna", "Alex", "Brian", "Jack"]

for name in names [2...] {
    print(name)
}
for name in names [...2] {
    print(name)
}
for name in names[..<2] {
    print(name)
}

let range = ...3
