//
//  FirstSegue.swift
//  Project 07 - Custom Segue
//
//  Created by 一川 黄 on 20/10/2016.
//  Copyright © 2016 Jamie. All rights reserved.
//

import UIKit

class FirstSegue: UIStoryboardSegue {

    /*
     此类继承于UIStoryboardSegue, 为实现自定义segue, 添加动画之类可以重写perform方法.
     父类有两个UIViewController对象, 分别为source, destination
     */
    override func perform() {
        // 得到source和destination视图控制器的视图对象
        let firstVCView = self.source.view as UIView!
        let secondVCView = self.destination.view as UIView!
        
        // 获得屏幕的宽和高
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        
        // 设置第二个视图的初始位置
        secondVCView?.frame = CGRect(x: 0.0, y: 0.0, width: screenWidth, height: screenHeight)
        
        // 将第二个视图添加到屏幕上
        let window = UIApplication.shared.keyWindow
        window?.insertSubview(secondVCView!, aboveSubview: firstVCView!)
        
        // 界面切换的动画
        UIView.transition(from: firstVCView!,
                          to: secondVCView!, duration: 0.6,
                          options: [.transitionCurlUp, .curveEaseOut],
                          completion: { (finished) -> Void in
                            // 动画执行完后调用source视图控制器的present方法, 显示destination视图
                            self.source.present(self.destination, animated: false, completion: nil)
        })
    }
    
}
