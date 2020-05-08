//
//  MyConcernCell.swift
//  T_New
//
//  Created by C.z on 2020/5/8.
//  Copyright © 2020 C.z. All rights reserved.
//

import UIKit
import Kingfisher
class MyConcernCell: UICollectionViewCell, RegisterCellOrNib{

    @IBOutlet weak var avaImage: UIImageView!
    @IBOutlet weak var nameL: UILabel!
    @IBOutlet weak var tipsBtn: UIButton!
    @IBOutlet weak var vipImageV: UIImageView!
    
    
    var myConcernModel : MyConcern?{
        didSet{
            nameL.text = myConcernModel?.name
            avaImage.kf.setImage(with: URL(string: myConcernModel?.icon ?? ""))
            vipImageV.image = myConcernModel?.user_auth_info.auth_type == 1 ? UIImage(named: "all_v_avatar_star_16x16_") : UIImage(named: "all_v_avatar_18x18_")
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avaImage.layer.cornerRadius = 5
        avaImage.layer.masksToBounds = true
        // Initialization code
    }

}
