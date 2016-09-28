//
//  RepeatViewController.swift
//  Project 04 - Simple Animation
//
//  Created by 一川 黄 on 16/07/2016.
//  Copyright © 2016 Jamie. All rights reserved.
//

import UIKit

class RepeatViewController: UIViewController {

    @IBOutlet var blueSquare: UIView!
    @IBOutlet var redSquare: UIView!
    @IBOutlet var greenSquare: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.blueSquare.center.x = 50
        self.blueSquare.center.y = 150
        self.redSquare.center.x = 50
        self.redSquare.center.y = 250
        self.greenSquare.center.x = 50
        self.greenSquare.center.y = 350
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        // 不重复动画
        UIView.animate(withDuration: 1, animations: {
            self.blueSquare.center.x = self.view.bounds.width - self.blueSquare.center.x
        })
        
        // 重复动画 .Repeat选项
        UIView.animate(withDuration: 1, delay: 0, options: .repeat, animations: {
                self.redSquare.center.x = self.view.bounds.width - self.redSquare.center.x
            }, completion: nil)
        
        // 自动反转动画 .AutoReverse选项 (为了动画效果这里与Repeat同时使用)
        UIView.animate(withDuration: 1, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.greenSquare.center.x = self.view.bounds.width - self.greenSquare.center.x
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
