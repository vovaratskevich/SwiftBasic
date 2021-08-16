import Foundation

struct Car {
    let model = "M3"
}

final class Ref<T> {
    var val: T
    init(_ v: T) {
        val = v
    }
}

struct Box<T> {
    var ref: Ref<T>
    init(_ x: T) {
        ref = Ref(x)
    }
    
    var value: T {
        get {
            return ref.val
        }
        set {
            if (!isKnownUniquelyReferenced(&ref)) {
                ref = Ref(newValue)
                return
            }
            ref.val = newValue
        }
    }
}

