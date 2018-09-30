//
//  CRPasswordView.swift
//  StoneBaseDemo
//
//  Created by 超人 on 2018/9/28.
//  Copyright © 2018 超人. All rights reserved.
//

import UIKit

protocol CRPasswordViewDelegate {
    func cr_passwordView(textFinished: String)
    func cr_passwordView(textValueChanged: String, count: Int)
}

/**
 * 密码输入框
 */
class CRPasswordView: UIView {
    
    //MARK: ------------------------ Variables & Constants
    fileprivate var mainText = ""
    var maxCount: Int = 6
    var delegate: CRPasswordViewDelegate?

    //MARK: ------------------------ LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: ------------------------ Override
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        let width = rect.width / CGFloat(maxCount) //每一个小格子的宽度
        context.setStrokeColor(UIColor.gray.cgColor)
        context.setLineWidth(1)
        //外边框
        context.stroke(rect)
        let path = UIBezierPath()
        //画中间分隔的竖线
        (1..<maxCount).forEach { (index) in
            path.move(to: CGPoint(x: rect.origin.x + CGFloat(index) * width, y: rect.origin.y))
            path.addLine(to: CGPoint(x: rect.origin.x + CGFloat(index) * width, y: rect.origin.y + rect.height))
        }
        context.addPath(path.cgPath)
        context.strokePath()
        //画圓点
        let pointSize = CGSize(width: width * 0.3, height: width * 0.3)
        (0..<mainText.count).forEach { (index) in
            let origin = CGPoint(x: rect.origin.x + CGFloat(index) * width + (width - pointSize.width) / 2, y: rect.origin.y + (rect.height - pointSize.height) / 2)
            let pointRect = CGRect(origin: origin, size: pointSize)
            context.fillEllipse(in: pointRect)
        }
        
    }
    
    // MARK: - 以下操作是为了点击password激活键盘，仿造UITextFiled等
    //键盘的样式 (UITextInputTraits中的属性)
    var keyboardType: UIKeyboardType {
        get{
            return .numberPad
        }set{}
    }
    override var canBecomeFirstResponder: Bool {
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !isFirstResponder {
            becomeFirstResponder()
        }
    }
    
}

// MARK: - UIKeyInputProtocol
extension CRPasswordView: UIKeyInput {
    
    var hasText: Bool {
        return mainText.count > 0
    }
    
    func insertText(_ text: String) {
        if mainText.count < maxCount {
            mainText.append(text) // 不够就添加
            delegate?.cr_passwordView(textValueChanged: mainText, count: mainText.count)
            setNeedsDisplay() //TODO: -- 需要看看这个会不会产生什么问题
            if mainText.count == maxCount {
                resignFirstResponder()
                delegate?.cr_passwordView(textFinished: mainText)
            }
        }
    }
    
    func deleteBackward() {
        if mainText.count > 0 {
            mainText.remove(at: mainText.index(before: mainText.endIndex)) // swift4 删除最后一个字符
            delegate?.cr_passwordView(textValueChanged: mainText, count: mainText.count)
            setNeedsDisplay()
        }
    }
    
    
    
}
