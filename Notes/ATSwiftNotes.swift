//
//  ATTableViewSectionPartner.swift
//  HumanAssistant
//
//  Created by ApesTalk on 2020/12/15.
//  Copyright © 2020 https://github.com/ApesTalk All rights reserved.
//

import Foundation


typealias CallBack = (_ obj: Any?, _ index: Int) -> Void

class Notes: NSObject {
    
    //MARK:自定义类，类名转类
    //注：Swift的类名全称为 ProjectName.ClassName
    func headerClass() -> UITableViewHeaderFooterView.Type? {
        if self.headerClassName == nil || self.headerClassName!.count == 0 {
            return nil
        }
        
        if self.headerClassName == "UITableViewHeaderFooterView" {
            return UITableViewHeaderFooterView.self
        }
        
        let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"]
        let viewClass: AnyClass? = NSClassFromString((nameSpace as! String) + "." + self.headerClassName!)
        guard let viewType = viewClass as? UITableViewHeaderFooterView.Type else {
            return nil
        }
        return viewType
    }
    
    //MARK:Swift数组中允许放nil
    let arr: [Any?] = [nil, 1, "x"]
    
    //MARK:版本判断
    if #available(iOS 13.0, *) {
        
    }
    
    //MARK:
}
