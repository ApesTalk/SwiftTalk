//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by ApesTalk on 2020/6/21.
//  Copyright © 2020 https://github.com/ApesTalk. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil
    }
}
