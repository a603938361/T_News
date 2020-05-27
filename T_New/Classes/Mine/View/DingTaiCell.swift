//
//  DingTaiCell.swift
//  T_New
//
//  Created by C.z on 2020/5/27.
//  Copyright © 2020 C.z. All rights reserved.
//

import UIKit
import IBAnimatable
import Kingfisher

class DingTaiCell: UITableViewCell, RegisterCellOrNib {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var coverImg: UIImageView!
    @IBOutlet weak var zhuanfaBtn: AnimatableButton!
    @IBOutlet weak var pinglunBtn: AnimatableButton!
    @IBOutlet weak var huozanBtn: AnimatableButton!
    
    var dongTaiData:UDongtai? {
        didSet{
            title.text = dongTaiData?.group.title
            var titleH: CGFloat{
                return Calculate.textHeight(text: title.text ?? "", fontSize: 15, width: screenW - 30)
            }
            coverImg.kf.setImage(with: URL(string: (dongTaiData?.group.image_url)!))
            pinglunBtn.setTitle(dongTaiData?.comment_count_str, for: .normal)
            zhuanfaBtn.setTitle(dongTaiData?.forward_num_str, for: .normal)
            huozanBtn.setTitle(dongTaiData?.read_count_str, for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
