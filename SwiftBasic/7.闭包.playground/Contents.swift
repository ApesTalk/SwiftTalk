import UIKit

/*
 全局函数是一个有名字但不会捕获任何值的闭包；
 内嵌函数是一个有名字且能从其上层函数捕获值的闭包；
 闭包表达式是一个轻量级语法所写的可以捕获其上下文中常量或变量值的没有名字的闭包。
 */

// # 闭包表达式
/* 可以使用常量变量形参，输入输出参数（不能提供默认值），可变形式参数
 {  (params) -> (return type) in
    statements
 }
 */

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}
var reversedNames = names.sorted(by: backward)
var reversed = names.sorted { (s1, s2) -> Bool in
    return s1 > s2
}
var reversed1 = names.sorted(by: {s1, s2 in return s1 > s2}) //类型推断
//从单表达式闭包隐式返回
var reversed2 = names.sorted(by: {s1, s2 in  s1 > s2}) //省略return隐式返回单个表达式的结果
//简写实际参数名
var reversed3 = names.sorted(by: {$0 > $1}) //in也可以省略
//运算符函数
var reversed4 = names.sorted(by: >) //String类型定义了>的特定字符串实现，swift推荐使用>特殊字符串函数实现




// # 尾随闭包：写在函数形参括号后面的闭包表达式  如果函数只有一个闭包参数，可以不写圆括号
func someFunctionThatTakesAClosure(closure:() -> Void){
    
}

//尾部闭包
someFunctionThatTakesAClosure() {
    
}


let digitNames = [
    0: "Zero",1: "One",2: "Two",  3: "Three",4: "Four",
    5: "Five",6: "Six",7: "Seven",8: "Eight",9: "Nine"
]
let numbers = [16, 58, 510]

let strings = numbers.map { (number) -> String in
    var number = number
    var output = ""
    repeat {
        output = digitNames[number % 10]! + output
        number /= 10
    }while number > 0
    return output
}


// # 捕获值 一个闭包能够从上下文捕获已被定义的常量和变量。即使定义这些常量和变量的原作用域已经不存在，闭包仍能够在其函数体内引用和修改这些值。
func makeIncrementer(forIncrement amout: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amout
        return runningTotal
    }
    return incrementer
}
let incrementByTen = makeIncrementer(forIncrement: 10)
incrementByTen()
incrementByTen()
incrementByTen()

let incrementBySeven = makeIncrementer(forIncrement: 7)
incrementBySeven()

incrementByTen()



// # 闭包是引用类型
//let常量指向闭包的引用
//赋值一个闭包到两个不同的常量或变量中，这两个常量或变量都将指向相同的闭包
let alsoIncrementByTen = incrementByTen
alsoIncrementByTen()



// # 逃逸闭包  @escaping声明闭包允许逃逸
//当闭包作为一个实际参数传递给一个函数的时候，我们就说这个闭包逃逸了，因为它可以在函数返回之后被调用
//闭包可以逃逸的一种方法是被储存在定义于函数外的变量里。比如说，很多函数接收闭包实际参数来作为启动异步任务的回调。函数在启动任务后返回，但是闭包要直到任务完成——闭包需要逃逸，以便于稍后调用
var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHander: @escaping () -> Void){
    completionHandlers.append(completionHander)
}

//让闭包@escaping意味着必须在闭包中显示地引用self
func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}

class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure {
            self.x = 100
        }
        someFunctionWithNonescapingClosure {
            x = 200
        }
    }
}

let instance = SomeClass()
instance.doSomething()
print(instance.x)

completionHandlers.first?()
print(instance.x)


// # 自动闭包
//自动闭包是一种自动创建的用来把作为实际参数传递给函数的表达式打包的闭包
//它不接受任何参数，并且当它被调用时它会返回内部打包的表达式的值
var customersInLine = ["Chris", "ALex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)

//一个不接受实际参数并且返回一个字符串的函数
let customerProvider = {customersInLine.remove(at: 0)}
print(customersInLine.count)

print("Now serving \(customerProvider())")
print(customersInLine.count)


//使用自动闭包，调用函数就像调用一个接受字符串参数的函数一样
func serve(customer customerProvider: @autoclosure() -> String) {
    print("Now serving \(customerProvider())")
}
serve(customer: customersInLine.remove(at: 0))
