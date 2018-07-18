//
//  NotificationViewController.swift
//  Notification Extension
//
//  Created by chaox on 2018/7/13.
//  Copyright © 2018年 FeiNiu. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

/**
 
  可以交互的推送内容扩展, 通过File-New-Target中的 Notification Content Extension 来创建
 */

class NotificationViewController: UIViewController, UNNotificationContentExtension {
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var waterMelonLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func didReceive(_ notification: UNNotification) {
        
        // 取出图片 处理UI
        guard let attachment = notification.request.content.attachments.first else {
            return
        }
        
        if attachment.url.startAccessingSecurityScopedResource(),
            let data = try? Data(contentsOf: attachment.url) {
            imageView.contentMode = .scaleAspectFit
            imageView.image = UIImage(data: data)
            
            if let image = imageView.image {
                let scaledRatio = view.bounds.width / image.size.width
                preferredContentSize = CGSize(width: scaledRatio * image.size.width,
                                              height: scaledRatio * image.size.height)
            }
            
            attachment.url.stopAccessingSecurityScopedResource()
        }
    }

    @IBAction func coverButtonTapped(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
        self.button.setTitle("继续下拉", for: UIControl.State.normal)
      
        UIView.animate(withDuration: 0.5) {
            self.imageView.alpha = 0
            self.waterMelonLabel.alpha = 1
        }
        
        UIView.animate(withDuration: 1 , delay: 0.6 , usingSpringWithDamping: 0.5 , initialSpringVelocity: 8 , options: [] , animations: {
            self.waterMelonLabel.center.y = self.view.center.y;
        }, completion: nil)
        
    }
}
