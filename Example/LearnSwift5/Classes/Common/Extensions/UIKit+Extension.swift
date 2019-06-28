//
//  UIKit+Extension.swift
//  UIKit相关类的拓展
//
//  Created by CoderSLZeng on 2018/3/6.
//  Copyright © 2018年 Amass. All rights reserved.
//


import UIKit
import CoreText

protocol StoryboardLoadable {}

extension StoryboardLoadable where Self: UIViewController {
    /// 提供 加载方法
    static func loadStoryboard() -> Self {
        return UIStoryboard(name: "\(self)", bundle: Bundle(for: self)).instantiateViewController(withIdentifier: "\(self)") as! Self
    }
}

protocol NibLoadable {}

extension NibLoadable where Self: UIView {
    static func loadViewFromNib() -> Self {
        
        return Bundle(for: self).loadNibNamed("\(self)", owner: nil, options: nil)?.last as! Self
    }
}

extension UIAlertController {
    
    /// 在指定视图控制器上弹出普通消息提示框
    ///
    /// - Parameters:
    ///   - message: 提示消息
    ///   - viewController: 弹出所在控制器
    static func sl_showAlert(message: String, in viewController: UIViewController) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .cancel))
        viewController.present(alert, animated: true)
    }
    
    /// 在根视图控制器上弹出普通消息提示框
    ///
    /// - Parameter message: 提示消息
    static func sl_showAlert(message: String) {
        if let vc = UIApplication.shared.keyWindow?.rootViewController {
            sl_showAlert(message: message, in: vc)
        }
    }
    
    /// 在指定视图控制器上弹出确认框
    ///
    /// - Parameters:
    ///   - message: 提示消息
    ///   - viewController: 弹出所在控制器
    ///   - confirm: 处理点击确认行为
    static func sl_showConfirm(title: String?, message: String, in viewController: UIViewController,
                            confirmHandler: ((UIAlertAction)->Void)?) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: confirmHandler))
        viewController.present(alert, animated: true)
    }
    
    
    /// 在指定视图控制器上弹出确认和取消(可选)框
    ///
    /// - Parameters:
    ///   - message: 提示消息
    ///   - confirmActionTitle: 确认行为标题
    ///   - cancelActionTitle: 取消行为标题
    ///   - viewController: 弹出所在控制器
    ///   - confirmHandler: 处理点击确认行为
    static func sl_showConfirm(title: String?, message: String,  confirmActionTitle: String, cancelActionTitle: String?, in viewController: UIViewController,
                            confirmHandler: ((UIAlertAction)->Void)?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
       
        alert.addAction(UIAlertAction(title: confirmActionTitle, style: .default, handler: confirmHandler))
        
        if let cancelTitle = cancelActionTitle
        {
            alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel))
        }
        
        viewController.present(alert, animated: true)
    }
    
    /// 在根视图控制器上弹出确认框
    ///
    /// - Parameters:
    ///   - message: 提示消息
    ///   - confirm: 处理点击确认行为
    static func sl_showConfirm(title: String?, message: String, confirm: ((UIAlertAction)->Void)?) {
        if let vc = UIApplication.shared.keyWindow?.rootViewController {
            sl_showConfirm(title: title, message: message, in: vc, confirmHandler: confirm)
        }
    }
    
    /*
     Use Demo
     //弹出普通消息提示框
     UIAlertController.showAlert(message: "保存成功!")
     
     //弹出确认选择提示框
     UIAlertController.showConfirm(message: "是否提交?") { (_) in
        print("点击了确认按钮!")
     }
    */
}

extension UILabel {
    
