import UIKit

// # 协议语法
protocol FirstProtocol {
    
}
protocol SecondProtocol {
    
}
struct SomeStructure: FirstProtocol, SecondProtocol {
    
}
class SpuperClass {
    
}
//继承必须在前，协议在后
class SubClass: SpuperClass, FirstProtocol, SecondProtocol {
    
}



// # 属性要求
//协议并不会具体说明属性是存储型属性还是计算型属性---它只具体要求属性有特定的名称和类型。协议同时要求一个属性必须是可读的或可读可写的
protocol SomeProtocol {
    //定义可变属性，可读可写
    var mutBeSettable: Int {get set}
    //定义可变属性，只读
    var doesNotNeedToBeSettable: Int {get}
}

protocol AnotherProtocol {
    //定义类型属性
    static var someTypeProperty: Int {get set}
}


//遵循改协议的类必须有一个可读的可变属性fullName
protocol FullyNamed {
    var fullName: String {get}
}
struct Person: FullyNamed {
    var fullName: String
}
let john = Person(fullName: "John Appleseed")


class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }
}
var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
print(ncc1701.fullName)




// # 方法要求
//在协议的定义中，方法参数不能定义默认值
protocol RandomNumberGenerator {
    //不需要大括号和方法的主体，允许拥有参数
    func random() -> Double // 定义实例方法 返回Double值，尽管协议没有明确定义，这里默认这个值在0.0到1.0(不包括)之间
//    static func someTypeMethod() // 定义类方法
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy: m))
        return lastRandom / m
    }
}
let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
print("And another one: \(generator.random())")





// # 异变方法要求
protocol Toggleable {
    mutating func toggle()
}

//mutating只对值类型有效，因为值类型属性不能被自身的实例方法修改
//mutating 关键字只在结构体和枚举类型中需要书写。
enum OnOffSwitch: Toggleable {
    case off, on
    //需要mutating
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}
var lightSwitch = OnOffSwitch.off
lightSwitch.toggle()




// # 初始化要求
protocol SomeProtocol1 {
    init(someParam: Int)
}
//实现协议定义的指定初始化器或便捷初始化器，必须使用required关键字修饰初始化器的实现
class SomeClass1: SomeProtocol1 {
    required init(someParam: Int) {
        
    }
}

//如果协议初始化器实现类使用了final，就不需要使用required来修饰

//如果一个子类重写了父类指定初始化器，并遵循协议实现了初始化器要求，那么就要为这个初始化器的实现添加required和override两个修饰符
protocol SomerProtocol2 {
    init()
}
class SomeSuper{
    init() {
        
    }
}
class SomeSub: SomeSuper, SomerProtocol2 {
    required override init() {
        
    }
}





// # 将协议作为类型
//协议是一个类型，协议可以变为一个功能完备的类型在代码中使用
//- 在函数、方法或者初始化器里作为形式参数类型或者返回类型
//- 作为常量、变量或者属性的类型
//- 作为数组、字典或者其他存储器的元素的类型

class Dice {
    let sides: Int
    let generator: RandomNumberGenerator //协议类型常量
    init(sides: Int, generator: RandomNumberGenerator) {//协议类型作为入参
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        //协议方法random
        return Int(generator.random() * Double(sides)) + 1
    }
}

var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
for _ in 1...5 {
    print("Random dice roll is \(d6.roll())")
}





// # 委托
protocol DiceGame {
    var dice: Dice{get}
    func play()
}
protocol DiceGameDelegate {
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(_ game: DiceGame)
}

class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    init() {
        board = Array(repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    var delegate: DiceGameDelegate?
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
}

class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    func gameDidStart(_ game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Start a new game of Snakes and Ladders")
        }
        print("The game is using a \(game.dice.sides)-sided dice")
    }
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    func gameDidEnd(_ game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
}

let tracker = DiceGameTracker()
let game = SnakesAndLadders()
game.delegate = tracker
game.play()






// # 在扩展里添加协议遵循
protocol TextRepresentable {
    var textualDescription: String {get}
}

extension Dice: TextRepresentable {
    var textualDescription: String {
        return "A \(sides)-sided dice"
    }
}

let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
print(d12.textualDescription)


