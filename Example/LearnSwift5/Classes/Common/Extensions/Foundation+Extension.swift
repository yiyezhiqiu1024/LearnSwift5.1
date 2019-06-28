//
//  Foundation+Extension.swift
//  Foundation相关类的拓展
//
//  Created by CoderSLZeng on 2018/3/28.
//  Copyright © 2018年 Amass. All rights reserved.
//

import UIKit

import AVFoundation
import Photos
import AssetsLibrary

extension NSObject {
    
    /// 跳转到APP系统设置权限界面
    static func jumpToSystemPrivacySetting()
    {
        let appSetting = URL(string:UIApplication.openSettingsURLString)
        
        if appSetting != nil
        {
            if #available(iOS 10, *) {
                UIApplication.shared.open(appSetting!, options: [:], completionHandler: nil)
            }
            else{
                UIApplication.shared.openURL(appSetting!)
            }
        }
    }
    
    
    /// 跳转到Safari浏览器
    static func jumpToSafariWithURLString(_ urlString: String)
    {
        let url = URL(string:urlString)
        
        if url != nil
        {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url!, options: [:], completionHandler: nil)
            }
            else{
                UIApplication.shared.openURL(url!)
            }
        }
    }
    
    // MARK: - About Permissions
    /// 获取相机权限
    static func authorizeCameraWith(comletion:@escaping (Bool)->Void )
    {
        let granted = AVCaptureDevice.authorizationStatus(for: AVMediaType.video);
        
        switch granted {
        case .authorized:
            comletion(true)
            break;
        case .denied:
            comletion(false)
            break;
        case .restricted:
            comletion(false)
            break;
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted:Bool) in
                DispatchQueue.main.async {
                    comletion(granted)
                }
            })
        @unknown default:
            break
        }
    }
    
    /// 获取相册权限
    static func authorizePhotoWith(comletion:@escaping (Bool)->Void )
    {
        let granted = PHPhotoLibrary.authorizationStatus()
        switch granted {
        case PHAuthorizationStatus.authorized:
            comletion(true)
        case PHAuthorizationStatus.denied,PHAuthorizationStatus.restricted:
            comletion(false)
        case PHAuthorizationStatus.notDetermined:
            PHPhotoLibrary.requestAuthorization({ (status) in
                DispatchQueue.main.async {
                    comletion(status == PHAuthorizationStatus.authorized ? true:false)
                }
            })
        @unknown default:
            break
        }
    }
    
}

extension String {
    /// 计算文本的高度
    func sl_textHeight(fontSize: CGFloat, width: CGFloat) -> CGFloat {
        return self.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [.font: UIFont.systemFont(ofSize: fontSize)], context: nil).size.height
    }
    
    /// 计算文本的宽度
    func sl_textWidth(text: String, fontSize: CGFloat, height: CGFloat) -> CGFloat
    {
        return text.boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: .usesLineFragmentOrigin, attributes: [.font: UIFont.systemFont(ofSize: fontSize)], context: nil).size.width
    }
    
    /// 计算富文本的高度
    func sl_attributedTextHeight(text: NSAttributedString, width: CGFloat) -> CGFloat
    {
        return text.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, context: nil).size.height + 5.0
    }
    
    /// 根据开始位置和长度截取字符串
    func sl_subString(start: Int, length: Int = -1) -> String
    {
        var len = length
        if len == -1 {
            len = self.count - start
        }
        let st = self.index(startIndex, offsetBy:start)
        let en = self.index(st, offsetBy:len)
        return String(self[st ..< en])
    }

    ///  获取指定开始下标位置和指定长度的字符串或字符
    ///
    /// - Parameters:
    ///   - start: 下标
    ///   - length: 长度
    subscript(start: Int, length: Int) -> String
    {
        get
        {
            let index1 = self.index(self.startIndex, offsetBy: start)
            let index2 = self.index(index1, offsetBy: length)
            return String(self[index1..<index2])
        }
        
        set
        {
            let tmp = self
            var s = ""
            var e = ""
            for (idx, item) in tmp.enumerated()
            {
                if(idx < start)
                {
                    s += "\(item)"
                }
                if(idx >= start + length)
                {
                    e += "\(item)"
                }
            }
            self = s + newValue + e
        }
    }
    
    /// 获取指定下标位置的字符串或字符
    ///
    /// - Parameter index: 下标位置
    subscript(index: Int) -> String
    {
        get
        {
            return String(self[self.index(self.startIndex, offsetBy: index)])
        }
        
        set
        {
            let tmp = self
            self = ""
            for (idx, item) in tmp.enumerated()
            {
                if idx == index
                {
                    self += "\(newValue)"
                }else
                {
                    self += "\(item)"
                }
            }
        }
    }
    
    /* Use Demo
         var str = "github.com"
         print(str[7,3])
         print(str[7])
     
         str[7,3] = "COM"
         str[0] = "G"
     
         print(str[0,10]) // Github.COM
    */
    /// 将字符串转为时间戳
    func sl_covertTimeStamp(_ dateFormat: String) -> TimeInterval? {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        guard let date = formatter.date(from: self) else { return nil }
        return date.timeIntervalSince1970 * 1000
    }
    
    ///  将字符串转为Date
    ///
    /// - Parameter dateFormat: 日期格式
    func sl_covertDate(_ dateFormat: String) -> Date? {
    
        let formatter = DateFormatter()
        
        formatter.dateFormat = dateFormat
        formatter.timeZone = TimeZone.current
        
        guard let date = formatter.date(from: self) else {
            return nil
        }
        
        return date
    }
}

