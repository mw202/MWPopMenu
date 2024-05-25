//
//  MWPopMenuItemTableViewCell.swift
//  calculator_tools
//
//  Created by LiYing on 2024/5/23.
//  Copyright © 2024 Nnwise. All rights reserved.
//

import UIKit

public class MWPopMenuItemTableViewCell: UITableViewCell {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imageViewIcon: UIImageView!
    @IBOutlet weak var viewBottomLine: UIView!
    @IBOutlet weak var layoutIconLeft: NSLayoutConstraint!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        backgroundColor = .clear
    }

    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: -
    
    func setCell(_ model: MWPopMenuModel,
                 configure: MWPopMenuConfigure?,
                 isLast: Bool = false) {
        let c = configure ?? MWPopMenuConfigure.default
        labelTitle.text = model.title
        imageViewIcon.tintColor = c.itemConfigure.textDisabledColor
        imageViewIcon.image = model.icon?.withRenderingMode(model.isEnabled ? .alwaysOriginal : .alwaysTemplate) // 灰色
        viewBottomLine.isHidden = isLast
        
        labelTitle.textColor = model.isEnabled ? c.itemConfigure.textColor : c.itemConfigure.textDisabledColor
    }
    
}
