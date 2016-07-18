//
//  SpringViewController.swift
//  Project 04 - Simple Animation
//
//  Created by 一川 黄 on 16/07/2016.
//  Copyright © 2016 Jamie. All rights reserved.
//

import UIKit

class SpringViewController: UIViewController {

    @IBOutlet var blueSquare: UIView!
    @IBOutlet var greenSquare: UIView!
    @IBOutlet var redSquare: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.blueSquare.center.y = 150
        self.greenSquare.center.y = 150
        self.redSquare.center.y = 150
        
        self.blueSquare.center.x = 60
        self.greenSquare.center.x = self.view.bounds.width/2
        self.redSquare.center.x = self.view.bounds.width - 60
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        UIView.animateWithDuration(2, animations: {
            self.blueSquare.center.y = 400
        })
        
        // 使用Spring弹簧特效
        // damping: 阻尼, 0~1之间的float数值, 数值越大 弹的次数越少
        // initialSpringVelocity 初始的速度
        UIView.animateWithDuration(3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .TransitionNone, animations: {
            self.greenSquare.center.y = 400
            }, completion: nil)
        
        // 增加初始速度, 并减少阻尼
        UIView.animateWithDuration(3, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 3, options: .TransitionNone, animations: {
            self.redSquare.center.y = 400
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
