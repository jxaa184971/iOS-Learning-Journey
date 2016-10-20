//
//  FirstSegueUnwind.swift
//  Project 07 - Custom Segue
//
//  Created by 一川 黄 on 20/10/2016.
//  Copyright © 2016 Jamie. All rights reserved.
//

import UIKit

class FirstSegueUnwind: UIStoryboardSegue {

    override func perform() {
        print("Unwind Segue Called")
        
        // 得到source和destination视图控制器的视图对象
        let secondVCView = self.source.view as UIView!
        let firstVCView = self.destination.view as UIView!
        
        // 获得屏幕的宽和高
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height

        // 设置第一个视图的初始位置
        firstVCView?.frame = CGRect(x: 0.0, y: 0.0, width: screenWidth, height: screenHeight)
        
        // 将第一个视图添加到屏幕上
        let window = UIApplication.shared.keyWindow
        window?.insertSubview(firstVCView!, aboveSubview: secondVCView!)
        
        // 执行动画
        UIView.transition(from: secondVCView!, to: firstVCView!, duration: 0.6, options: [.transitionFlipFromLeft, .curveEaseOut]) { (finished) -> Void in
                self.source.dismiss(animated: false, completion: nil)
        }
    }
}
