import UIKit

class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeMoise() {
        
    }
}

let someVehicle = Vehicle()
print("Vehicle: \(someVehicle.description)")


class Bicycle: Vehicle {
    var hasBasket = false
}

let bicycle = Bicycle()
bicycle.hasBasket = true
bicycle.currentSpeed = 15.0
print("Bicycle: \(bicycle.description)")


//重写
class Train: Vehicle {
    override func makeMoise() {
        print("Choo Choo")
    }
}
let t = Train()
t.makeMoise()

class Car: Vehicle {
    var gear = 1
    override var description: String {
        return super.description + " in gear \(gear)"
    }
}
let c = Car()
c.currentSpeed = 25.0
c.gear = 3
print("Car: \(c.description)")


//重写属性观察器
class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}
let automic = AutomaticCar()
automic.currentSpeed = 35.0
print("AutomicCar: \(automic.description)")


//防止重写
//final var, final func, final class func, final subscript, final class
