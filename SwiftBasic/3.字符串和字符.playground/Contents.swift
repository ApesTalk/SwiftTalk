//: Playground - noun: a place where people can play

import UIKit
let ss = "abcdef"
let suss = ss[ss.index(ss.startIndex, offsetBy: 3)]
let x = ss.firstIndex(of: "c")
let index1 = ss.distance(from: ss.startIndex, to: x!)
print("index of 'c' is \(index1)")


// # 字符串字面量
//注意空格：某一行的空格超过"""的范围才算，"""之前的空格将自动忽略.
let quotation = """
   The white rabbit put on his spectacles. "Where shall i begin,
   please your Majesty?" he asked.
      "Begin at the beginning," the King said gravely, "and go on
      till you come to the end; then stop."
   """
//如果你在某行的空格超过了结束的双引号（ """ ），那么这些空格会被包含。
print(quotation)

// # 初始化空字符串与空字符串的判断
var emptyStr = ""
var anotherEmptyStr = String()
if emptyStr.isEmpty {
    print("Nothing to see here")
}

// # 可变性
var variableString = "Hourse" //var声明的就是可变字符串
variableString += " and carriage"
let constantString = "Highlander"//let声明的就是不可变字符串
//constantString += " and another Highlander"


// # Swift的String是值类型，传递的时候都是传递的一份拷贝，保证了当一个方法或者函数传给你一个String值，你就绝对拥有了这个String值。

// # 操作字符串
for character in "Dog!?" {
    print(character)
}
let exclamationMark: Character = "!"//从单个字符的字符串字面量中创建一个字符常量
var ex = "!"
print(exclamationMark == "!")
//print(exclamationMark == ex)

let catChars: [Character] = ["C", "a", "t"]
let catStr = String(catChars)
print(catStr)

// 连接字符串和字符
let str1 = "hello"
let str2 = " ApesTalk"
var welcome = str1 + str2

welcome.append(" ")//append字符串
welcome.append(exclamationMark)//append字符

var instruction = "look over"
instruction += str2

// # 字符串插值
let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"

// # Swift5用UTF-8编码重写了String的实现

// # 长度
let name = "ApesTalk"
print(name.count)

// # 访问和修改字符串
// ## 索引
let greeting = "ApesTalk at github"
//起始位置 对于空字符串 startIndex == endIndex
greeting[greeting.startIndex] //A
//结束位置 endIndex = count+1
//greeting[greeting.endIndex]
//index(befor:) index(after:)获取给定索引的前后索引
greeting[greeting.index(before: greeting.endIndex)]//b
greeting[greeting.index(after: greeting.startIndex)]//p
//index(_:offsetBy:) 从给定索引偏移s多少后的index
let index = greeting.index(greeting.startIndex, offsetBy: 7)
greeting[index]
//使用indices属性访问每个字符的索引
for index in greeting.indices {
    print("\(greeting[index]) ", terminator: " ~ ")//terminator指定终止符
}

// ## 插入删除
var h = "hello"
h.insert("!", at: h.endIndex)//插入字符
h.insert(contentsOf: " ApesTalk", at: h.index(before: h.endIndex))//插入字符串
h.remove(at: h.index(before: h.endIndex))//移除字符 return !
print(h)//一旦上面修改了print的终止符，这里也会生效
let range = h.index(h.endIndex, offsetBy: -9)..<h.endIndex
h.removeSubrange(range)//移除指定范围字符串
print(h)

// # 子字符串 Substring
/*使用下标或prefix(_:)获得的是一个子字符串Substring的实例，Swift中子字符串有绝大多数字符串拥有的方法。
 但是你应该使用子字符串执行短期处理。当你想要把结果保存得长久一点时，你需要把子字符串转换为 String 实例。
 与字符串类似，每一个子字符串都有一块内存区域用来保存组成子字符串的字符。
 字符串与子字符串的不同之处在于，作为性能上的优化，子字符串可以重用一部分用来保存原字符串的内存，
 或者是用来保存其他子字符串的内存。子字符串并不适合长期保存——因为它们重用了原字符串的内存，
 只要这个字符串有子字符串在使用中，那么这个字符串就必须一直保存在内存里。
 */
let gret = "Hello, ApesTalk!"
let i = gret.firstIndex(of: ",") ?? gret.endIndex
let beginning = gret[..<i] //hello is a Substring
let newString = String(beginning)

// # 字符串比较
//字符串和字符相等性
let quo = "ApesTalk"
let quo1 = "ApesTalk"
print(quo == quo1)
let c = "c"
let c1 = "C"
print(c == c1)
//前缀和后缀相等性
print(quo.hasPrefix("A"))
print(quo.hasSuffix("Talk"))


