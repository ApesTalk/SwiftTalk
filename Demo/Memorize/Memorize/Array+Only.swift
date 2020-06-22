//
//  Array+Only.swift
//  Memorize
//
//  Created by ApesTalk on 2020/6/21.
//  Copyright © 2020 https://github.com/ApesTalk. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
