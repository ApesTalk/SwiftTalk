import UIKit

// # 存储属性
struct FixedLengthRange {
    var firstValue: Int
    let length: Int //常量属性
}

var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
rangeOfThreeItems.firstValue = 6


let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
//当一个值类型的实例被标记为常量时，该实例的其他属性也均为常量
//rangeOfFourItems.firstValue = 6

//延迟存储属性  必须声明为var
class DataImporter {
    var fileName = "data.txt"
}

class DataManager {
    lazy var importer = DataImporter() //不是线程安全的
    var data = [String]()
}

let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")
//lazy修饰的变量，只有在第一次被访问时才会创建
print(manager.importer.fileName)


// # 计算属性  !必须声明为var
//类，结构体和枚举可以定义计算属性，实际不存储值，提供一个读取器和一个可选设置器
struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get{
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter){
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}

var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at (\(square.origin.x), \(square.origin.y))")

//简写设置器setter声明
struct AlternativeRect {
    var origin = Point()
    var size = Size()
    var center: Point{
        get{
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set{
            //没有指定名字，默认名字为newValue
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}


//只读计算属性  只有读取器没有设置器
//!必须用var来定义计算属性，包括只读计算属性，因为他们的值是不固定的
struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}
let fourByFiveTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
print("the volume of fourByFiveTwo is \(fourByFiveTwo.volume)")



// # 属性观察者  除了延迟存储属性，其他属性都可添加属性观察者
//属性值被设置时，属性观察者都会被调用，即使这个值与该属性当前值相同
class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalsteps){ //默认newValue
            print("About to set totalSteps to \(newTotalsteps)")
        }
        didSet {
            //默认oldValue
            if totalSteps > oldValue {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}
let stepCounter = StepCounter()
stepCounter.totalSteps = 200
stepCounter.totalSteps = 360
stepCounter.totalSteps = 896



// # 全局属性和局部属性
//全局变量和常量都是延迟计算的，和延迟属性行为一样，只是不需要加lazy


// # 类型属性  static   属于类型本身的属性
//存储类型属性必须给默认值
struct SomeStructure {
    //存储类型属性
    static var storedTypeProperty = "Some value"
    //计算类型属性
    static var computedTypeProperty: Int {
        return 1
    }
}
enum SomeEnumration {
    static var storedTypeProperty = "Some value"
    static var computedTypeProperty: Int {
        return 6
    }
}
class SomeClass {
    static var storedTypeProperty = "Some value"
    static var computedTypeProperty: Int {
        return 27
    }
    //使用class关键字来允许子类重写父类的实现
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}

print(SomeStructure.storedTypeProperty)
SomeStructure.storedTypeProperty = "Another value"
print(SomeStructure.storedTypeProperty)
print(SomeEnumration.computedTypeProperty)
print(SomeClass.computedTypeProperty)