    /// 设置问答的内容
    func setSeparatedLinesFrom(_ attributedString: NSMutableAttributedString, hasImage: Bool) {
        // 通过 CoreText 创建字体
        let ctFont = CTFontCreateWithName(font.fontName as CFString, font.pointSize, nil)
        // 段落样式
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        // 为富文本添加属性
        attributedString.addAttributes([kCTFontAttributeName as NSAttributedString.Key: ctFont, NSAttributedString.Key.paragraphStyle: paragraphStyle], range: NSRange(location: 0, length: attributedString.length))
        // 通过 CoreText 创建 frameSetter
        let frameSetter = CTFramesetterCreateWithAttributedString(attributedString)
        // 创建路径
        let path = CGMutablePath()
        // 为路径添加一个 frame
        path.addRect(CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT)))
        // 通过 CoreText 创建 frame
        let frame = CTFramesetterCreateFrame(frameSetter, CFRange(location: 0, length: attributedString.length), path, nil)
        // 获取当前 frame 中的每一行的内容
        let lines: NSArray = CTFrameGetLines(frame)
        
        let attributedStrings = NSMutableAttributedString()
        // 遍历
        for (index, line) in lines.enumerated() {
            // 将 line 转成 CTLine
            // 获取每一行的范围
            let lineRange = CTLineGetStringRange(line as! CTLine)
            // 将 lineRange 转成 NSRange
            let range = NSRange(location: lineRange.location, length: lineRange.length)
            // 当前的内容
            let currentAttributedString = NSMutableAttributedString(attributedString: attributedString.attributedSubstring(from: range))
            if hasImage { // 如果有图片，就把第四行替换
                if index == 3 && currentAttributedString.length >= 18 {
                    replaceContent(currentAttributedString)
                }
            } else { // 如果没有图片，就把第六行替换
                if index == 5 && currentAttributedString.length >= 18 {
                    replaceContent(currentAttributedString)
                }
            }
            attributedStrings.append(currentAttributedString)
        }
        attributedText = attributedStrings
    }
    
    /// 替换内容
    private func replaceContent(_ currentAttributedString: NSMutableAttributedString) {
        currentAttributedString.replaceCharacters(in: NSRange(location: currentAttributedString.length - 8, length: 8), with: NSAttributedString(string: "...全文\n", attributes: [.foregroundColor: UIColor.blueFontColor]))
    }
    
}

extension UITextView {
    
    /// 设置 UITextView 富文本内容
    func setAttributedText(emoji: Emoji) {
        // 如果输入是空表情
        if emoji.isEmpty { return }
        // 如果输入是删除表情
        if emoji.isDelete { deleteBackward(); return }

        // 创建附件
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: emoji.png)
        // 当前字体的大小
        let currentFont = font!
        // 附件的大小
        attachment.bounds = CGRect(x: 0, y: -4, width: currentFont.lineHeight, height: currentFont.lineHeight)
        // 根据附件，创建富文本
        let attributedImageStr = NSAttributedString(attachment: attachment)
        // 获取当前的光标的位置
        let range = selectedRange
        // 设置富文本
        let mutableAttributedText = NSMutableAttributedString(attributedString: attributedText)
        mutableAttributedText.replaceCharacters(in: range, with: attributedImageStr)
        attributedText = mutableAttributedText
        // 将字体的大小重置
        font = currentFont
        // 光标 + 1
        selectedRange = NSRange(location: range.location + 1, length: 0)
    }
    
}

extension UIView {
    
    /// x
    var x: CGFloat {
        get { return frame.origin.x }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.x    = newValue
            frame                 = tempFrame
        }
    }
    
    /// y
    var y: CGFloat {
        get { return frame.origin.y }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.y    = newValue
            frame                 = tempFrame
        }
    }
    
    /// height
    var height: CGFloat {
        get { return frame.size.height }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.height = newValue
            frame                 = tempFrame
        }
    }
    
    /// width
    var width: CGFloat {
        get { return frame.size.width }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.width  = newValue
            frame = tempFrame
        }
    }
    
    /// size
    var size: CGSize {
        get { return frame.size }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size        = newValue
            frame                 = tempFrame
        }
    }
    
    /// centerX
    var centerX: CGFloat {
        get { return center.x }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.x            = newValue
            center                  = tempCenter
        }
    }
    
    /// centerY
    var centerY: CGFloat {
        get { return center.y }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.y            = newValue
            center                  = tempCenter;
        }
    }
    
    var currentViewController: UIViewController {
        // 1.通过响应者链关系，取得此视图的下一个响应者
        var next:UIResponder?
        next = self.next!
        repeat {
            //2.判断响应者对象是否是视图控制器类型
            if ((next as? UIViewController) != nil) {
                return (next as! UIViewController)
            }else {
                next = next?.next
            }
            
        } while next != nil
        
        return UIViewController()
    }
    
