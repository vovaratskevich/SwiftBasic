import Foundation

//создаем переменную потока
var thread = pthread_t(bitPattern: 0)
//создаем переменную атрибутов очереди
var threadAttributes = pthread_attr_t()
//инициализируем аттрибуты
pthread_attr_init(&threadAttributes)
//создаем поток, передав все параметры
pthread_create(&thread,
               &threadAttributes,
               {_ in print("Hey")
                return nil
               },
               nil)

let newThread = Thread {
    print("Hello world")
}
//стартуем выполнение операций на потоке
newThread.start()

//создаем переменную потока
var qosPthread = pthread_t(bitPattern: 0)
//создаем переменную отирибутов очереди
var qosPthreadAttributes = pthread_attr_t()
//инициализируем атрибуты
pthread_attr_init(&qosPthreadAttributes)
//задаем QOS в атрибуты потока
pthread_attr_set_qos_class_np(&qosPthreadAttributes, QOS_CLASS_USER_INITIATED, 0)
//создаем поток, передав все параметры
pthread_create(&qosPthread, &qosPthreadAttributes, { _IOFBF in
    print("qosPthread")
    //переключаем qos в ходе выполнения операции
    pthread_set_qos_class_self_np(QOS_CLASS_BACKGROUND, 0)
    return nil
}, nil)

//создаем объект Thread
let qosThread = Thread {
    print("qosThread")
}
//задаем потоку qos
qosThread.qualityOfService = .userInteractive
//стартуем выполнение потока
qosThread.start()


var pthreadMutex = pthread_mutex_t()
pthread_mutex_init(&pthreadMutex, nil)

func newFunc() {
    pthread_mutex_lock(&pthreadMutex)
    doSomthing()
    pthread_mutex_unlock(&pthreadMutex)
}

func doSomthing() {
    //print("5")
    //захватываем ресурс
    pthread_mutex_lock(&pthreadMutex)
    
    //выполняем работу
    print("pthread mutex")
    
    //освобождаем ресурс
    pthread_mutex_unlock(&pthreadMutex)
}

doSomthing()
//newFunc()

let lock  = NSLock()

func doFunc() {
    lock.lock()
    
    //выполняем работу
    print("nslock")
    
    lock.unlock()
}

var reqursiveMutex = pthread_mutex_t()
//создаем переменную атрибутов мьютекса
var reqursiveMutexAttributes = pthread_mutexattr_t()
pthread_mutexattr_init(&reqursiveMutexAttributes)
//сетаем рекурсивный тип мьютекса
pthread_mutexattr_settype(&reqursiveMutexAttributes, PTHREAD_MUTEX_RECURSIVE)
//инициализируем мьютекс с атрибутами
pthread_mutex_init(&reqursiveMutex, &reqursiveMutexAttributes)

func doSomeFunc1() {
    pthread_mutex_lock(&reqursiveMutex)
    doSomeFunc2()
    pthread_mutex_unlock(&reqursiveMutex)
}
func doSomeFunc2() {
    pthread_mutex_lock(&reqursiveMutex)
    print("reqursive")
    pthread_mutex_unlock(&reqursiveMutex)
}
doSomeFunc1()


let recursiveLock = NSRecursiveLock()

func recursiveLockFunc1() {
    recursiveLock.lock()
    recursiveLockFunc2()
    recursiveLock.unlock()
}
func recursiveLockFunc2() {
    recursiveLock.lock()
    print("recursive lock")
    recursiveLock.unlock()
}
recursiveLockFunc1()

var condition = pthread_cond_t()
var conditionMutex = pthread_mutex_t()

var booleanPredicate = false

pthread_cond_init(&condition, nil)
pthread_mutex_init(&conditionMutex, nil)

func conditionFunc1() {
    pthread_mutex_lock(&conditionMutex)
    
    // проверяем булевый предикат
    while !booleanPredicate {
        //переход в состояние ожидания
        pthread_cond_wait(&condition, &conditionMutex)
    }
    //выполняем работу
    print("condition")
    
    pthread_mutex_unlock(&conditionMutex)
}

func conditionFunc2() {
    pthread_mutex_lock(&conditionMutex)
    
    // проверяем булевый предикат
    booleanPredicate = true
    //выполняем работу
    pthread_cond_signal(&condition)
    
    pthread_mutex_unlock(&conditionMutex)
}
conditionFunc2()
conditionFunc1()

//создаем булевый предикат
var newBoolPredicate = false

//создаем condition
let newCondition = NSCondition()

func test1() {
    newCondition.lock()
    //проверяем булевый предикат
    while(!newBoolPredicate) {
        //переход в состояние ожидания
        newCondition.wait()
    }
    //выполняем работу
    print("ns condition")
    
    newCondition.unlock()
}
func test2() {
    newCondition.lock()
    newBoolPredicate = true
    newCondition.signal()
    newCondition.unlock()
}

var rwlock = pthread_rwlock_t()
var rwAttr = pthread_rwlockattr_t()
pthread_rwlock_init(&rwlock, &rwAttr)
//инициализируем rwlock
pthread_rwlock_init(&rwlock, &rwAttr)
//блокируем чтение
pthread_rwlock_rdlock(&rwlock)
//...
//освобождаем ресурс
pthread_rwlock_unlock(&rwlock)
//блокируем запись
pthread_rwlock_wrlock(&rwlock)
//...
//освобождаем ресурс
pthread_rwlock_unlock(&rwlock)
//блокируем запись
pthread_rwlock_wrlock(&rwlock)
//...
//освобождаем ресурс
pthread_rwlock_unlock(&rwlock)
//очищаем rwlock
pthread_rwlock_destroy(&rwlock)

class RWLock {
    //создаем rwlock
    var lock = pthread_rwlock_t()
    //создаем rwlock атрибуты
    var attr = pthread_rwlockattr_t()
    
    //создаем ресурс
    private var resource: Int = 0
    
    init() {
        //инициализируем rwlock
        pthread_rwlock_init(&lock, &attr)
    }
    
    var testProperty: Int {
        get {
            //блокируем ресурс на чтение
            pthread_rwlock_rdlock(&lock)
            //создаем  временную переменную
            let tmp = resource
            //освобождаем ресурс
            pthread_rwlock_unlock(&lock)
            return tmp
        }
        set {
            //блокируем ресурс на запись
            pthread_rwlock_wrlock(&lock)
            //записываем ресурс, гарантируя, что в данный момент времени не будет перезаписан из другого потока
            resource = newValue
            //освобождаем ресурс
            pthread_rwlock_unlock(&lock)
        }
    }
}

//создаем unfair lock
var unfairLock = os_unfair_lock_s()
os_unfair_lock_lock(&unfairLock)
print("Unfair lock")
os_unfair_lock_unlock(&unfairLock)

class DeadLock {
    let lock = NSLock()
    var boolPredicate = true
    var counter = 0
    
    func test() {
        while boolPredicate {
            
            lock.lock()
            
            counter += 1
            boolPredicate = counter < 10
            
            if boolPredicate {
                test()
            }
            
            lock.unlock()
        }
    }
}

let deadLock = DeadLock()
//deadLock.test()
//print("hey")
