//
//  SettingCell.swift
//  T_New
//
//  Created by C.z on 2020/5/25.
//  Copyright © 2020 C.z. All rights reserved.
//

import UIKit

class SettingCell: UITableViewCell, RegisterCellOrNib {
    
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var rightLabelView: UILabel!
    
    var settingModel : SettingModel? {
        didSet{
            titleLabel.text = settingModel?.title
            subTitleLabel.text = settingModel?.subTitle
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
