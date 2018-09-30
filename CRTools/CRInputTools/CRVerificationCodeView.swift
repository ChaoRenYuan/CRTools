//
//  CRVerificationCodeView.swift
//  StoneBaseDemo
//
//  Created by 超人 on 2018/9/28.
//  Copyright © 2018 超人. All rights reserved.
//

import UIKit

protocol CRVerificationCodeViewDelegate {
    func verificationCodeDidFinished(_ verificationCodeView: CRVerificationCodeView, text:String)
}

/**
 * 验证码输入框
 * 需求：
 * 输入6个数字则resign -> 请求数据
 * 长按可粘贴（需判断是否为数字）-> isTrue -> 请求数据
 */
class CRVerificationCodeView: UIView {

    //MARK: ------------------------ Variables & Constants
    var delegate: CRVerificationCodeViewDelegate?
    var textFieldArr = [UITextField]()
    var textFieldOfMargin: CGFloat = 0.0
    let textFieldWidth: CGFloat = 50.0
    var textFieldOfNum: Int = 0
    var customFont = UIFont.boldSystemFont(ofSize: 15.0)
    var customColor = UIColor.gray
    
    //MARK: ------------------------ LifeCycle
    init(frame: CGRect, textFieldOfNum: Int, textFieldOfMargin: CGFloat) {
        super.init(frame: frame)
        self.textFieldOfMargin = textFieldOfMargin
        self.textFieldOfNum = textFieldOfNum
        
        createUI()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: ------------------------ Private
    private func createUI() {
        
        // 创建 n个 UITextFiedl
        let cr_kScreenW = UIScreen.main.bounds.width
        let num = CGFloat(textFieldOfNum)
        let leftMargin = ( cr_kScreenW - textFieldWidth * num - (num-1) * textFieldOfMargin ) / 2.0
        for i in 0..<textFieldOfNum {
            
            let rect = CGRect(x: leftMargin + CGFloat(i)*textFieldWidth + CGFloat(i)*textFieldOfMargin, y: 0, width: textFieldWidth, height: textFieldWidth)
            let tempView = createTextField(frame: rect)
            tempView.tag = i
            textFieldArr.append(tempView)
            
        }
        
        if textFieldOfNum < 1 {
            return
        }
        
        textFieldArr.first?.becomeFirstResponder()
        
    }
    private func createTextField(frame: CGRect) -> UITextField {
        let tempView = CRVerificationCodeTextField(frame: frame)
        tempView.borderStyle = .line
//        tempView.tintColor = .clear 取消光标
        tempView.textAlignment = .center
        tempView.font = customFont
        tempView.textColor = customColor
        tempView.keyboardType = .numberPad
        tempView.delegate = self
        tempView.customDelegate = self
        self.addSubview(tempView)
        return tempView
    }
    private func isNumInt(string: String) -> Bool {
        let scan: Scanner = Scanner(string: string)
        var val:Int = 0
        return scan.scanInt(&val) && scan.isAtEnd
    }
    
    
}

extension CRVerificationCodeView: UITextFieldDelegate, CRVerificationCodeTextFieldDelegate {
    /// CRVerificationCodeTextFieldDelegate
    func cr_deleteBackward() {
        for i in 1..<textFieldOfNum {
            if !textFieldArr[i].isFirstResponder {continue}
            textFieldArr[i].resignFirstResponder()
            textFieldArr[i-1].becomeFirstResponder()
            textFieldArr[i-1].text = ""
        }
    }
    
    func cr_paste() {
        let board = UIPasteboard.general
        guard let str = board.string else {return}
        
        if str.count == textFieldOfNum && (isNumInt(string: str)) {
            var result_str = ""
            for (index,i) in str.enumerated() {
                result_str += String(i)
                textFieldArr[index].text = String(i)
            }
            delegate?.verificationCodeDidFinished(self, text: result_str)
            self.resignFirstResponder()
        }
    }
    
    /// UITextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if !textField.hasText {
            
            let index = textField.tag
            textField.resignFirstResponder()
            if index == textFieldOfNum - 1 {
                textFieldArr[index].text = string
                
                // 拼接结果
                var result_str = ""
                textFieldArr.forEach { (textF) in
                    result_str += textF.text ?? ""
                }
                
                delegate?.verificationCodeDidFinished(self, text: result_str)
                return false
                
            }
            
            textFieldArr[index].text = string
            textFieldArr[index+1].becomeFirstResponder()
            
        }
        
        return false
    }

}

// MARK: - 具体的TextField
protocol CRVerificationCodeTextFieldDelegate {
    func cr_deleteBackward()
    func cr_paste()
}
class CRVerificationCodeTextField: UITextField {
    var customDelegate: CRVerificationCodeTextFieldDelegate?
    //MARK: ------------------------ Override
    override func deleteBackward() {
        super.deleteBackward()
        customDelegate?.cr_deleteBackward()
    }
    /// 按照逻辑这里只显示paste
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(paste(_:)) {
            return true
        }
        return super.canPerformAction(action, withSender: sender)
    }
    /// 粘贴功能
    override func paste(_ sender: Any?) {
        customDelegate?.cr_paste()
    }
}