extension TimeInterval {
    // 把秒数转换成时间的字符串
    func sl_convertString() -> String {
        // 把获取到的秒数转换成具体的时间
        let createDate = Date(timeIntervalSince1970: self)
        // 获取当前日历
        let calender = Calendar.current
        // 获取日期的年份
        let comps = calender.dateComponents([.year, .month, .day, .hour, .minute, .second], from: createDate, to: Date())
        // 日期格式
        let formatter = DateFormatter()
        // 判断当前日期是否为今年
        guard createDate.sl_isThisYear() else {
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            return formatter.string(from: createDate)
        }
        // 是否是前天
        if createDate.sl_isBeforeYesterday() {
            formatter.dateFormat = "前天 HH:mm"
            return formatter.string(from: createDate)
        } else if createDate.sl_isToday() || createDate.sl_isYesterday() {
            // 判断是否是今天或者昨天
            if comps.hour! >= 1 {
                return String(format: "%d小时前", comps.hour!)
            } else if comps.minute! >= 1 {
                return String(format: "%d分钟前", comps.minute!)
            } else {
                return "刚刚"
            }
        } else {
            formatter.dateFormat = "MM-dd HH:mm"
            return formatter.string(from: createDate)
        }
    }

    
    /// 将时间戳装换成字符串日期
    ///
    /// - Parameter dateFormat: 日期格式
    func sl_convertString(_ dateFormat : String) -> String {
        let date = Date(timeIntervalSince1970: self / 1000)
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter.string(from: date)
    }
}

extension Int {
    
//    static var timeFormat: String
//    {
//        let seconds = self % 60 // 计算：分
//        let minutes = self / 60 // 计算：秒
//        var timeText = minutes < 10 ? "0\(minutes):" : "\(minutes)"
//        timeText += seconds < 10 ? "0\(seconds)" : "\(seconds)"
//        return timeText
//    }
    
    /// 更新时间
    func sl_covertTimeFormat() -> String
    {
        let seconds = self % 60 // 计算：分
        let minutes = self / 60 // 计算：秒
        var timeText = minutes < 10 ? "0\(minutes):" : "\(minutes)"
        timeText += seconds < 10 ? "0\(seconds)" : "\(seconds)"
        
        return timeText
    }
    
    func sl_convertString() -> String {
        guard self >= 10000 else {
            return String(describing: self)
        }
        return String(format: "%.1f万", Float(self) / 10000.0)
    }
    
    /// 将秒数转成字符串
    func sl_convertVideoDuration() -> String {
        // 格式化时间
        if self == 0 { return "00:00" }
        let hour = self / 3600
        let minute = (self / 60) % 60
        let second = self % 60
        if hour > 0 { return String(format: "%02d:%02d:%02d", hour, minute, second) }
        return String(format: "%02d:%02d", minute, second)
    }
    
}

extension URL {
    func sl_getAudioTotalDuration() -> String
    {
        let audioAsset = AVURLAsset(url: self, options: nil)
        let audioDuration = audioAsset.duration
        let duration = Int(CMTimeGetSeconds(audioDuration))
        return duration.sl_covertTimeFormat()
    }
}

extension Date {
    
