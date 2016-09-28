//
//  RotationViewController.swift
//  Project 04 - Simple Animation
//
//  Created by 一川 黄 on 15/07/2016.
//  Copyright © 2016 Jamie. All rights reserved.
//

import UIKit

class RotationViewController: UIViewController {

    @IBOutlet var greenSquare: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.greenSquare.center.x = self.view.bounds.width/2
        self.greenSquare.center.y = 150
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        spin()
    }
    
    func spin()
    {
        UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations:
            {
                self.greenSquare.transform = self.greenSquare.transform.rotated(by: CGFloat(M_PI))
            }, completion: {(completed) -> Void in
                self.spin()    //在comletion里面调用自己 就可以无限循环下去
        })
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
