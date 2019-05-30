import UIKit

// # for-in
let names = ["Anna", "Alex", "Brian", "Jack"]
for name in names {
    print("hello, \(name)")
}

let numberofLegs = ["Spider": 8, "ant": 6, "cat": 4]
for (name, leg) in numberofLegs {
    print("\(name)s have \(leg) legs")
}

//index是隐式的let常量，每次for循环重新赋值
for index in 1...5{
    print(index)
}

let base = 3
let power = 10
var answer = 1
//闭区间
for _ in 1...power {
    answer *= base
}
print(answer)

//半开区间
let minutes = 60
for tickMark in 0..<minutes{
//    print(tickMark)
}

let minuteInterval = 5
//返回从起始值到结束值（不包括结束值）的序列，并按指定的量递增。
for tickMark in stride(from: 0, to: minutes, by: minuteInterval){
//    print(tickMark)
}

let hours = 12
let hourInterval = 3
//可能包含结束值，如果hours=11就不会包含结束值
for tickMark in stride(from: 3, through: hours, by: hourInterval){
    print(tickMark)//3 6 9 12
}




// # while


// # repeat-while  类似其他语言的do-while
var i = 0
repeat {
    i += 1
    print(i)
} while i < 5



// # if


// # switch
let someCharacter: Character = "z"
//switch必须是全面的，必须考虑全部可能情况，如果无法提供一个匹配所有情况的值，需提供default
switch someCharacter {
case "a":
    print("The first letter of alphabet")
case "z":
    print("The last letter of alphabet")
default:
    print("Some other character")
}
//switch不会隐式贯穿，会在匹配到第一个 switch 情况执行完毕之后退出，不再需要显式的 break 语句。这使得 switch 语句比 C 的更安全和易用，并且避免了意外地执行多个 switch 情况。

//每一个情况的函数体必须包含至少一个可执行的语句，避免意外地从一个情况贯穿到另一个情况中，并且让代码更加安全和易读。
let anotherCharacter: Character = "a"
//switch anotherCharacter {
//case "a":
//case "A":
//    print("The letter A")
//default:
//    print("Not the letter A")
//}
//应该这样写
switch anotherCharacter {
case "a", "A":
    print("The letter A")
default:
    print("Not the letter A")
}


//区间匹配
let approximateCount = 62
let countedThings = "moons orbiting Saturn"
var naturalCount: String
switch approximateCount {
case 0:
    naturalCount = "no"
case 1..<5:
    naturalCount = "a few"
case 5..<12:
    naturalCount = "several"
case 12..<100:
    naturalCount = "dozens of"
case 100..<1000:
    naturalCount = "hundreds of"
default:
    naturalCount = "many"
}
print("There are \(naturalCount) \(countedThings)")


//元组匹配
//元组中的每个元素都可以与不同的值或者区间进行匹配，可以使用_来匹配所有可能的值，允许多个case判断判断相同的值，只有第一个匹配到的case被使用
let somePoint = (1, 1)
switch somePoint {
case (0, 0):
    print("(0, 0) is at the origin)")
case (_, 0):
    print("\(somePoint.0), 0) is on the x-axis")
case (0, _):
    print("(0, \(somePoint.1) is on the y-axis")
case (-2...2, -2...2):
    print("(\(somePoint.0), \(somePoint.1)) is inside the box")
default:
    print("(\(somePoint.0), \(somePoint.1)) is outside of the box")
}


//值绑定：switch的case可将匹配到值临时绑定为一个常量或变量给case的函数使用
let anotherPoint = (2, 0)
switch anotherPoint {
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis with a y value of \(y)")
case let(x, y):
    print("somewhere else at (\(x), \(y))")
}


//where分句在case中检查额外的情况 动态过滤
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let(x, y) where x == y:
    print("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:
    print("(\(x), \(y)) is on the line x == -y")
case let(x, y):
    print("(\(x), \(y)) is just some arbitrary point")
}


//复合情况
switch someCharacter {
case "a", "e", "i", "o", "u":
    print("\(someCharacter) is a vowel")
    //如果模式太长，可以写成多行
case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
     "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
    print("\(someCharacter) is a consonant")
default:
    print("\(someCharacter) is not a vowel or a consonant")
}

//复合情况值绑定，所有复合情况的模式都必须包含相同的值绑定集合并且数据类型一致
let stillAnotherPoint = (9, 0)
switch stillAnotherPoint {
case (let distance, 0), (0, let distance):
    //case代码中一定可以访问distance的值
    print("On an axis, \(distance) from the origin")
default:
    print("Not on an axis")
}




// # 控制转移语句 continue break fallthrough return throw

//fallthrough：允许贯穿到下个case
let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
case 2, 3, 5, 7, 11, 13, 17, 19:
    description += " a prime number, and also"
    fallthrough
default:
    description += " an integer"
}
print(description)


//打标签 内嵌循环和条件语句到其他循环和条件语句中时，通过标签使逻辑更清晰
var x = 0
loopTag: while x < 10 {
    x += 1
    switch x {
    case 5:
        break loopTag //明确break的是while循环而不是switch。如果不加tag，则break的是switch
    case let n where n > 2:
        continue loopTag//这里加不加tag都是continue while因为只有一个while循环
    default:
        print("")
    }
}
print(x)




// # 提前退出 guard语句 总是有else语句，条件不为真时执行else里面的代码
func greet(person: [String: String]){
    guard let name = person["name"] else {
        //else里面不能使用
//        print(name)
        return
        //必须转移控制结束 guard 所在的代码块。要这么做可以使用控制转移语句比如 return ， break ， continue 或者 throw ，或者它可以调用一个不带有返回值的函数或者方法，比如 fatalError() 。
    }
    
    //任何在条件中使用可选绑定而赋值的变量或常量在guard所在的代码块随后的代码里都是可用的
    print("hello \(name)!")
    
    guard let location = person["location"] else {
        print("I hope the weather is nice near you")
        return
    }
    
    print("I hope the weather is nice in \(location)")
}
greet(person: ["name": "John"])
greet(person: ["name": "Jane", "location": "Cupertino"])



// # 检查API可用性
if #available(iOS 10, macOS 10.12, *) {
    //
}else{
    
}

