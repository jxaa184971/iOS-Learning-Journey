//
//  PositionViewController.swift
//  Project 04 - Simple Animation
//
//  Created by 一川 黄 on 15/07/2016.
//  Copyright © 2016 Jamie. All rights reserved.
//

import UIKit

class PositionViewController: UIViewController {

    @IBOutlet var blueSquare: UIView!
    @IBOutlet var redSquare: UIView!
    @IBOutlet var greenSquare: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.blueSquare.center.x = 50
        self.blueSquare.center.y = 100
        
        self.redSquare.center.x = self.view.bounds.width/2
        self.redSquare.center.y = 100
        
        self.greenSquare.center.x = self.view.bounds.width - 50
        self.greenSquare.center.y = 100
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        // animations: 后面跟的是一个block
        UIView.animate(withDuration: 1, animations: {
                // 蓝色方块的中心的x坐标 变为整个view的宽度减去蓝色方块的中心X的坐标(就是把蓝色方块移动到右边对称的位置)
                self.blueSquare.center.x = self.view.bounds.width - self.blueSquare.center.x
            })
        
        // options里面可以给动画加上特效, 这里选择没有特殊的动画效果
        UIView.animate(withDuration: 1, delay: 0.5, options: [], animations: {
            // 红色方块移动到下方
                self.redSquare.center.y = self.view.bounds.height - self.redSquare.center.y
            }, completion: nil)
        

        
        UIView.animate(withDuration: 1, delay: 1, options: [], animations: {
            // 绿色方块移动到对角
            self.greenSquare.center.x = self.view.bounds.width - self.greenSquare.center.x
            self.greenSquare.center.y = self.view.bounds.height - self.greenSquare.center.y
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
