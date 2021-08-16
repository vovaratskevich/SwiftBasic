import Foundation


//Что выведится в консоль?
func getNumber() -> Int {
    print("Fetching number...")
    return 5
}

func printStatement(_ result: () -> Bool) {
    //print("Here is the number: \(result())")
    print("Nothing to see here.")
}