//    func currentViewController() -> UIViewController {
//        
//        // 1.通过响应者链关系，取得此视图的下一个响应者
//        var next:UIResponder?
//        next = self.next!
//        repeat {
//            //2.判断响应者对象是否是视图控制器类型
//            if ((next as? UIViewController) != nil) {
//                return (next as! UIViewController)
//            }else {
//                next = next?.next
//            }
//            
//        } while next != nil
//        
//        return UIViewController()
//    }
    
    
}

protocol RegisterCellFromNib {}

extension RegisterCellFromNib where Self: UIView {
    
    static var identifier: String { return "\(self)" }
    
    static var nib: UINib? { return UINib(nibName: "\(self)", bundle: Bundle(for: self)) }
}

extension UITableView {
    /// 注册 cell 的方法
    func sl_registerCell<T: UITableViewCell>(cell: T.Type) where T: RegisterCellFromNib {
        if let nib = T.nib { register(nib, forCellReuseIdentifier: T.identifier) }
        else { register(cell, forCellReuseIdentifier: T.identifier) }
    }
    
    /// 从缓存池池出队已经存在的 cell
    func sl_dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T where T: RegisterCellFromNib {
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }
}

extension UICollectionView {
    /// 注册 cell 的方法
    func sl_registerCell<T: UICollectionViewCell>(cell: T.Type) where T: RegisterCellFromNib {
        if let nib = T.nib { register(nib, forCellWithReuseIdentifier: T.identifier) }
        else { register(cell, forCellWithReuseIdentifier: T.identifier) }
    }
    
    /// 从缓存池池出队已经存在的 cell
    func sl_dequeueReusableCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T where T: RegisterCellFromNib {
        return dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
    }
    
    /// 注册头部
    func sl_registerSupplementaryHeaderView<T: UICollectionReusableView>(reusableView: T.Type) where T: RegisterCellFromNib {
        // T 遵守了 RegisterCellOrNib 协议，所以通过 T 就能取出 identifier 这个属性
        if let nib = T.nib {
            register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.identifier)
        } else {
            register(reusableView, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.identifier)
        }
    }
    
    /// 获取可重用的头部
    func sl_dequeueReusableSupplementaryHeaderView<T: UICollectionReusableView>(indexPath: IndexPath) -> T where T: RegisterCellFromNib {
        return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.identifier, for: indexPath) as! T
    }
}

extension UIImageView {
    /// 设置图片圆角
    func circleImage() {
        /// 建立上下文
        UIGraphicsBeginImageContextWithOptions(self.frame.size, false, 0)
        /// 获取当前上下文
        let ctx = UIGraphicsGetCurrentContext()
        /// 添加一个圆，并裁剪
        ctx?.addEllipse(in: self.bounds)
        ctx?.clip()
        /// 绘制图像
        self.draw(self.bounds)
        /// 获取绘制的图像
        let image = UIGraphicsGetImageFromCurrentImageContext()
        /// 关闭上下文
        UIGraphicsEndImageContext()
        DispatchQueue.global().async {
            self.image = image
        }
    }
    
}

extension UIBarButtonItem {
    
    convenience init(frame: CGRect?, imageName: String?, imageEdgeInsets: UIEdgeInsets?, target: AnyObject?, action: Selector)
    {
        let btn = UIButton()
        
        if let frame = frame {
            btn.frame = frame
        } else {
            btn.sizeToFit()
        }
        
        if let imageName = imageName {
            btn.setImage(UIImage(named: imageName), for: .normal)
            btn.setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
        }
        btn.addTarget(target, action: action, for: .touchUpInside)
        
        if let imageEdgeInsets = imageEdgeInsets {
            btn.imageEdgeInsets = imageEdgeInsets
        }
        
        self.init(customView: btn)
    }
    
    convenience init(title: String?, frame: CGRect?, imageName: String?, imageEdgeInsets: UIEdgeInsets?, target: AnyObject?, action: Selector)
    {
        let btn = UIButton()
        
        if let title = title {
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            btn.setTitle(title, for: .normal)
            
        }
        
        if let imageName = imageName {
            btn.setImage(UIImage(named: imageName), for: .normal)
            btn.setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
        }
        btn.addTarget(target, action: action, for: .touchUpInside)
        
        if let imageEdgeInsets = imageEdgeInsets {
            btn.imageEdgeInsets = imageEdgeInsets
        }
        
        if let frame = frame {
            btn.frame = frame
        } else {
            btn.sizeToFit()
        }
        
        self.init(customView: btn)
    }
}

