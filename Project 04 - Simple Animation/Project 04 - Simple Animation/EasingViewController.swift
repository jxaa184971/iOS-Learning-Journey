//
//  EasingViewController.swift
//  Project 04 - Simple Animation
//
//  Created by 一川 黄 on 16/07/2016.
//  Copyright © 2016 Jamie. All rights reserved.
//

import UIKit

class EasingViewController: UIViewController {

    @IBOutlet var blueSquare: UIView!
    @IBOutlet var redSquare: UIView!
    @IBOutlet var greenSquare: UIView!
    @IBOutlet var brownSquare: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.blueSquare.center.x = 50
        self.blueSquare.center.y = 150
        self.redSquare.center.x = 50
        self.redSquare.center.y = 250
        self.greenSquare.center.x = 50
        self.greenSquare.center.y = 350
        self.brownSquare.center.x = 50
        self.brownSquare.center.y = 450
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        // CurveLinear 整个动画过程保持匀速
        UIView.animateWithDuration(2, delay: 0, options: [.Repeat, .CurveLinear], animations: {
            self.blueSquare.center.x = self.view.bounds.width - self.blueSquare.center.x
            }, completion: nil)
        
        // CurveEaseIn 前面部分缓慢 后面匀速
        UIView.animateWithDuration(2, delay: 0, options: [.Repeat, .CurveEaseIn], animations: {
            self.redSquare.center.x = self.view.bounds.width - self.redSquare.center.x
            }, completion: nil)
        
        // CurveEaseOut 前面部分匀速 后面缓慢
        UIView.animateWithDuration(2, delay: 0, options: [.Repeat, .CurveEaseOut], animations: {
            self.greenSquare.center.x = self.view.bounds.width - self.greenSquare.center.x
            }, completion: nil)
        
        // CurveEaseInOut 前面后面缓慢 中间匀速
        UIView.animateWithDuration(2, delay: 0, options: [.Repeat, .CurveEaseInOut], animations: {
            self.brownSquare.center.x = self.view.bounds.width - self.brownSquare.center.x
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
