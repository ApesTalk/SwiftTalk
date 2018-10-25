// SwiftTalk
// https://github.com/ApesTalk

import UIKit

//# 常量和变量
let max = 10
var currentIndex = 0
var x = 0, y = 1.0, z = 3.1415926

// # 类型标注
var msg: String
var red, green, blue: Double

// # 整数 (U)Int8/16/32/64  (U)Int（32位平台上同(U)Int32,64位平台上同(U)Int64）
let minValue = UInt8.min
let maxValue = UInt8.max

// # 浮点数
var f: Float //32位浮点数 精度6位
var d: Double //64位浮点数 精度15位

// # 类型安全和类型推断
let count = 2
let pi = 3 + 0.1415926

// # 数和浮点数转换
let integerPi = Int(pi) //必须显示指定类型

// # 类型别名
typealias sample = UInt
var a = sample.min

// # 布尔值
var t1 = true, f1 = false

// # 元组
let http404Error = (404, "Not Found")
let (code, message) = http404Error
print("The status code is \(code), the message is \(message)")

let (justTheCode, _) = http404Error
print("The status code is \(justTheCode)")

print("The status code is \(http404Error.0), message is \(http404Error.1)")

let http200Ok = (statusCode:200, description: "OK")
print("the status code is \(http200Ok.statusCode), message is \(http200Ok.description)")

// # 可选项 可用于任何类型，而OC只针对对象有nil类型。swift中nil不是指针，值缺失的一种特殊类型。
let possibleNumber = "123"
let convertedNumber: Int? = Int(possibleNumber)

// # if语句与强制展开!
if convertedNumber != nil {
    print("convertedNumber is \(convertedNumber!)") //必须确保可选项有值才能强制展开
}

// # 可选项绑定 if let 和 while let
if let v = Int("122"), let num = Int("200"), v < num { //v num必须是可选项
    print("v has value and it less than 200")
}

// # 隐式展开可选项：一旦被设值之后就会一直拥有值，此时可以去掉检查的需求，不需要每次访问时都展开
let possibleStr: String? = "An optional string"
let forcedStr: String = possibleStr! //需要展开
let assumedStr: String! = "An implicitly unwrapped optional string" //确定有值
let implicitStr: String = assumedStr //不再需要展开

// # 错误处理
func canThrowAnError() throws {
    
}

do {
    try canThrowAnError()
    //no error
}catch {
    //has error
}

// # 断言和先决条件
let age = 3
assert(age >= 0, "A person's age cannot be less than zero")

if age >= 0 {
    print("You can ride the roller-coaster or the ferris wheel")
}else{
    assertionFailure("A person's age cannot be less than zero") //已做判断，用assertionFailure标明断言失败
}

// # 强制先决条件
let index = 2
let array = [1]
precondition(index < array.count, "Index out of range")




