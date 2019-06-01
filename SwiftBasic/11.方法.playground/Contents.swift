import UIKit
//类、结构体和枚举都能定义实例方法和类型方法


// # 实例方法
class Counter {
    var count = 0
    func increment() {
        count += 1
    }
    func increment(by amout: Int){
        count += amout
    }
    func reset(){
        count = 0
    }
}
let counter = Counter()
counter.increment()
counter.increment(by: 5)
counter.reset()

//self
struct Point {
    var x = 0.0, y = 0.0
    //通过self 区分两个x
    func isToTheRightOf(x: Double) -> Bool {
        return self.x > x
    }
}
let somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTheRightOf(x: 1.0){
    print("This point is to the right of the line where x == 1.0")
}

// ## 在实例方法中修改值类型
//!结构体和枚举是值类型，默认情况下，值类型属性不能被自身的实例方法修改。
struct Point1 {
    var x = 0.0, y = 0.0
    //把方法异变
     mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}
var somePoint1 = Point1(x: 1.0, y: 1.0)
somePoint1.moveBy(x: 2.0, y: 3.0)
print("This point is now at (\(somePoint1.x), \(somePoint1.y))")


// 在异变方法里指定自身  异变方法可以指定整个实例给隐含的self属性
struct Point2 {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        self = Point2(x: x + deltaY, y: y + deltaY)
    }
}

enum TriStateSwitch {
    case off, low, high
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}
var ovenLight = TriStateSwitch.low
ovenLight.next()
ovenLight.next()




// # 类型方法
class SomeClass {
    //使用class关键字来允许子类重写父类的实现
    class func someTypeMethod() {
        
    }
}
SomeClass.someTypeMethod()


struct LevelTracker {
    static var highestUnlockedLevel = 1
    var currentLevel = 1
    
    static func unlock(_ level: Int) {
        if level > highestUnlockedLevel {
            highestUnlockedLevel = level
        }
    }
    
    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    
    @discardableResult
    //把这个特性用在函数或方法的声明中，当调用一个有返回值的函数或者方法却没有使用返回值时，编译器不会产生警告。
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        }else {
            return false
        }
    }
}

class Player {
    var tracker = LevelTracker()
    let playerName: String
    func complete(level: Int) {
        LevelTracker.unlock(level + 1)
        tracker.advance(to: level + 1)
    }
    init(name: String) {
        playerName = name
    }
}

var player = Player(name: "Argyrios")
player.complete(level: 1)
print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")

player = Player(name: "Beto")
if player.tracker.advance(to: 6){
    print("player is now on level 6")
}else{
    print("player 6 has not yet been unlocked")
}
