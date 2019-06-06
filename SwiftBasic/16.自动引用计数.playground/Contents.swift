import UIKit

//解决循环引用问题：weak 和 unowned

// # 弱引用 weak
//弱引用不会对其引用的实例保持强引用，因而不会阻止 ARC 释放被引用的实例。这个特性阻止了引用变为循环强引用。
//由于弱引用不会强保持对实例的引用，所以说实例被释放了弱引用仍旧引用着这个实例也是有可能的。
//因此，ARC 会在被引用的实例被释放是自动地设置弱引用为 nil 。
//由于弱引用需要允许它们的值为 nil ，它们一定得是可选类型。
//在 ARC 给弱引用设置 nil 时不会调用属性观察者。

//场景：两个属性都允许为nil
class Person {
    let name: String
    init(name: String) {
        self.name = name
    }
    var apartment: Apartment?
    deinit {
        print("\(name) is being deinitialized")
    }
}

class Apartment {
    let unit: String
    init(unit: String) {
        self.unit = unit
    }
    //弱引用
    weak var tenant: Person?
    deinit {
        print("Apartment \(unit) is being deinitialized")
    }
}


var john: Person?
var unit4A: Apartment?

john = Person(name: "John Appleseed")
unit4A = Apartment(unit: "4A")
//关联
john!.apartment = unit4A
unit4A!.tenant = john

//释放
john = nil
unit4A = nil




// # 无主引用 unowned
//无主引用不会牢牢保持住引用的实例，无主引用假定是永远有值的。因此，无主引用总是被定义为非可选类型。
//由于无主引用是非可选类型，你不需要在使用它的时候将它展开。无主引用总是可以直接访问。
//ARC 无法在实例被释放后将无主引用设为 nil

//场景：一个属性值允许为nil，两一个属性值不允许为nil
class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

class CreditCard {
    let number: UInt64
    //无主引用
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit {
        print("Card #\(number) is being deinitialized")
    }
}

var bob: Customer?
bob = Customer(name: "Bob")
bob!.card = CreditCard(number: 1234_5678_9012_3456, customer: bob!)
//释放customer，导致两个对象都释放
bob = nil;







// # 无主引用和隐式展开的可选属性
//场景：两个属性都必须有值

class Country {
    let name: String
    //隐式展开可选属性，默认为nil，但是不需要展开它的值就能访问它。
    //在初始化器init中name赋值成功后就实例化完成了，self就可以使用了
    var capitalCity: City!
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
}

class City {
    let name: String
    unowned let country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}

//意义在于可以通过一行代码就同时创建Country和City实例，而不产生循环引用
var country = Country(name: "China", capitalName: "Beijing")
//像使用非可选项一样使用和存取，不用展开就能使用
print("\(country.name)'s capital city is called \(country.capitalCity.name)")




// # 闭包的循环引用   闭包捕获列表
//闭包是引用类型

class HTMLELement {
    let name: String
    let text: String?
    
    //闭包
    lazy var asHTML: () -> String = {
        //!Swift要求闭包中使用self.somProperty来访问成员变量，这有助于提醒你可能会一不小心就捕获了 self。
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
          return "<\(self.name)/>"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

let heading = HTMLELement(name: "h1")
let defaultText = "Some default text"
heading.asHTML = {
    return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
}
print(heading.asHTML())

var paragraph: HTMLELement? = HTMLELement(name: "p", text: "hello")
print(paragraph!.asHTML())

//释放不掉
paragraph = nil



// # 解决闭包的循环强引用

// 定义捕获列表
//捕获列表中的每一项都由 weak 或 unowned 关键字与类实例的引用（如 self ）或初始化过的变量（如 delegate = self.delegate! ）成对组成。这些项写在方括号中用逗号分开。
//lazy var someClosure: (Int, String) -> String = {
//    [unowned self, weak delegate = self.delegate!] (index: Int, stringToProcess: String) -> String in
//}


// 弱引用和无主引用
//在闭包和捕获的实例总是互相引用并且总是同时释放时，将闭包内的捕获定义为无主引用。
//相反，在被捕获的引用可能会变为 nil 时，定义一个弱引用的捕获。弱引用总是可选项，当实例的引用释放时会自动变为 nil 。这使我们可以在闭包体内检查它们是否存在。


class HTMLELement1 {
    let name: String
    let text: String?
    
    //闭包
    lazy var asHTML: () -> String = {
        //!Swift要求闭包中使用self.somProperty来访问成员变量，这有助于提醒你可能会一不小心就捕获了 self。
        //捕获列表：用无主引用而不是强引用来捕获self
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name)/>"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}
var paragraph1: HTMLELement1? = HTMLELement1(name: "p", text: "hello, world")
print(paragraph1!.asHTML())
//解除循环引用-可以释放
paragraph1 = nil

