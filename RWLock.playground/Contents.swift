import Foundation

class ReadWriteLock {
    private var lock = pthread_rwlock_t()
    private var attr = pthread_rwlockattr_t()
    
    private var globalProperty: Int = 0
    
    init() {
        pthread_rwlock_init(&lock, &attr)
    }
    
    public var workProperty: Int {
        get  {
            pthread_rwlock_wrlock(&lock)
            let temp = globalProperty
            pthread_rwlock_unlock(&lock)
            return temp
        }
        set {
            pthread_rwlock_wrlock(&lock)
            globalProperty = newValue
            pthread_rwlock_unlock(&lock)
        }
    }
}

class SynchronizedObjc {
    private let lock = NSObject()
    
    var arr = [Int]()
    
    func some() {
        objc_sync_enter(lock)
        arr.append(3)
        objc_sync_exit(lock)
    }
}
