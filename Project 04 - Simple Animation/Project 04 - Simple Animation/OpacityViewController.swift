//
//  OpacityViewController.swift
//  Project 04 - Simple Animation
//
//  Created by 一川 黄 on 15/07/2016.
//  Copyright © 2016 Jamie. All rights reserved.
//

import UIKit

class OpacityViewController: UIViewController {

    @IBOutlet var greenSquare: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.greenSquare.center.x = self.view.bounds.width/2
        self.greenSquare.center.y = 130
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        UIView.animate(withDuration: 2, animations: {
            self.greenSquare.alpha = 0.1
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
