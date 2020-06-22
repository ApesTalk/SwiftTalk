//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by ApesTalk on 2020/6/20.
//  Copyright © 2020 https://github.com/ApesTalk. All rights reserved.
//  ViewModel层

import SwiftUI

func creatCardContent(pairIndex: Int) -> String {
    return "🐷"
}

//MARK - 通过 ObservableObject， @Published， @ObservedObject 即可轻松实现Model发生改变时通知View去刷新

class EmojiMemoryGame: ObservableObject {
    //Swift语法糖不是甜的，是骚的！
//    private(set) var model: MemoryGame<String> = MemoryGame<String>(numberOfPairsOfCards: 2, cardContentFactory: creatCardContent)
    //or
//    private(set) var model: MemoryGame<String> = MemoryGame<String>(numberOfPairsOfCards: 2, cardContentFactory: { (pairIndex: Int) -> String in
//        return "🐷"
//    })
    //or 去掉类型声明
//    private(set) var model: MemoryGame<String> = MemoryGame<String>(numberOfPairsOfCards: 2, cardContentFactory: { pairIndex in
//        return "🐷"
//    })
    //or 当行函数 -> return都可以省掉
//    private(set) var model: MemoryGame<String> = MemoryGame<String>(numberOfPairsOfCards: 2, cardContentFactory: { pairIndex in "🐷" })
    //or 尾随闭包 参数名也省掉
//    private(set) var model: MemoryGame<String> = MemoryGame<String>(numberOfPairsOfCards: 2) { pairIndex in "🐷" }
    //or 内部参数也省掉
//    private(set) var model: MemoryGame<String> = MemoryGame<String>(numberOfPairsOfCards: 2) { _ in "🐷" }

    //防止外部更改model
    @Published private(set) var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    //如果不是static函数，直接private(set) var model: MemoryGame<String> = createMemoryGame()是会报错的，self还没初始化完成可用就调用了其实例方法
    //Cannot use instance member 'createMemoryGame' within property initializer; property initializers run before 'self' is available
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis = ["🐁", "🐂", "🐅", "🐇", "🐉", "🐍", "🐎", "🐏", "🐒", "🐓", "🐕", "🐖"]
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    
    //MARK - Access to the model 访问model
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    //MARK:---intent(s)意图 
    func choose(card: MemoryGame<String>.Card)  {
        model.choose(card: card)
    }
}
