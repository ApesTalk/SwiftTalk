import UIKit

// # 泛型函数
//T:类型名占位符  <T>:告诉Swift T是swapTwoValues(_:_:)函数定义里的类型名占位符
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temp = a
    a = b
    b = temp
}

var someInt = 3
var anotherInt = 107
swapTwoValues(&someInt, &anotherInt)

var s1 = "hello"
var s2 = "world"
swapTwoValues(&s1, &s2)



// # 类型形式参数
//<T, U, V>


// # 命名类型形式参数
//Dictionary<Key, Value>  T V V 大写开头驼峰命名法



// # 泛型类型
struct Stack<Element> { //类型形式参数Element
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")
let fromTheTop = stackOfStrings.pop()





// # 扩展一个泛型类型

extension Stack {
    //不需要在扩展的定义中提供类型形式参数列表。原始类型定义的类型形式参数列表在扩展中仍然有效
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

if let topItem = stackOfStrings.topItem {
    print("The top item on the stack is \(topItem)")
}


// # 类型约束
//func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
//
//}

//任何遵循 Equatable 协议的类型 T
func findIndex<T: Equatable>(of valueToFind: T, in array: [T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
     }
    return nil
}

let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
if let foundIndex = findIndex(of: "llama", in: strings) {
    print("The index of llama is \(foundIndex)")
}



// # 关联类型

protocol Container {
    associatedtype ItemType
    mutating func append(_ item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType { get }
}


struct IntStack: Container {
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    
    //把 ItemType 抽象类型转换为了具体的 Int 类型
    typealias ItemType = Int
    mutating func append(_ item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}



// # 泛型where分句



// # 带有泛型where分句的扩展



// # 关联类型的泛型where分句



// # 泛型下标
