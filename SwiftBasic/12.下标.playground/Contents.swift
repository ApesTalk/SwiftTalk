import UIKit

//类、结构体和枚举可以定义下标作为访问集合、列表或序列成员元素的快捷方式。
//可以为一个类型定义多个下标，下标会基于传入的索引值的类型选择合适的下标重载使用
//下标没有限制单个维度
//下标形参可以使用可变形式参数，但不能使用输入输出形参或提供默认形参值


// # 下标语法
//subscript(index: Int) -> Int {
//    get{
//
//    }
//
//    set(newValue){
//
//    }
//}

struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}
let threeTimesTable = TimesTable(multiplier: 3)
print("six times three is \(threeTimesTable[6])")



// # 下标选项
struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0, count: rows * columns)
    }
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Double {
        get{
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[row * columns + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[row * columns + column] = newValue
        }
    }
}
var matrix = Matrix(rows: 2, columns: 2)
matrix[0, 1] = 1.5
matrix[1, 0] = 3.2
