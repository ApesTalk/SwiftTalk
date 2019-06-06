import UIKit

//扩展可为现有的类、结构体、枚举类型或协议添加新功能，即使无访问权限的源代码扩展----逆向建模
// - 添加计算实例属性和计算类型属性
// - 定义实例方法和类型方法
// - 提供新初始化器
// - 定义下标
// - 定义和使用新内嵌类型
// - 使现有的类型遵循某协议


//扩展可以向一个类型添加新的方法，但是不能重写已有的方法。
//如果你向已存在的类型添加新功能，新功能会在该类型的所有实例中可用，即使实例在该扩展定义之前就已经创建。
//扩展可以添加新的计算属性，但是不能添加存储属性，也不能向已有的属性添加属性观察者。
//扩展能为类添加新的便捷初始化器，但是不能为类添加指定初始化器或反初始化器。指定初始化器和反初始化器 必须由原来类的实现提供。



//添加计算属性
extension Double {
    var km: Double {return self * 1_000.0}
    var m: Double {return self}
    var cm: Double {return self / 100.0}
    var mm: Double {return self / 1_000.0}
    var ft: Double {return self / 3.28084}
}
let oneInch = 25.4.mm
print("One inch is \(oneInch) meters")
let threeFeet = 3.ft
print("There feet is \(threeFeet) meters")

let aMarathon = 42.km + 195.m
print("A marathon is \(aMarathon) meters long")


//添加初始化器
struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
}
