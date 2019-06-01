import UIKit

// # 类和结构体对比
/*
 类和结构体都能：
 1.定义属性用来存储值
 2.定义方法用来提供功能
 3.定义下标脚本用来允许使用下标语法访问值
 4.定义初始化器用于初始化状态
 5.可以被扩展来实现默认所没有的功能
 6.遵循协议来针对特定类型提供标准功能
 
 类有，结构体没有的：
 1.继承
 2.类型转换：允许在运行检查和解释一个类实例的类型
 3.反初始化器：允许一个类实例释放其所被分配的资源
 4.引用计数
 */

//定义
struct Resolution {
    var width = 0
    var height = 0
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}


//实例
let someResolution = Resolution()
let someVideoMode = VideoMode()


//属性
print("The width of someResolution is \(someResolution.width)")
someVideoMode.resolution.width = 1200
print("The width of someVideoMode is now \(someVideoMode.resolution.width)")


//结构体类型的成员初始化器
//所有结构体都会有一个自动生成的成员初始化器
let vga = Resolution(width: 640, height: 380)




// # 结构体和枚举是值类型
//当它被指定到常量或变量或者被传递给函数时会被拷贝
let hd = Resolution(width: 1920, height: 1080)
var cinema = hd//复制 两个不同的实例 互不影响

cinema.width = 2048
print("cinema is now \(cinema.width) pixels wide")
print("hd is still \(hd.width) pixels width")


enum CompassPoint {
    case North, South, East, West
}
var currentDirction = CompassPoint.West
let rememberDirction = currentDirction
currentDirction = .East
if rememberDirction == .West {
    print("The rememberd direction is still .West")
}




// # 类是引用类型
let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0
//alsoTenEighty和tenEighty都引用了相同的VideoMode
print("The framerRate property of tenEighty is now \(tenEighty.frameRate)")

//特征运算符  ===  !==
//===相同于: 两个类类型常量或变量引用自相同的实例
if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
}



// # 字符串，数组和字典的赋值与拷贝
//String Array Dictionary是结构体类型，传递的是拷贝
