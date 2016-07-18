//
//  LogInViewController.swift
//  Project 05 - Log In Animation
//
//  Created by 一川 黄 on 18/07/2016.
//  Copyright © 2016 Jamie. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {

    @IBOutlet var bubble1: UIImageView!
    @IBOutlet var bubble2: UIImageView!
    @IBOutlet var bubble3: UIImageView!
    @IBOutlet var bubble4: UIImageView!
    @IBOutlet var bubble5: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var usernameInput: UITextField!
    @IBOutlet var passwordInput: UITextField!
    
    @IBOutlet var logInBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置气泡为看不见
        self.bubble1.transform = CGAffineTransformMakeScale(0, 0)
        self.bubble2.transform = CGAffineTransformMakeScale(0, 0)
        self.bubble3.transform = CGAffineTransformMakeScale(0, 0)
        self.bubble4.transform = CGAffineTransformMakeScale(0, 0)
        self.bubble5.transform = CGAffineTransformMakeScale(0, 0)
        
        self.drawBackgroundImage()
        self.drawTextfield()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        //隐藏标题
        self.titleLabel.center.x -= self.view.bounds.width
        
        //隐藏输入框
        self.usernameInput.center.x -= self.view.bounds.width
        self.passwordInput.center.x -= self.view.bounds.width
        
        //隐藏登录按钮
        self.logInBtn.center.x -= self.view.bounds.width
        
        self.animateBubble()
        self.animateTitle()
        self.animateTextfield()
        self.animateBtn()
    }
    
    // 设置背景图片
    func drawBackgroundImage()
    {
        let image = UIImage(named: "background")!
        //以下方法为将背景图片铺满屏幕
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.view.bounds.width, self.view.bounds.height), false, 0.0);
        image.drawInRect(CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.view.backgroundColor = UIColor(patternImage: newImage)
    }
    
    // 设置textfield
    func drawTextfield()
    {
        // 为textfield增加leftView 用于显示icon
        let imageView = UIImageView(image: UIImage(named: "social"))
        imageView.frame = CGRectMake(7.5, 7.5, 25, 25)
        let leftView = UIView(frame: CGRectMake(0, 0, 40, 40))
        leftView.addSubview(imageView)
        self.usernameInput.leftView = leftView
        self.usernameInput.leftViewMode = .Always
        
        // 密码的textfield也是同理
        let imageView2 = UIImageView(image: UIImage(named: "keyhole"))
        imageView2.frame = CGRectMake(7.5, 7.5, 25, 25)
        let leftView2 = UIView(frame: CGRectMake(0, 0, 40, 40))
        leftView2.addSubview(imageView2)
        self.passwordInput.leftView = leftView2
        self.passwordInput.leftViewMode = .Always
    
        
    }
    
    //气泡的动画效果
    func animateBubble()
    {
        UIView.animateWithDuration(0.5, delay: 0.3, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: .TransitionNone, animations: {
                self.bubble1.transform = CGAffineTransformMakeScale(1, 1)
                self.bubble4.transform = CGAffineTransformMakeScale(1, 1)
                self.bubble5.transform = CGAffineTransformMakeScale(1, 1)
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.4, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: .TransitionNone, animations: {
            self.bubble2.transform = CGAffineTransformMakeScale(1, 1)
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.5, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: .TransitionNone, animations: {
            self.bubble3.transform = CGAffineTransformMakeScale(1, 1)
            }, completion: nil)
    }
    
    //标题的动画效果
    func animateTitle()
    {
        self.titleLabel.center.y = self.view.bounds.height/2 - 180
        UIView.animateWithDuration(0.8, delay: 0.3, options: .CurveEaseOut, animations: {
                self.titleLabel.center.x = self.view.bounds.width/2
            }, completion: nil)
    }
    
    // 输入框的动画效果
    func animateTextfield()
    {
        UIView.animateWithDuration(0.8, delay: 0.4, options: .CurveEaseOut, animations: {
            self.usernameInput.center.x = self.view.bounds.width/2
            }, completion: nil)
        
        UIView.animateWithDuration(0.8, delay: 0.5, options: .CurveEaseOut, animations: {
            self.passwordInput.center.x = self.view.bounds.width/2
            }, completion: nil)
    }
    
    //按钮的动画效果
    func animateBtn()
    {
        UIView.animateWithDuration(0.8, delay: 0.6, options: .CurveEaseOut, animations: {
            self.logInBtn.center.x = self.view.bounds.width/2
            }, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