extension UIButton
{
    // convenience : 便利,使用convenience修饰的构造函数叫做便利构造函数
    // 遍历构造函数通常用在对系统的类进行构造函数的扩充时使用
    /*
     遍历构造函数的特点
     1.遍历构造函数通常都是写在extension里面
     2.遍历构造函数init前面需要加载convenience
     3.在遍历构造函数中需要明确的调用self.init()
     */
    convenience init(imageName: String, backgroundImageName: String)
    {
        
        self.init()
        
        if imageName != "" {
            // 1.设置前景图片
            setImage(UIImage(named: imageName), for: UIControl.State())
            setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
        }
        
        if backgroundImageName != "" {
            // 2.设置背景图片
            setBackgroundImage(UIImage(named: backgroundImageName), for: UIControl.State())
            setBackgroundImage(UIImage(named: backgroundImageName + "_highlighted"), for: .highlighted)
        }
        
        
        // 3.调整按钮尺寸
        sizeToFit()
    }
    
    convenience init(bgColor : UIColor, fontSize : CGFloat, title : String) {
        self.init()
        
        setTitle(title, for: UIControl.State())
        backgroundColor = bgColor
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
    }
}

extension UIColor {
    
    @available(iOS 10.0, *)
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1.0) {
        self.init(displayP3Red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb : CGFloat ) {
        self.init(red: rgb / 255.0, green: rgb / 255.0, blue: rgb / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb : CGFloat, a : CGFloat) {
        self.init(red: rgb / 255.0, green: rgb / 255.0, blue: rgb / 255.0, alpha: a)
    }
    
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat, a : CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    
    static var randomColor : UIColor {
        return UIColor(rgb: CGFloat(arc4random_uniform(256)))
    }
    
    convenience init(hexString: String){
        // 处理数值
        var cString = hexString.uppercased().trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        // 错误处理
        if cString.count < 6 {
            // 返回透明色
            self.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
            return
        }
        
        if cString.hasPrefix("0X") || cString.hasPrefix("##") {
            cString = (cString as NSString).substring(from: 2)
        } else  if cString.hasPrefix("#"){
            cString = (cString as NSString).substring(from: 1)
        }
        
        if cString.count != 6 {
            // 返回透明色
            self.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
            return
        }
        
        //字符串截取
        var range = NSRange()
        range.location = 0
        range.length = 2
        
        let rString = (cString as NSString).substring(with: range)
        
        range.location = 2
        let gString = (cString as NSString).substring(with: range)
        
        range.location = 4
        let bString = (cString as NSString).substring(with: range)
        
        // 存储转换后的数值
        var r:UInt32 = 0,g:UInt32 = 0,b:UInt32 = 0
        // 进行转换
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        //根据颜色值创建UIColor
        self.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1.0)
    }
    
    /// 背景灰色 f8f9f7
    static var globalBackgroundColor : UIColor {
        return UIColor(r: 248, g: 249, b: 247)
    }
    
    /// 背景红色
    static var globalRedColor : UIColor {
        return UIColor(r: 196, g: 73, b: 67)
    }
    
    /// 字体蓝色
    static var blueFontColor : UIColor {
        return UIColor(r: 72, g: 100, b: 149)
    }
    
    /// 背景灰色 132
    static var grayColor132 : UIColor {
        return UIColor(rgb: 132)
    }
    
    /// 背景灰色 232
    static var grayColor232 : UIColor {
        return UIColor(rgb: 232)
    }
    
    
    /// 夜间字体背景灰色 113
    static var grayColor113 : UIColor {
        return UIColor(rgb: 113)
    }
    
    /// 夜间背景灰色 37
    static var grayColor37 : UIColor {
        return UIColor(rgb: 37)
    }

    /// 灰色 210
    static var grayColor210 : UIColor {
        return UIColor(rgb: 210)
    }
    
}

