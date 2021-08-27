import Foundation

extension Array where Element: Equatable {
    var areAllElementsEq: Bool {
        if isEmpty {
            return false
        }
        var previousEl = self[0]
        for (index, el) in self.enumerated() where index > 0 {
            if el != previousEl {
                return false
            }
            previousEl = el
        }
        return true
    }
    func elEq() -> Bool {
        var previousEl = self[0]
        for (index, el) in self.enumerated() where index > 0 {
            if el != previousEl {
                return false
            }
            previousEl = el
        }
        return true
    }
}

let arr = [1, 1, 1]
arr.areAllElementsEq
arr.elEq()

class DataProvider<T>: Equatable {
    static func == (lhs: DataProvider<T>, rhs: DataProvider<T>) -> Bool {
        <#code#>
    }
    
    func fetch() {
        
    }
}




