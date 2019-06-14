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
//关联类型给协议中用到的类型一个占位符名称。直到采纳协议时，才指定用于该关联类型的实际类型

protocol Container {
    associatedtype ItemType
    
    //可以给关联类型添加约束
//    associatedtype ItemType: Equatable
    
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


//在关联类型约束里使用协议
//protocol SuffixableContainer: Container {
//    associatedtype Suffix: SuffixableContainer where Suffix.Item == Item
//    func suffix(_ size: Int) -> Int
//}



// # 泛型where分句
func allItemMatch<C1: Container, C2: Container>(_ someContainer: C1, _ anotherContainer: C2) -> Bool where C1.ItemType == C2.ItemType, C1.ItemType: Equatable {
    if someContainer.count != anotherContainer.count {
        return false
    }
    
    for i in 0..<someContainer.count {
        if someContainer[i] != anotherContainer[i] {
            return false
        }
    }
    
    return true
}




// # 带有泛型where分句的扩展
extension Stack where Element: Equatable {
    func isTop(_ item: Element) -> Bool {
        guard let topItem = items.last else {
            return false
        }
        return topItem == item
    }
}

//指定类型
extension Container where ItemType == Double {
    
}


// # 关联类型的泛型where分句
protocol Container1 {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
    
    associatedtype Iterator: IteratorProtocol where Iterator.Element == Item
    func makeIterator() -> Iterator
}



// # 泛型下标
extension Container1 {
    //泛型形式参数Indices是遵循Sequence协议的类型
    subscript<Indices: Sequence>(indices: Indices) -> [Item]
        //where分句要求序列的遍历器必须遍历Int类型的元素，保证序列中的索引都是作为容器索引的相同类型
        where Indices.Iterator.Element == Int {
            var result = [Item]()
            for index in indices {
                result.append(self[index])
            }
            return result
    }
}
