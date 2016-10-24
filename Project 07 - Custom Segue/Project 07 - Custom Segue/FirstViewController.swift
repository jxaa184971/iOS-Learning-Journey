//
//  FirstViewController.swift
//  Project 07 - Custom Segue
//
//  Created by 一川 黄 on 20/10/2016.
//  Copyright © 2016 Jamie. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 添加滑动手势识别器, 当用户向左滑动时调用showSecondViewController方法
        let swipeGestureRecognizer: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(FirstViewController.showSecondViewController))
        swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirection.up
        self.view.addGestureRecognizer(swipeGestureRecognizer)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showSecondViewController()
    {
        // 执行segue
        self.performSegue(withIdentifier: "firstSegue", sender: self)
    }
    
    /* 
     * Unwind Seuge需要你提供一个IBAction方法在你需要回跳的ViewController里
     * 参数sender必须是UIStoryboardSegue类型
     * 可以在storyboard里按住control拖拽ViewController到Exit连接到此IBAction
     */
    @IBAction func unwindFromViewController(sender: UIStoryboardSegue) {
        print("Return From Segue")
    }
    
    /*
     * 正向的自定义segue可以直接在storyboard里面设置, 而unwind segue则需要手动提供segue实例
     * 实现方法为重写 segueForUnwinding方法来执行自定义Unwind Segue
     */
    override func segueForUnwinding(to toViewController: UIViewController, from fromViewController: UIViewController, identifier: String?) -> UIStoryboardSegue {
        print("Segue For Unwinding")
        
        if identifier == "firstUnwindSegue"
        {
            print("Segue For Unwinding")
            let unwindSegue = FirstSegueUnwind(identifier: identifier,
                                               source: fromViewController,
                                               destination: toViewController,
                                               performHandler: { () -> Void in
                    
                })
            return unwindSegue
        }
    
        return super.segueForUnwinding(to: toViewController, from: fromViewController, identifier: identifier)!
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
