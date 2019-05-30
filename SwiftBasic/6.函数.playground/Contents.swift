import UIKit

func greet(person: String) -> String {
    let greeting = "Hello, " + person + "!"
    return greeting
}
print(greet(person: "Anna"))


func greetAgain(person: String) -> String {
    return "Hello again, " + person + "!"
}


func sayHelloWorld() -> String {
    return "Hello, world"
}
print(sayHelloWorld())

//方法名相同，参数不同
func greet(person: String, alreadyGreeted: Bool) -> String {
    if alreadyGreeted {
        return greetAgain(person: person)
    }else {
        return greet(person: person)
    }
}
print(greet(person: "ApesTalk", alreadyGreeted: true))


//方法名和参数相同，返回值不同，调用时会产生歧义
//func greet(person: String) {
//    print("Hello, \(person)!")
//}
//greet(person: "Dave")



//多返回值
func minMax(array: [Int]) -> (min: Int, max: Int) {
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        }else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}
let bounds = minMax(array: [8, -6, 2, 109, 3, 71])
print("min is \(bounds.min) and max is \(bounds.max)")



//可选元组返回类型
//func minMax(array: [Int]) -> (min: Int, max: Int)? {
//    if array.isEmpty {
//        return nil
//    }
//
//    var currentMin = array[0]
//    var currentMax = array[0]
//    for value in array[1..<array.count] {
//        if value < currentMin {
//            currentMin = value
//        }else if value > currentMax {
//            currentMax = value
//        }
//    }
//    return (currentMin, currentMax)
//}


//指定实际参数标签  形参 实参
func greet(person: String, from hometown: String) -> String {
    return "Hello \(person)! Glad you could visit from \(hometown)"
}
greet(person: "ApesTalk", from: "Shanghai")

//省略实际参数标签
func someFunction(_ firstParam: Int, secondParam: Int) {
    //use firstParam secondParam
}
someFunction(1, secondParam: 2)


//默认形式参数值   调用时可以省略这个形式参数
//通常不带默认参数值的参数写在前面，带默认参数值的参数写在后面
func someFunction(paramWithDefault: Int = 12) {
    print(paramWithDefault)
}
someFunction(paramWithDefault: 6)
someFunction()



//可变形式参数  一个函数最多只能有一个可变形式参数
func arithmeticMean(_ numbers: Double...) -> Double {
    //函数内部把numbers当[Double]
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}
arithmeticMean(1, 2, 3, 4, 5)
arithmeticMean(3, 8.25, 18.75)



//输入输出形式参数，inout 不能有默认值， 可变形式参数不能标记为inout，不能传入let常量
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temp = a
    a = b
    b = temp
}
var someInt = 3
var anotherInt = 107
swap(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")




// 函数类型
//(Int, Int) -> Int类型
func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}


//使用函数类型
var mathFunction: (Int, Int) -> Int = addTwoInts
print(mathFunction(2, 3))
let anotherMathFunction = addTwoInts //类型推断


//函数类型作为形式参数类型
func printMathResult(_ mathFunc: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result: \(mathFunc(a, b))")
}
printMathResult(addTwoInts, 3, 5)

//函数类型作为返回类型
func stepForward(_ input: Int) -> Int {
    return input + 1
}
func stepBackward(_ input: Int) -> Int {
    return input - 1
}
func chooseStepFunc(backwards: Bool) -> (Int) -> Int {
    return backwards ? stepForward : stepForward
}

let currentValue = 3
let moveNearerToZero = chooseStepFunc(backwards: currentValue > 0)


//内嵌函数
func chooseStep(back: Bool) -> (Int) -> (Int) {
    //函数内部定义函数
    func forward(input: Int) -> Int {return input + 1}
    func backward(input: Int) -> Int {return input - 1}
    return back ? backward: forward
}
var v = -4
let nearZero = chooseStep(back: v > 0)
while v != 0 {
    print("\(v)... ")
    v = nearZero(v)
}
print("zero!")
