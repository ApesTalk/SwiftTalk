import UIKit

struct BlackjackCard {
    //内嵌枚举
    enum Suit: Character {
        case spades = "♠", hearts = "♡", diamonds = "♢", clubs = "♣"
    }
    
    enum Rank: Int {
        case two = 2, three, four, five, six, seven, eight, nine, ten
        case jack, queue, king, ace
        struct Values {
            let first: Int, second: Int?
        }
        var values: Values {
            switch self {
            case .ace:
                return Values(first: 1, second: 1)
            case .jack, .queue, .king:
                return Values(first: 10, second: nil)
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
    }
    
    let rank: Rank, suit: Suit
    var description: String {
        var output = "suit is \(suit.rawValue),"
        output += " value is \(rank.values.first)"
        if let second = rank.values.second {
            output += " or \(second)"
        }
        return output
    }
}

//结构体的隐式初始化器
//尽管Rank和Suit内嵌在BlackjackCard中，但气类型仍可以从上下午中推断出来
let theAceOfSpades = BlackjackCard(rank: .ace, suit: .spades)
print("theAceOfSpades: \(theAceOfSpades.description)")



//引用内嵌类型: 在外部可以通过在前缀加上内嵌了它的类的类型名即可访问
let heartsSymbol = BlackjackCard.Suit.hearts.rawValue
