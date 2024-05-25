//
//  MWPopMenuModel.swift
//  calculator_tools
//
//  Created by LiYing on 2024/5/23.
//  Copyright © 2024 Nnwise. All rights reserved.
//

import UIKit

public struct MWPopMenuModel {
    public var isEnabled: Bool = true
    public var icon: UIImage?
    public var title: String?
    
    public init(icon: UIImage?, title: String?, isEnabled: Bool = true) {
        self.icon = icon
        self.title = title
        self.isEnabled = isEnabled
    }
}
