//: Playground - noun: a place where people can play

import UIKit

let (x, y) = (1, 2)

// # 合并空值运算符
let defaultColorName = "red"
var userDefinedColorName:String?//nil
var colorNameToUse = userDefinedColorName ?? defaultColorName
// if userDefinedColorName != nil return userDefinedColorName, else return defaultColorName

// # 区间运算符
//闭区间
for i in 1...5 {
    print(i)
}
//半开区间
let names = ["Anna", "Alex", "Brian", "Jack"]
for i in 0..<name.count {
    print(names[i])
}
//单侧区间
for name in names[2...] {
    print(names)
}
for name in names[...2] {
    print(name)
}
let range = ...5
range.contains(7)
range.contains(4)





