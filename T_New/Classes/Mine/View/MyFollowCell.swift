//
//  MyFollowCell.swift
//  T_New
//
//  Created by C.z on 2020/5/8.
//  Copyright © 2020 C.z. All rights reserved.
//

import UIKit

class MyFollowCell: UITableViewCell, RegisterCellOrNib {

    
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var cellIconImageView: UIImageView!
    @IBOutlet weak var followColloectionView: UICollectionView!
    
    var myConcerns = [MyConcern](){
        didSet{
            followColloectionView.reloadData()
        }
    }
    
    var myCellModel: MyCellModel?{
        didSet{
            leftLabel.text = myCellModel?.text
            rightLabel.text = myCellModel?.grey_text
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        followColloectionView.collectionViewLayout = MyConFlowLayout()
        followColloectionView.delegate = self
        followColloectionView.dataSource = self
        followColloectionView.t_register(cell: MyConcernCell.self)
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

extension MyFollowCell: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(myConcerns.count)
        return myConcerns.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.t_dequeueReusableCell(indexPath: indexPath) as MyConcernCell
        cell.myConcernModel = myConcerns[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
    
}

class MyConFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        itemSize = CGSize(width: 70, height: 100)
        minimumLineSpacing = 4
        minimumInteritemSpacing = 4
        sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        scrollDirection = .horizontal
    }
}