    /// 判断当前日期是否为今年
    func sl_isThisYear() -> Bool {
        // 获取当前日历
        let calender = Calendar.current
        // 获取日期的年份
        let yearComps = calender.component(.year, from: self)
        // 获取现在的年份
        let nowComps = calender.component(.year, from: Date())
        
        return yearComps == nowComps
    }
    
    /// 是否是昨天
    func sl_isYesterday() -> Bool {
        // 获取当前日历
        let calender = Calendar.current
        // 获取日期的年份
        let comps = calender.dateComponents([.year, .month, .day], from: self, to: Date())
        // 根据头条显示时间 ，我觉得可能有问题 如果comps.day == 0 显示相同，如果是 comps.day == 1 显示时间不同
        // 但是 comps.day == 1 才是昨天 comps.day == 2 是前天
//        return comps.year == 0 && comps.month == 0 && comps.day == 1
        return comps.year == 0 && comps.month == 0 && comps.day == 0
    }
    
    /// 是否是前天
    func sl_isBeforeYesterday() -> Bool {
        // 获取当前日历
        let calender = Calendar.current
        // 获取日期的年份
        let comps = calender.dateComponents([.year, .month, .day], from: self, to: Date())
        //
//        return comps.year == 0 && comps.month == 0 && comps.day == 2
        return comps.year == 0 && comps.month == 0 && comps.day == 1
    }
    
    /// 判断是否是今天
    func sl_isToday() -> Bool {
        // 日期格式化
        let formatter = DateFormatter()
        // 设置日期格式
        formatter.dateFormat = "yyyy-MM-dd"
        
        let dateStr = formatter.string(from: self)
        let nowStr = formatter.string(from: Date())
        return dateStr == nowStr
    }

    /// 是否是前天
    func sl_isTomorrow() -> Bool {
        // 获取当前日历
        let calender = Calendar.current
        // 获取日期的年份
        let comps = calender.dateComponents([.year, .month, .day], from: self, to: Date())
        return comps.year == 0 && comps.month == 0 && comps.day == -1
    }
    
    /// 获取当前的时间戳
    static var sl_currentTimeStamp : TimeInterval {
        return Date().timeIntervalSince1970 * 1000
    }
    
    /// 获取当前时区的时间
    static var sl_currentLocaleDate : Date {
        let now = Date()
        let zone = NSTimeZone.system
        let interval = zone.secondsFromGMT(for: now)
        let localeDate = now.addingTimeInterval(TimeInterval(interval))
        return localeDate
    }
    
    /// 转换成时间字符串
    func sl_covertString(_ dateFormat : String) -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat // "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = TimeZone.current
        return formatter.string(from: self)
    }
    
    /// 转换成时间戳
    func sl_covertTimeStamp(_ dateFormat: String) -> TimeInterval? {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat 
        formatter.timeZone = TimeZone.current
        let str = formatter.string(from: self)
        
        guard let date = formatter.date(from: str) else  {
            myLog("日期格式出错")
            return nil
        }
        return round(date.timeIntervalSince1970) * 1000
    }
    
    /// 转换成时间戳字符串
    func sl_covertTimeStampString(_ dateFormat: String) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.timeZone = TimeZone.current
        let str = formatter.string(from: self)
        
        guard let date = formatter.date(from: str) else  {
            myLog("日期格式出错")
            return nil
        }
        let timeStamp = lround(date.timeIntervalSince1970) * 1000
        return String(timeStamp)
    }
}

//扩展NSRange，添加转换成Range的方法
extension NSRange {
    func toRange(string: String) -> Range<String.Index> {
        let startIndex = string.index(string.startIndex, offsetBy: self.location)
        let endIndex = string.index(startIndex, offsetBy: self.length)
        return startIndex..<endIndex
    }
}

extension Bundle {
    public var namespace: String? {
        return infoDictionary?["CFBundleName"] as? String
    }
}

// MARK: - 自定义打印函数

///
/// - parameter message:    给外界提供的消息参数
/// - parameter fileName:   文件名
/// - parameter methodName: 函数名
/// - parameter lineNumber: 行号
func myLog<T>(_ message: T, fileName: String = #file, funcName: String = #function, lineNumber: Int = #line) {
    #if DEBUG
    print("\((fileName as NSString).lastPathComponent) [\(lineNumber)] \(funcName):\(message)")
    #endif
}

func myLogFunc(fileName: String = #file, funcName: String = #function, lineNumber: Int = #line) {
    #if DEBUG
    print("\((fileName as NSString).lastPathComponent) [\(lineNumber)] \(funcName):")
    #endif
}
