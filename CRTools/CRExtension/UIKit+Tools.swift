//
//  UIKit+Tools.swift
//  StoneBaseDemo
//
//  Created by 超人 on 2018/9/17.
//  Copyright © 2018年 超人. All rights reserved.
//

import UIKit

/// UILabel文字左边、顶部对齐
class VerticalLeftAndTopAlignLabel: UILabel {
    override func drawText(in rect:CGRect) {
        guard let labelText = text else {  return super.drawText(in: rect) }
        let attributedText = NSAttributedString(string: labelText, attributes: [NSAttributedStringKey.font: font])
        var newRect = rect
        newRect.size.height = attributedText.boundingRect(with: rect.size, options: .usesLineFragmentOrigin, context: nil).size.height
        if numberOfLines != 0 {
            newRect.size.height = min(newRect.size.height, CGFloat(numberOfLines) * font.lineHeight)
        }
        super.drawText(in: newRect)
    }
}

/// UITextView文字左边、顶部对齐
class VerticalLeftAndTopAlignTextView: UITextView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentInset = UIEdgeInsetsMake(-8, -3, 8, 3)
        layoutIfNeeded()
    }
}
