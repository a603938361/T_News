//
//  HuoShanCell.swift
//  T_New
//
//  Created by C.z on 2020/6/4.
//  Copyright © 2020 C.z. All rights reserved.
//

import UIKit
import Kingfisher

class HuoShanCell: UITableViewCell {
    
    @IBOutlet weak var coverImg: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var bofangcishu: UILabel!
    @IBOutlet weak var bofangshichang: UILabel!
    @IBOutlet weak var avImage: UIImageView!
    @IBOutlet weak var acName: UILabel!
    @IBOutlet weak var acDesc: UILabel!
    @IBOutlet weak var avComm: UILabel!
    @IBOutlet weak var moreClick: UIButton!
    
    var resView: UIView?
    
    
    var huoShan: HuoShanModel?  {
        didSet{
            
//            coverImg.kf.setImage(with: URL(string: (huoShan?.large_image_list[0].url)!))
            
            //http://sf6-ttcdn-tos.pstatp.com/img/pgc-image/4233154926244c4c83c7beebecad77ac~120x256.image
            //https://lupic.cdn.bcebos.com/20191206/2000284266%2318.jpg
            
            coverImg.kf.setImage(with: URL(string: "https://lupic.cdn.bcebos.com/20191206/2000284266%2318.jpg"))
            title.text = huoShan?.abstract
            bofangcishu.text = huoShan?.composition_str
            bofangshichang.text = huoShan?.composition_str
            avImage.kf.setImage(with: URL(string: "http://sf6-ttcdn-tos.pstatp.com/img/pgc-image/4233154926244c4c83c7beebecad77ac~120x256.image"))
            acName.text = huoShan?.user_info.name
            acDesc.text = huoShan?.user_info.description
            avComm.text = huoShan?.comment_count_str
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        moreClick.addTarget(self, action: #selector(chooseMore), for: .touchUpInside)
        
        
        resView = UIView(frame: CGRect(x: screenW - 60, y: 230-80 - 40, width: 60, height: 80))
        resView?.backgroundColor = UIColor.red
        resView?.layer.cornerRadius = 4
        resView?.isHidden = true
        contentView.addSubview(resView!)
        
    }
    
    @objc func chooseMore() {
        print("chooseMore")
        resView?.isHidden = !resView!.isHidden
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
