import Foundation

enum PrinterError: Error {
    case outOfPaper
    case noToner
    case onFire
    case onZero
}

class PrintEr: Error {
    
}

extension PrintEr {
    
    
    var b:Int {
        return 1
    }
}

let a = 1

var b:Int {
    return 1
}

func send(job: Int, toPrinter printerName: String) throws -> String {
        if printerName == "Never Has Toner" {
            throw PrinterError.noToner
        }
        return "Job sent"
}

try send(job: 11, toPrinter: "Never Has Tone")

func zeroDevide(a: Double, b: Double) throws -> Double {
    guard b != 0 else {
        throw NSError(domain: "Err", code: 404)
    }
    return a/b
}

do {
    let errResponse = try zeroDevide(a: 3, b: 0)
    print(errResponse)
} catch {
    print(error.localizedDescription)
}

enum EnternetError: Error {
    
}

do {
    let errReaponse = try send(job: 111, toPrinter: "Never Has Toner")
    print(errReaponse)
} catch PrinterError.noToner {
    print("I will just put this over here, with the rest of the fire")
} catch let printerErr as PrinterError {
    print("Err: \(printerErr)")
} catch {
    print(error)
}

var resultZeroDiv = 0.0

do {
    let errResp = try zeroDevide(a: 3, b: 0)
    resultZeroDiv = errResp
} catch PrinterError.noToner {
    print("I will just put this over here, with the rest of the fire")
} catch let printerErr as PrinterError {
    print("Err: \(printerErr)")
} catch {
    print(error)
}
print(resultZeroDiv)

let printSuccess = try? send(job: 51, toPrinter: "ToPtint")
let printFailure = try? send(job: 51, toPrinter: "Never Has Toner")

var fridgeIsOpen = false
var fridgeContent = [String]()
fridgeContent.append("milk")
fridgeContent.append("eggs")
fridgeContent.append("leftovers")

func fridgeCon(_ food: String) -> Bool {
    fridgeIsOpen = true
    defer {
        fridgeIsOpen = false
    }
    
    let result = fridgeContent.contains(food)
    return result
}

fridgeCon("cherry")
print(fridgeIsOpen)
