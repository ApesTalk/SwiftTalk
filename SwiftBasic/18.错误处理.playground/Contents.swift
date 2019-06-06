import UIKit

// # 表示和抛出错误
// Error这个空的协议明确了一个类型可以用于错误处理
enum VendingMachineError : Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}
//抛出错误
//throw VendingMachineError.insufficientFunds(coinsNeeded: 5)




// # 处理错误

//使用抛出函数传递错误  可以把它内部抛出的错误传递到它被调用的生效范围内，只有抛出函数可以传递错误
// func canThrowErrors() throws <返回错误类型> -> String
struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    var coninsDeposited = 0
    
    func vend(itemNamed name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }
        
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        
        guard item.price <= coninsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coninsDeposited)
        }
        
        coninsDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        
        print("Dispensing \(name)")
    }
}

let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels"
]
func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snakeName = favoriteSnacks[person] ?? "Candy Bar"
    //调用会抛出错误的方法前要加try
    try vendingMachine.vend(itemNamed: snakeName)
}


let m = VendingMachine()
m.coninsDeposited = 20
try buyFavoriteSnack(person: "Alice", vendingMachine: m)


//使用do-catch处理错误
//do {
//    try expression
//}catch pattern 1 {
//
//}catch pattern 2 where condition{
//
//}


var vendingMachine = VendingMachine()
vendingMachine.coninsDeposited = 8
do {
    try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
}catch VendingMachineError.invalidSelection {
    print("Invalid Selection")
}catch VendingMachineError.outOfStock {
    print("Out of stock")
}catch VendingMachineError.insufficientFunds(let coinsNeeded){
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
}



func nourish(with item: String) throws {
    do {
        try vendingMachine.vend(itemNamed: item)
        //任何非VendingMachineError错误都会被nourish调用函数捕获
    }catch is VendingMachineError {
        print("Invalid selection, out of stock, or not enough money")
    }
}


do {
    try nourish(with: "Best-Flavored Chips")
}catch {
    //如果一个 catch分句没有模式，这个分句就可以匹配所有错误并且绑定这个错误到本地常量 error上
    print("Unexpected non-vending-machine-related error: \(error)")
}



//转换错误为可选项  使用try?将错误转换为可选项来处理一个错误。如果一个错误在 try?表达式中抛出，则表达式的值为 nil
func someThrowingFunction() throws -> Int {
    return 10
}

//x和y等价
let x = try? someThrowingFunction()

let y: Int?
do {
    y = try someThrowingFunction()
}catch {
    y = nil
}


//当你想要在同一句里处理所有错误时，使用 try?能让你的错误处理代码更加简洁
//func fetchData() -> Data? {
//    if let data = try? fetchDataFromDisk() { return data }
//    if let data = try? fetchDataFromServer() { return data }
//    return nil
//}



//取消错误传递
//你可以在表达式前写 try!来取消错误传递并且把调用放进不会有错误抛出的运行时断言当中。如果错误真的抛出了，你会得到一个运行时错误。
//let photo = try! loadImage("./Resources/John Appleseed.jpg")





// # 指定清理操作  defer语句延迟执行直到当前范围退出
//使用 defer语句来在代码离开当前代码块前执行语句合集。
//这个语句允许你在以任何方式离开当前代码块前执行必须要的清理工作——无论是因为抛出了错误还是因为 return或者 break这样的语句

//func processFile(filename: String) throws {
//    if exists(filename) {
//        let file = open(filename)
//        defer {
//            close(file)
//        }
//        while let line = try file.readline() {
//            // Work with the file.
//        }
//        // close(file) is called here, at the end of the scope.
//    }
//}
