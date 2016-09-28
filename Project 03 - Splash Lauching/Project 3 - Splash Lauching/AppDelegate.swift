//
//  AppDelegate.swift
//  Project 3 - Splash Lauching
//
//  Created by 一川 黄 on 1/07/2016.
//  Copyright © 2016 Jamie. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CAAnimationDelegate {

    var window: UIWindow?
    var mask: CALayer?
    var controller:TableViewController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let viewController = self.window?.rootViewController as! TableViewController
        self.controller = viewController
        
        //mask就是显示的部分, 在这里显示的部分最初与Twitter Logo相吻合.
        self.mask = CALayer()
        
        //可以给CALayer的contents属性赋任何值, 但是如果不是CGImage类时, 该CALayer将会是空白
        self.mask!.contents = UIImage(named: "twitter.png")?.cgImage
        
        //设置图片的拉伸方式
        self.mask!.contentsGravity = kCAGravityResizeAspect
        
        
        self.mask!.bounds = CGRect(x: 0, y: 0, width: 150, height: 100)
        self.mask!.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.mask!.position = CGPoint(x: viewController.view.frame.size.width / 2, y: viewController.view.frame.size.height / 2)
        viewController.view.layer.mask = mask
        
        animateMask()
        
        // 这里使用和launch界面背景相同的颜色, 否则默认为黑色
        self.window!.backgroundColor = UIColor(red: 40/255, green: 169/255, blue: 224/255, alpha: 1)
        self.window!.makeKeyAndVisible()
        return true
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


    func animateMask() {
        
        // keyPath用来标注CALayer动画更改的对象, 这里只需要更改其边界bounds
        let keyFrameAnimation = CAKeyframeAnimation(keyPath: "bounds")
        
        keyFrameAnimation.delegate = self
        keyFrameAnimation.duration = 1
        keyFrameAnimation.beginTime = CACurrentMediaTime() + 0.5
        
        // timing functions用来设置每两帧之间的动画效果. 例如有n个values, 就需要有n-1个timeFunctions
        keyFrameAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)]
 
        let initalBounds = NSValue(cgRect: mask!.bounds)
        let secondBounds = NSValue(cgRect: CGRect(x: 0, y: 0, width: 90, height: 90))
        let finalBounds = NSValue(cgRect: CGRect(x: 0, y: 0, width: 3200, height: 3200))
        
        keyFrameAnimation.values = [initalBounds, secondBounds, finalBounds]
        // keyTimes用来定义每一帧的时间点
        keyFrameAnimation.keyTimes = [0, 0.33, 1]
        
        // 添加动画并播放
        self.mask!.add(keyFrameAnimation, forKey: "bounds")
        
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        // 当动画结束时, 将该界面的mask设置为nil
        self.controller?.view.layer.mask = nil
    }
}

