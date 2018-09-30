//
//  CRCustomAlertTools.swift
//  StoneBaseDemo
//
//  Created by 超人 on 2018/9/28.
//  Copyright © 2018 超人. All rights reserved.
//

import UIKit

extension UIAlertController {
    /// 模仿系统addTextField的方法
    func addCustomView(height: CGFloat = 100, action: CRCustomAlertTools.Action?) {
        let customView = CRCustomAlertTools(action: action)
        set(vc: customView, height: height)
    }
    func set(vc: UIViewController?, width: CGFloat? = nil, height: CGFloat? = nil) {
        guard let vc = vc else { return }
        setValue(vc, forKey: "contentViewController")
        if let height = height {
            vc.preferredContentSize.height = height
            self.preferredContentSize.height = height
        }
    }
}

/**
 * 自定义封装的弹框控制器
 */
class CRCustomAlertTools: UIViewController {

    /**********************Constant&Variable**********************/
    typealias Action = (_ vc: UIViewController, _ customView: UIView) -> ()
    fileprivate var action: Action?
    
    /**********************LazyLoading**********************/
    private lazy var customView: UIView = {
        return $0
    }(UIView())
    
    /**********************Life Cycle**********************/
    init(action: Action?) {
        super.init(nibName: nil, bundle: nil)
        self.action = action
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.backgroundColor =  .orange
        action?(self, customView)
    }
    
    deinit {
        #if DEBUG
        let file = (#file as NSString).lastPathComponent;
        print("🤡\(file):(\(#line)) 销毁");
        #endif
    }
    
    override func loadView() {
        view = customView
    }

}

extension UIAlertController {
    /// present
    public func show(animated: Bool = true, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            UIApplication.shared.keyWindow?.rootViewController?.present(self, animated: animated, completion: completion)
        }
    }
    
    /// addAction
    func addAction(image: UIImage? = nil, title: String, color: UIColor? = nil, style: UIAlertActionStyle = .default, isEnabled: Bool = true, handler: ((UIAlertAction) -> Void)? = nil) {
        
        let action = UIAlertAction(title: title, style: style, handler: handler)
        action.isEnabled = isEnabled
        
        // button image
        if let image = image {
            action.setValue(image, forKey: "image")
        }
        
        // button title color
        if let color = color {
            action.setValue(color, forKey: "titleTextColor")
        }
        
        addAction(action)
    }
    
    /**
     * 定义一个默认的UIAlertController
     */
    convenience init(_ title: String? = nil, message: String? = nil, style: UIAlertControllerStyle = .alert, okActionTitle: String, okActionColor: UIColor? = nil, okHandler: ((UIAlertAction) -> Void)? = nil, cancleActionTitle: String? = nil, cancleActionColor: UIColor? = nil, cancleHandler: ((UIAlertAction) -> Void)? = nil, otherActionTitle: String? = nil, otherActionColor: UIColor? = nil, otherHandler: ((UIAlertAction) -> Void)? = nil) {
        
        self.init(title: title, message: message, preferredStyle: style)

        addAction(title: okActionTitle, color: okActionColor, style: .default, handler: okHandler)
        cancleActionTitle == nil ? () : addAction(title: cancleActionTitle ?? "", color: cancleActionColor, style: .cancel, handler: cancleHandler)
        otherActionTitle == nil ? () : addAction(title: otherActionTitle ?? "", color: otherActionColor, style: .default, handler: otherHandler)

    }
    
}

