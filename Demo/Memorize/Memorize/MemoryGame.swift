//
//  MemoryGame.swift
//  Memorize
//
//  Created by ApesTalk on 2020/6/20.
//  Copyright © 2020 https://github.com/ApesTalk. All rights reserved.
//  Model层

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    //外部可读但不能写
    private(set) var cards: Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
//            var faceUps = cards.indices.filter { (index) -> Bool in
//                return cards[index].isFaceUp
//            }
            //尾随闭包
//            let faceUps = cards.indices.filter { cards[$0].isFaceUp }
//            return faceUps.only
            
            //可以省去return
            cards.indices.filter { cards[$0].isFaceUp }.only
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }

    mutating func choose(card: Card) {
        print("card chosen: \(card)")
        
        //Cannot assign to property: 'card' is a 'let' constant Swift中的Struct是值类型，在作为参数传递的过程中都是copy的副本，这里既是改了card的属性，也不会改变cards数组中元素的属性
//        card.isFaceUp = !card.isFaceUp
        
        
        if let choosenIndex = self.cards.firstIndex(matching: card), !cards[choosenIndex].isFaceUp, !cards[choosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                //遵守了Equatable协议，这里content是字符串类型，所以可以用==
                if cards[choosenIndex].content == cards[potentialMatchIndex].content {
                    cards[choosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                self.cards[choosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = choosenIndex
            }
            //Cannot assign to property: 'self' is immutable 提示self是不可变的，需将方法改为mutating，Swift的实例方法默认不能修改值类型的属性。
//          self.cards[choosenIndex].isFaceUp = !self.cards[choosenIndex].isFaceUp
//            self.cards[choosenIndex].isFaceUp = true
        }
    }
    
    //Model本身不关心Card上展示什么内容，交由viewModel（EmojiMemory）去处理
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for index in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(index)
            //Card内没有设置默认值的时候
//            cards.append(Card(isFaceUp: false, isMatched: false, content: content, id: index))
            //Card内设置了默认值时
            cards.append(Card(content: content, id: index * 2))
            cards.append(Card(content: content, id: index * 2 + 1))
        }
    }
    
    //外界访问 Memory<x>.Card
    //Identifiable 为了可用在ForEach中使用
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        
        var id: Int
    }
}
