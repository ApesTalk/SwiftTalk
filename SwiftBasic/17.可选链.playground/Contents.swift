import UIKit

//可选链是一个调用和查询可选属性、方法和下标的过程，它可能为 nil 。
//可选链会在可选项为 nil 时得体地失败，而强制展开则在可选项为 nil 时触发运行时错误。
//可选链调用的结果一定是一个可选值，就算你查询的属性、方法或者下标返回的是非可选值
//可选链调用的结果与期望的返回值类型相同，只是包装成了可选项


class Person {
    var residence: Residence?
}

class Residence {
    var rooms = [Room]()
    //计算属性
    var numberOfRooms: Int {
        return rooms.count
    }
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    var address: Address?
}

class Room {
    let name: String
    init(name: String) {
        self.name = name
    }
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if buildingName != nil {
            return buildingName
        }else if buildingNumber != nil && street != nil {
            return "\(buildingNumber) \(street)"
        }else{
            return nil
        }
    }
}

let john = Person()//它的residence为nil
//强制展开会触发运行时错误
//let roomCount = john.residence!.numberOfRooms


//使用? 可选链
//把可选 residence 属性“链接”起来并且取回 numberOfRooms 的值，如果 residence 存在的话。
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) rooms")
}else{
    print("Unable to retrieve the number of rooms")
}


let someAddress = Address()
someAddress.buildingNumber = "20"
someAddress.street = "Acacia Road"
john.residence?.address = someAddress //赋值失败，因为residence为nil


//通过可选链调用方法
//此处返回的是Void?类型  检查能否调用该方法
if john.residence?.printNumberOfRooms() != nil {
    print("It was possible to print the number of rooms")
}else{
    print("It was not possible to print the number of rooms")
}

//任何通过可选链设置属性的尝试都会返回一个Void?
//检查属性是否设置成功
if (john.residence?.address = someAddress) != nil {
    print("It was possible to set the address")
}else{
    print("It was not possible to set the address")
}



//通过可选链访问下标
if let firstRoomName = john.residence?[0].name {
    print("The first room name is \(firstRoomName)")
}else{
    print("Unable to retrieve the first room name")
}


//访问可选类型的下标
var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0] += 1
testScores["Brian"]?[0] = 72 //设置失败



//链的多层连接
//可以通过连接多个可选链来在模型中深入访问属性、方法和下标。多层可选链不会给返回的值添加多层的可选性。
if let johnStreet = john.residence?.address?.street {
    print("John's street name is \(johnStreet)")
}else{
    print("Unable to retrieve the address")
}


//用可选返回值链接方法
//检查buildingIdentifier方法返回值
if let beginWithThe = john.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
    if beginWithThe {
        print("John's building identifier begins with 'The'")
    }else {
        print("John;s building identifier does not beign with the")
    }
}
