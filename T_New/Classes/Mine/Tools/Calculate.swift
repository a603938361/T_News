//
//  Calculate.swift
//  News
//
//  Created by 杨蒙 on 2017/12/10.
//  Copyright © 2017年 hrscy. All rights reserved.
//

import UIKit

protocol Calculatable {
    // MARK: 计算富文本的高度
    static func attributedTextHeight(text: NSAttributedString, width: CGFloat) -> CGFloat
    // MARK: 计算文本的高度
    static func textHeight(text: String, fontSize: CGFloat, width: CGFloat) -> CGFloat
    // MARK: 计算文本的宽度
    static func textHieght(text: String, fontSize: CGFloat, height: CGFloat) -> CGFloat
    // MARK: 从文本内容中获取 uid 和 用户名
}

extension Calculatable {
    
    /// 计算富文本的高度
    static func attributedTextHeight(text: NSAttributedString, width: CGFloat) -> CGFloat {
        return text.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, context: nil).size.height + 5.0
    }
    
    /// 计算文本的高度
    static func textHeight(text: String, fontSize: CGFloat, width: CGFloat) -> CGFloat {
        return text.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [.font: UIFont.systemFont(ofSize: fontSize)], context: nil).size.height + 5
    }
    
    /// 计算文本的宽度
    static func textHieght(text: String, fontSize: CGFloat, height: CGFloat) -> CGFloat {
        return text.boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: .usesLineFragmentOrigin, attributes: [.font: UIFont.systemFont(ofSize: fontSize)], context: nil).size.height
    }
}


struct Calculate: Calculatable {}
