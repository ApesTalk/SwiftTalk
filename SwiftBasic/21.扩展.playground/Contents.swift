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

let defaultRect = Rect()//默认初始化器
//成员初始化器
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0),
                          size: Size(width: 5.0, height: 5.0))

//如果你使用扩展提供了一个新的初始化器，你仍应确保每一个实例都在初始化完成时完全初始化。
extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))


//添加方法
extension Int {
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}

3.repetitions {
    print("Hello!")
}




//异变实例方法
//增加了扩展的实例方法仍可以修改（或异变）实例本身。结构体和枚举类型方法在修改 self 或本身的属性时必须标记实例方法为 mutating ，和原本实现的异变方法一样。
extension Int {
    mutating func square() {
        self = self * self
    }
}
var someInt = 3
someInt.square()




//添加下标
extension Int {
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}
76381295[0]
746381295[1]
746381295[2]
746381295[8]



//添加嵌套类型
extension Int {
    enum Kind {
        case negative, zero, positive
    }
    var kind: Kind {
        switch self {
        case 0:
            return .zero
        case let x where x > 0:
            return .positive
        default:
            return .negative
        }
    }
}

func printIntegerKinds(_ numbers: [Int]) {
    for number in numbers {
        switch number.kind {
        case .negative:
            print("- ", terminator: "")
        case .zero:
            print("0 ", terminator: "")
        case .positive:
            print("+ ", terminator: "")
        }
    }
}
printIntegerKinds([3, 19, -27, 0, -6, 0, 7])
