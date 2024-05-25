//
//  MWPopMenuConfigure.swift
//  calculator_tools
//
//  Created by LiYing on 2024/5/23.
//  Copyright © 2024 Nnwise. All rights reserved.
//

import UIKit

struct MWPopMenuItemConfigure {
    var textFont: UIFont = UIFont.systemFont(ofSize: 17)
    var textColor: UIColor = .black
    var textDisabledColor: UIColor = .gray
    
    static var `default`: Self {
        return MWPopMenuItemConfigure()
    }
}

struct MWPopMenuConfigure {
    var width: CGFloat = UIScreen.main.bounds.width
    var backgroundColor: UIColor = .white
    var cornorRadius: CGFloat = 6
    var itemHeight: CGFloat = 44
    var splitLineColor: UIColor = .gray
    var iconLeftMargin: CGFloat = 15
    var margin: CGFloat = 10
    var alpha: CGFloat = 0.3
    var itemConfigure: MWPopMenuItemConfigure = MWPopMenuItemConfigure.default
    
    static var `default`: Self {
        return MWPopMenuConfigure()
    }
}
