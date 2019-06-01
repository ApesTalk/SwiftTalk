import UIKit

// # 基本语法
// 不需要分配默认值，也不会自动从0开始。同的枚举成员在它们自己的权限中都是完全合格的值。
// 每个枚举都定义了一个全新的类型。名字一般大写，单数形式
enum CompassPoint {
    case north
    case south
    case east
    case west
}
print("north:\(CompassPoint.north), east:\(CompassPoint.east)")

var directionToHead = CompassPoint.west // 类型推断为CompassPoint
directionToHead = .east // 类型明确后就可以用点语法设置不同的值


// 一行逗号隔开
enum Planet {
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}


switch directionToHead {
case .north:
    print("Lots of planets have a north")
case .south:
    print("Watch out for penguins")
case .east:
    print("Where the sun rises")
case .west:
    print("Where the skies are blue")
}



// # 遍历枚举case  CaseIterable 来允许枚举被遍历
enum Beverage: CaseIterable {
    case coffiee, tea, juice
}
//通过allCases拿到一个包含所有case的枚举
let numberOfChoices = Beverage.allCases.count
print("\(numberOfChoices) beverages avaliable")

for beverage in Beverage.allCases {
    print(beverage)
}




// # 关联值
//声明存储不同类型的相关值
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

var productBarcode = Barcode.upc(8, 58909, 51223, 3)
productBarcode = .qrCode("ApesTalk")

//提取每一个相关值为let常量或var变量
switch productBarcode{
case .upc(let numberSystem, let manuFacturer, let product, let check):
    print("UPC: \(numberSystem), \(manuFacturer), \(product), \(check)")
case .qrCode(let productCode):
    print("QR code: \(productCode)")
}

//枚举成员的所有相关值都被提取为常量或者变量，可以单独一个var或let在成员名前标注
switch productBarcode{
case let .upc(numberSystem, manuFacturer, product, check):
    print("UPC: \(numberSystem), \(manuFacturer), \(product), \(check)")
case let .qrCode(productCode):
    print("QR code: \(productCode)")
}


// # 原始值  枚举成员可以用相同类型的默认值预先填充
//ASCIIControlCharacter的枚举原始值被定义为Character
enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}


// # 隐式指定的原始值
//枚举成员被定义为Int或String类型时，不必显示给每个成员都分配原始值，Swift会自动分配
//对于Int型，第一个默认0，成员的隐式值比前一个成员大1
enum NewPlanet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}
//rawValue访问y枚举成员的原始值
print(NewPlanet.venus.rawValue == 2)

//当字符串被用于原始值，那么每个成员的隐式原始值就是成员的名称
enum NewCompassPoint: String {
    case north, south, east, west
}
print(NewCompassPoint.north.rawValue == "north")



// # 从原始值初始化
//用原始值类型来定义一个枚举，枚举自动收到一个可接受原始值类型的值的初始化器返回一个枚举成员或者nil
let possibelPlanet = NewPlanet(rawValue: 7)//NewPlanet?


let possitionToFind = 11
if let somePoint = NewPlanet(rawValue: possitionToFind) {
    switch somePoint {
    case .earth:
        print("Mostly harmless")
    default:
        print("Not a safe place for humans")
    }
}else {
    print("There is not a planet at position: \(possitionToFind)")
}




// # 递归枚举
//递归枚举是拥有另一个枚举作为枚举成员关联值的枚举。当编译器操作递归枚举时必须插入间接寻址层。你可以在声明枚举成员之前使用 indirect关键字来明确它是递归的。
enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}

//或者
indirect enum ArithmeticExpress {
    case number(Int)
    case addition(ArithmeticExpression, ArithmeticExpression)
    case multiplication(ArithmeticExpression, ArithmeticExpression)
}

let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}

print(evaluate(product))
