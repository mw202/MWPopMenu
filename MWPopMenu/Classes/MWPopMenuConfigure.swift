//
//  MWPopMenuConfigure.swift
//  calculator_tools
//
//  Created by LiYing on 2024/5/23.
//  Copyright © 2024 Nnwise. All rights reserved.
//

import UIKit

public struct MWPopMenuItemConfigure {
    public var textFont: UIFont = UIFont.systemFont(ofSize: 17)
    public var textColor: UIColor = .black
    public var textDisabledColor: UIColor = .gray
    
    public static var `default`: Self {
        return MWPopMenuItemConfigure()
    }
}

public struct MWPopMenuConfigure {
    public var width: CGFloat = UIScreen.main.bounds.width
    public var backgroundColor: UIColor = .white
    public var cornorRadius: CGFloat = 6
    public var itemHeight: CGFloat = 44
    public var splitLineColor: UIColor = .gray
    public var iconLeftMargin: CGFloat = 15
    public var margin: CGFloat = 10
    public var alpha: CGFloat = 0.3
    public var itemConfigure: MWPopMenuItemConfigure = MWPopMenuItemConfigure.default
    
    public static var `default`: Self {
        return MWPopMenuConfigure()
    }
}
