import Foundation

var available = false
var condition = pthread_cond_t()
var mutex = pthread_mutex_t()

class ConditionMutexPrinter: Thread {
    
    override init() {
        pthread_cond_init(&condition, nil)
        pthread_mutex_init(&mutex, nil)
    }
    
    override func main() {
        printerMethod()
    }
    
    private func printerMethod() {
        pthread_mutex_lock(&mutex)
        print("printer")
        while !available {
            pthread_cond_wait(&condition, &mutex)
        }
        //
        available = false
        defer {
            pthread_mutex_unlock(&mutex)
        }
        print("printer exit")
    }
}

class ConditionMutexWriter: Thread {
    
    override init() {
        pthread_cond_init(&condition, nil)
        pthread_mutex_init(&mutex, nil)
    }
    
    override func main() {
        writerMethod()
    }
    
    private func writerMethod() {
        pthread_mutex_lock(&mutex)
        print("writer")
        available = true
        //
        pthread_cond_signal(&condition)
        defer {
            pthread_mutex_unlock(&mutex)
        }
        print("writer exit")
    }
}

let conditionMutexWriter = ConditionMutexWriter()
let conditionMutexPrinter = ConditionMutexPrinter()
conditionMutexPrinter.start()
conditionMutexWriter.start()



let cond = NSCondition()
var availables = false

class WriterThread: Thread {
    
    override func main() {
        cond.lock()
        print("Writer enter")
        availables = true
        cond.signal()
        cond.unlock()
        print("Writer exit")
    }
}

class PrinterThread: Thread {
    
    override func main() {
        cond.lock()
        print("Printer enter")
        while !availables {
            cond.wait()
        }
        availables = false
        cond.unlock()
        print("Printer exit")
    }
}

let writer = WriterThread()
let printer = PrinterThread()
printer.start()
writer.start()

