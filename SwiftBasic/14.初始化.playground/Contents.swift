import UIKit

// 初始化器不返回值
// 在创建类和结构体的实例时必须为所有的存储属性设置一个合适的初始值

struct Fahrenheit {
    var temperature: Double
    init() {
        //存储属性必须给初始化值
        temperature = 32.0
    }
}
var f = Fahrenheit()
print("The default temperature is \(f.temperature)° Fahrenheit")


//初始化形式参数
struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    
    //无实际参数标签的初始化器形式参数
    init(_ celsius: Double) {
        temperatureInCelsius = celsius
    }
}
let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
let freezingPointOfWater = Celsius(fromKelvin: 273.15)
let bodyTemperature = Celsius(37.0)



//如果你没有提供外部名 Swift 会自动为每一个形式参数提供一个外部名称。

// 形式参数名和实际参数标签
struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    init(white: Double) {
        red = white
        green = white
        blue = white
    }
}
let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)



//可选属性类型
class SurveyQuestion {
    var text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()
cheeseQuestion.response = "Yes, i do like cheese"



//在初始化中分配常量属性
class SurveyQuestion1 {
    let text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
//常量属性在初始化中只能通过引用的类来修改，不能被子类修改。
let beetsQuestion = SurveyQuestion1(text: "How about beets")
//常量属性一旦被赋值，就不能再修改了
//beetsQuestion.text = "sd"



//默认初始化器
class ShoppingListItem {
    var name: String?
    var quantitiy = 1
    var purchased = false
}
var item = ShoppingListItem()



//结构体类型的成员初始化器
//结构体会接收成员初始化器即使它的存储属性没有默认值。
struct Size{
    var width = 0.0, height = 0.0
}
let twoByTwo = Size(width: 2.0, height: 2.0)


//指定初始化器和便捷初始化器
/*
 指定初始化器必须总是向上委托，便捷初始化器必须总是横向委托：
 - 指定初始化器必须从它的直系父类调用指定初始化器。
 - 便捷初始化器必须从相同的类里调用另一个初始化器。
 - 便捷初始化器最终必须调用一个指定初始化器。


 便捷初始化器 convenience
 convenience init(parameters) {
    statements
 }
 */


//两段式初始化
//第一段：所有存储属性被赋值，一旦所有存储属性的初始状态确定了，就会开始第二段
//第二段：实例在可用之前每个类有机会进一步定制其存储属性

// # 初始化器的继承与重写
//子类不会默认继承父类的初始化器
//当重写父类指定初始化器时，你必须写 override 修饰符，就算你子类初始化器的实现是一个便捷初始化器。


// 可失败初始化器
//初始化器没有返回值，它的角色是确保在初始化结束时self能够被正确初始化
struct Animal {
    let species: String
    init?(species: String){
        if species.isEmpty {
            //可用return nil触发初始化失败，但不能使用return关键字表示初始化成功
            return nil;
        }
        self.species = species
    }
}
let someCreature = Animal(species: "Giraffe")
if let giraffe = someCreature {
    print("An animal wai initialized with a specied of \(giraffe.species)")
}

let anonymousCreature = Animal(species: "")
if anonymousCreature == nil {
    print("The anonymous creature could not be initialized")
}

//枚举的可失败初始化器
enum TemperatureUnit {
    case Kelvin, Celsius, Fahrenheit
    init?(symbol: Character){
        switch symbol {
        case "K":
            self = .Kelvin
        case "C":
            self = .Celsius
        case "F":
            self = .Fahrenheit
        default:
            return nil
        }
    }
}

//带有原始值枚举的可失败初始化器
//带有原始值的枚举会自动获得一个可失败初始化器 init?(rawValue:)
enum TemperatureUint1: Character {
    case Kelvin = "K", Celsius = "C", Fahrenheit = "F"
}
let fahrenheitUnit = TemperatureUint1(rawValue: "F")
let unknowUint = TemperatureUint1(rawValue: "X")
if unknowUint == nil {
    print("This is not a defined temperature unit")
}



//必要初始化器
class SomeClass {
    //required  修饰符来表明所有该类的子类都必须实现该初始化器
    required init() {
        
    }
}

class SomeSubClass: SomeClass {
    //子类重写父类的必要初始化器时，也必须加required
    required init() {
        
    }
}


//通过闭包和函数来设置属性的默认值

/*
 如果某个存储属性的默认值需要自定义或设置，你可以使用闭包或全局函数来为属性提供默认值。
 当这个属性属于的实例初始化时，闭包或函数就会被调用，并且它的返回值就会作为属性的默认值。
  */
//class OneClass {
//    let oneProperty: Int = {
//        return someValue
//    }()
//}


struct Chessboard {
    let boardColors: [Bool] = {
        var temporaryBoard = [Bool]()
        var isBlack = false
        for i in 1...8 {
            for j in 1...8 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }()
    
    func squareIsBlackAt(row: Int, column: Int) -> Bool {
        return boardColors[row * 8 + column]
    }
}

let board = Chessboard()
print(board.squareIsBlackAt(row: 0, column: 1))
print(board.squareIsBlackAt(row: 7, column: 7))