//有条件地遵循协议
extension Array: TextRepresentable where Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map{ $0.textualDescription }
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}
let myDice = [d6, d12]
print(myDice.textualDescription)


//使用扩展声明采纳协议
struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
}
//Hamster已经遵循了协议的所有需求，但是还没有声明它采纳了这个协议，你可以让通过一个空的扩展来让它采纳这个协议
extension Hamster: TextRepresentable {}

let simonTheHamster = Hamster(name: "Simon")
let somethingTextRepresentable: TextRepresentable = simonTheHamster
print(somethingTextRepresentable.textualDescription)




// # 协议类型的集合
//协议可以用作储存在集合比如数组或者字典中的类型
let things: [TextRepresentable] = [d12, simonTheHamster]
for thing in things {
    print(thing.textualDescription)
}


// # 协议继承   允许多继承
protocol PrettyTextRespresentable: TextRepresentable {
    var prettyTextualDescription: String { get } //添加只读属性
}

//extension SnakesAndLadders: PrettyTextRespresentable {
//    var prettyTextualDescription: String {
//        var output = textualDescription + ":\n"
//        for index in 1...finalSquare {
//            switch board[index] {
//            case let ladder where ladder > 0:
//                output += "▲ "
//            case let snake where snake < 0:
//                output += "▼ "
//            default:
//                output += "○ "
//            }
//        }
//        return output
//    }
//}






// # 类专用的协议
//添加AnyObject关键字限制协议只能被类类型采纳

//protocol SomeClassOnlyProtocol: AnyObject, SomeInheritedProtocol {
//
//}




// # 协议组合
protocol Named {
    var name: String { get }
}
protocol Aged {
    var age: Int { get }
}
struct Person1: Named, Aged {
    var name: String
    var age: Int
}

//接受同时遵守Named和Aged协议的入参
func wishHappyBirthday(to celebrator: Named & Aged) {
    print("Happy birthday, \(celebrator.name), you're \(celebrator.age)!")
}
let birthdayPerson = Person1(name: "Malcolm", age: 21)
wishHappyBirthday(to: birthdayPerson)




// # 协议遵循的检查  与 检查和转换类型完全一样  is  as? as!
protocol HasArea {
    var area: Double { get }
}

class Circle: HasArea {
    let pi = 3.1415927
    var radius: Double
    var area: Double { return pi * radius * radius}
    init(radius: Double) {
        self.radius = radius
    }
}
class Country: HasArea {
    var area: Double
    init(area: Double) {
        self.area = area
    }
}

class Animal {
    var legs: Int
    init(legs: Int) {
        self.legs = legs
    }
}

let objects: [AnyObject] = [
    Circle(radius: 2.0),
    Country(area: 243_610),
    Animal(legs: 4)
]
for object in objects {
    if let objectWithArea = object as? HasArea {
        print("Area is \(objectWithArea.area)")
    }else {
        print("Something that doesn't have an area")
    }
}




// # 可选协议要求  optional 修饰符
//可选要求不需要强制遵循协议的类型实现
//可选要求允许你的代码与 Objective-C 操作
//协议和可选要求必须使用 @objc 标志标记
//注意 @objc 协议只能被继承自 Objective-C 类或其他 @objc 类采纳
//当你在可选要求中使用方法或属性是，它的类型自动变成可选项

@objc protocol CounterDataSource {
    @objc optional func increment(forCount count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}

class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    func increment() {
        if let amount = dataSource?.increment?(forCount: count) {
            count += amount
        }else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

class ThreeSource: NSObject, CounterDataSource {
    let fixedIncrement = 3
}

var counter = Counter()
counter.dataSource = ThreeSource()
for _ in 1...4 {
    counter.increment()
    print(counter.count)
}



// # 协议扩展
//可以通过扩展给协议添加属性和方法实现
extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
}
let generator1 = LinearCongruentialGenerator()
print("Here's a random number: \(generator1.random())")
print("And here's a random Boolean: \(generator1.randomBool())")

//可以使用协议扩展来给协议的任意方法或者计算属性要求提供默认实现
extension PrettyTextRespresentable {
    var prettyTextualDescription: String {
        return textualDescription
    }
}

//给协议扩展添加限制
extension Collection where Iterator.Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}
