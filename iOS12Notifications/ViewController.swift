//
//  ViewController.swift
//  iOS12Notifications
//
//  Created by chaox on 2018/7/13.
//  Copyright © 2018年 FeiNiu. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /**summary的格式定制,有两种方式,
         
         1.设置categorySummaryFormat, 会显示summaryFormat, 使用带有categorySummaryFormat的init方法
         2.设置content的summaryArgument, 会显示来自****, 使用常规init方法
         
        let summaryFormat = "%u 条更多消息~~~"
         
        let debitOverdraftNotifCategory = UNNotificationCategory(identifier: "FNNotification",
                                                                 actions: [],
                                                                 intentIdentifiers: [],
                                                                 hiddenPreviewsBodyPlaceholder: nil,
                                                                 categorySummaryFormat: summaryFormat,
                                                                 options: [])
         */
        
        let debitOverdraftNotifCategory = UNNotificationCategory(identifier: "FNNotification",
                                                                 actions: [],
                                                                 intentIdentifiers: [],
                                                                 options: [])

        UNUserNotificationCenter.current().setNotificationCategories([debitOverdraftNotifCategory])
    }
    
    @IBAction func pushAction(_ sender: Any) {
        
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            
            guard settings.authorizationStatus == .authorized else { return }
            
            var names = ["法国", "法国","法国","克罗地亚","克罗地亚"]
            /**
             分组消息: 同一类型的通知会被合成一个通知组，用户可以通过点击通知组展开组里的所有通知
             
             通知分组使用两种分组方式：自动分组和线程标识.自动分组不需要做额外的操作，系统会根据App的bundle id对推送进行分组。如果需要对通知做更细致的分组就需要用线程标识, 也就是下面的threadIdentifier.
            */
            // 推送2组消息, 一组3条,一组2条
            for i in 0...4 {
                let content = UNMutableNotificationContent()
                content.title = "🍉 西瓜打折啦! 错过等三年!"
                content.body = "下拉这个对话框"
                content.categoryIdentifier = "FNNotification"
                content.sound = UNNotificationSound.default
                content.threadIdentifier = names[i]  //分组标识符 属于哪个分组
                content.summaryArgument  = names[i]
                
                /** 设置推送的图片
                 
                 远程通知需要在推送的payload中指定需要加载的图片资源地址, 也可以是网络地址, 需要下载到本地然后继续设置attachment
                 
                 */
                if let imageURL = Bundle.main.url(forResource: "image", withExtension: "jpeg"),
                  let attachment = try? UNNotificationAttachment(identifier: "imageAttachment", url: imageURL, options: nil)
                {
                    content.attachments = [attachment]
                }
                
                //创建发送触发
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                
                //创建发送请求
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                //将请求添加到发送中心
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            }
        }
    }
}

