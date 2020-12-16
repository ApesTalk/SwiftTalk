//
//  Grid.swift
//  Memorize
//
//  Created by ApesTalk on 2020/6/21.
//  Copyright © 2020 https://github.com/ApesTalk. All rights reserved.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    private var items: [Item]
    private var viewForItem: (Item) -> ItemView
    
    //逃逸闭包  在之后会用到的代码块   函数式编程
    init(_ items: [Item], viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.viewForItem = viewForItem
    }
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: GridLayout(itemCount: self.items.count, in: geometry.size))
        }
    }
    
    private func body(for layout: GridLayout) -> some View {
        ForEach(items) {item in
            self.body(for: item, in: layout)
        }
    }
    
    private func body(for item: Item, in layout: GridLayout) -> some View {
        let index = items.firstIndex(matching: item)
        //如果这样的话，在index为nil时不知道该怎么返回 some View，利用Group，其中如果没有内容也不会编译失败
//        if index != nil {
//            return viewForItem(item)
//                .frame(width: layout.itemSize.width, height: layout.itemSize.height)
//                .position(layout.location(ofItemAt: index!))
//        }
        
        
        return Group {
            if index != nil {
                viewForItem(item)
                .frame(width: layout.itemSize.width, height: layout.itemSize.height)
                .position(layout.location(ofItemAt: index!))
            }
        }
    }
}
