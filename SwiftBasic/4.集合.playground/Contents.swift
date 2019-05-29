import UIKit

// 集合的可变不可变取决于var和let变量
// # Array  Array<Element> or [Element]
var someInts = [Int]()
someInts.append(3)
someInts = [] //someInts is a empty Array, but is still of type Array<Int>
//创建包含count个repeating的Array
var threeDoubles = Array(repeating: 0.0, count: 3) //type [Double]
//连接两个兼容类型的数组，类型从两个数组里推断
var anotherDoubles = Array(repeating: 2.5, count: 3)
var sixDoubles = threeDoubles + anotherDoubles // type [Double]
//使用数组字面量创建数组
var shoppingList: [String] = ["Eggs", "Milk"]
//访问和修改数组
print(shoppingList.count)
print(shoppingList.isEmpty)
shoppingList.append("Flour")
shoppingList += ["Baking powder", "Cheese"]
var firstItem = shoppingList[0]
shoppingList[0] = "Six eggs"
shoppingList[1...3] = ["Bananas", "Apples"]
shoppingList.insert("Maple Syrup", at: 0)
shoppingList.remove(at: 4)
shoppingList.removeFirst()
shoppingList.removeLast()
//shoppingList.removeAll()
//遍历数组
for item in shoppingList {
    print(item)
}
for (index, value) in shoppingList.enumerated() {
    print("\(index): \(value)")
}

//数组中放不同类型的对象
var arr = [Any]()
arr.append(1024)
arr.append("Swift")
print(arr)




// # Set  Set<Element>
/*加入Set中的对象必须是可哈希的，所有Swift的基础类型（Int String Double Bool）默认都是可哈希的，并且可以用于合集或者字典的键
自定义类型加入Set必须遵守Hashable协议
 */
var letters =  Set<Character>()
print(letters.count)
letters.insert("a")
letters = [] //letters is a empty Set, but is still of type Set<Character>
//使用数组字面量创建Set
var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
var favorites: Set = ["Rock", "Classical", "Hip hop"]//简写
//访问和修改Set
print(favoriteGenres.isEmpty)
favoriteGenres.insert("Jazz")
//如果存在则返回移除的值，如果不存在返回nil
if let rm = favoriteGenres.remove("Rock") {
    print("\(rm)? I'm over it.")
}else{
    print("I never much cared for that.")
}
//favoriteGenres.removeAll()
print(favoriteGenres.contains("Funk"))
//遍历Set
for genre in favoriteGenres {
    print(genre)
}

//sorted()方法，它把合集的元素作为使用 < 运算符排序了的数组返回
for genre in favoriteGenres.sorted() {
    print(genre)
}

//Set操作
let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]

//union:包含两个Set所有值
oddDigits.union(evenDigits).sorted()
//intersection:包含两个Set公有的值
oddDigits.intersection(evenDigits).sorted()
//a.subtracting(b):包含在a中不在b中的值
oddDigits.subtracting(singleDigitPrimeNumbers).sorted()
//symmetricDifference:返回两个Set非公有的值
oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted()

//Set成员关系和相等性
let houseAnimals: Set = ["?", "?"]
let farmAnimals: Set = ["?", "?", "?", "?"]
let farmAnimals1: Set = ["?", "?", "?", "?", "1"]
let cityAnimals: Set = ["?", "?"]

print(houseAnimals == cityAnimals) //相等
houseAnimals.isSubset(of: farmAnimals)//子集
farmAnimals.isSuperset(of: houseAnimals)//超集
houseAnimals.isStrictSubset(of: farmAnimals)
houseAnimals.isStrictSubset(of: farmAnimals1)
//a.isStrictSubset(of:b) a是b的子集，并且b中至少有一个值是a没有的
//a.isStrictSuperset(of:b) a是b的超集，并且a中至少有一个值是b没有的
farmAnimals1.isStrictSuperset(of: houseAnimals)
houseAnimals.isSubset(of: cityAnimals)
houseAnimals.isStrictSubset(of: cityAnimals)
farmAnimals.isDisjoint(with: cityAnimals)//判断两个Set会否拥有完全不同的值




// # Dictionary  Dictionary<Key, Value> or [Key: value]  Key必须是Hashable的
var namesOfIntegers = [Int: String]()
namesOfIntegers[16] = "sixteen"
namesOfIntegers = [:]// namesOfIntegers is an empty dictionay of type [Int: String]
//用字典字面量创建字典
var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
//访问和修改字典
print(airports.count)
print(airports.isEmpty)
airports["LHR"] = "London"
//updateValue(_:forKey:) 如果有对应key就更新，如果没有对应的key就设置，返回可选类型的旧值
if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB"){
    print("The old value for DUB was \(oldValue)")
}

//获取，返回可选类型的值
if let airportName = airports["DUB"] {
    print("The name of the airport is \(airportName)")
}else{
    print("That airport is not in the airports dictionary")
}

//通过赋值nil来移除键值对
airports["APL"] = "Apple International"
airports["APL"] = nil

//移除键值对，返回可选类型的被移除值
if let rm = airports.removeValue(forKey: "DUB"){
    print("The removed airport's name is \(rm)")
}else{
    print("The airports dicitonary does not contain a value for DUB")
}

//遍历字典
for(code, name) in airports {
    print("\(code): \(name)")
}

for code in airports.keys {
    print("code: \(code)")
}

for name in airports.values {
    print("name: \(name)")
}

let ariportCodes = [String](airports.keys.sorted())
let airportNames = [String](airports.values.sorted())
