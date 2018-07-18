//
//  AppDelegate.swift
//  iOS12Notifications
//
//  Created by chaox on 2018/7/13.
//  Copyright © 2018年 FeiNiu. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        /**
           请求权限, ios12 options中新增了几个选项
         
           provisional: 临时授权, 通知会出现在通知中心并在应用图标上出现标记，但不会显示在锁定屏幕上，不会显示横幅，也不会播放声音,之后可以选择正常推送还是继续静默
        
           criticalAlert:重要提醒, 无视勿扰模式和铃声开关的限制，收到这类通知时会伴随一个系统或App设定的提示音 需要获得授权.
        */
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.requestAuthorization(options: [.badge,.alert,.sound]) { (tag, error) in
            if tag {
                print("允许")
            }else {
                print("被拒: \(error?.localizedDescription ?? "").")
            }
        }
        
        return true
    }
    
    // remote
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
       
    }

    func applicationWillResignActive(_ application: UIApplication) {
   
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
   
    }

    func applicationWillEnterForeground(_ application: UIApplication) {

    }

    func applicationDidBecomeActive(_ application: UIApplication) {

    }

    func applicationWillTerminate(_ application: UIApplication) {

    }
}

