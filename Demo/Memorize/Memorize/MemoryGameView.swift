//
//  ContentView.swift
//  Memorize
//
//  Created by ApesTalk on 2020/6/19.
//  Copyright © 2020 https://github.com/ApesTalk. All rights reserved.
//  View层

import SwiftUI

struct MemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame

    var body: some View {
//        RoundedRectangle(cornerRadius: 10)
//        Text("Hello, World!")
        
        //ZStack 在所有轴上对齐所有子视图
//        ZStack(content: {
//            //背景
//            RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
//            RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3)
//            Text("🐶").font(Font.largeTitle)
//        })
//            .padding()
//            .foregroundColor(Color.red)
        
        //HStack 在水平坐标轴上对齐所有子视图
//        HStack(content: {
//            Text("🐶")
//            Text("🐱")
//            Text("🐷")
//        })
        
        //循环 ,右侧会显示多个preview
//        ForEach(0..<4, content: { index in
//            ZStack(content: {
//                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
//                RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3)
//                Text("🐶").font(Font.largeTitle)
//            })
//        })
//            .padding()
//            .foregroundColor(Color.red)
        
        
        //水平布局
        //Swift的尾随闭包：如果方法的最后一个参数是一个函数或者创建某些对象的代码块，可以去掉标签，把花括号写在方法外面
//        HStack(content: {
//            ForEach(0..<4, content: {index in
//                ZStack(content: {
//                    RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
//                    RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3)
//                    Text("🐱")
//                })
//            })
//        })
//            .padding()
//            .font(Font.largeTitle)
//            .foregroundColor(Color.red)
        
        
        //ForEach可以简写为
//        ForEach(0..<4) { index in
//            Text("尾随闭包")
//        }

        //封装
//        VStack {
//            ForEach(viewModel.cards) { card in
//                CardView(card: card).onTapGesture {
//                    //点击事件也交给viewModel处理
//                    self.viewModel.choose(card: card)
//                }
//            }
//        }
//            .padding()
////            .font(Font.largeTitle)
//            .foregroundColor(Color.orange)
        
        //网格
        Grid(viewModel.cards) { card in
            CardView(card: card).onTapGesture {
                //点击事件也交给viewModel处理
                self.viewModel.choose(card: card)
            }
                .padding(5)
        }
            .padding()
        //  .font(Font.largeTitle)
            .foregroundColor(Color.orange)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    //ViewBuilder把许多具有相同特点的view封装起来，并且分离逻辑代码和视图，提高代码的可复用性，增强可读性。
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                //绘图 closewise概念是反着来的？
                Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(110-90), clockwise: true)
                    .padding(5)
                    .opacity(0.4)
                Text(card.content).font(Font.system(size: fontSize(for: size)))
            }
            .modifier(Cardify(isFaceUp: card.isFaceUp))
        }
    }
    
    //MARK - Drawing constants
//    private let cornerRadius: CGFloat = 10.0
//    private let edgeLineWidth: CGFloat = 3.0
    
    private func fontSize(for size: CGSize) -> CGFloat {
        return min(size.width, size.height) * 0.65
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        //方便调整代码后通过右侧的cavas实时预览效果
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return MemoryGameView(viewModel: game)
    }
}
