//
//  TableViewController.swift
//  Project 08 - Pull To Refresh
//
//  Created by 一川 黄 on 08/11/2016.
//  Copyright © 2016 Jamie. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var tableValues: Array<String> = Array<String>()
    var customRefreshControl: UIRefreshControl! //刷新控件
    var customRefreshControlView: RefreshControllCustomView! //刷新控件自定义视图, 用来代替原有的控件样式
    var imageOriginTransform: CGAffineTransform! //用来保存图片原有的transform, 在动画旋转里需要用到
    var isAnimating: Bool = false //用来判断刷新控件是否在动画
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableValues = ["Cell One", "Cell Two", "Cell Three", "Cell Four"]
        
        // 初始化刷新控件, 并将原有的背景颜色和控件颜色清除, 以起到隐藏的效果
        customRefreshControl = UIRefreshControl()
        customRefreshControl.backgroundColor = UIColor.clear
        customRefreshControl.tintColor = UIColor.clear
        self.view.addSubview(customRefreshControl)
        
        // 加载自定义控件的新样式
        loadCostomRefreshController()
        
        // 将图片原有的transform保存, 在旋转动画需要用到
        self.imageOriginTransform = self.customRefreshControlView.imgView.transform
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.tableValues.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! TableViewCell
        cell.titleLabel.text = tableValues[indexPath.row]
        return cell
    }
    

    func loadCostomRefreshController()
    {
        // 从Nib文件中得到我们需要的视图
        let refreshControlContents = Bundle.main.loadNibNamed("RefreshControlView", owner: self, options: nil)
        customRefreshControlView = refreshControlContents?[0] as! RefreshControllCustomView
        
        // 将新的视图的frame设为刷新空间的bounds
        customRefreshControlView.frame = customRefreshControl.bounds
        
        // 将新的视图设为不超过边界, 否则会挡住tableview
        customRefreshControlView.clipsToBounds = true
        
        // 将新的视图添加到刷新控件的子视图中
        customRefreshControl.addSubview(customRefreshControlView)
    }
    
    
    // 通过计算拉动的距离, 来计算出图片需要旋转的角度, 起到动画的效果.
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 检测y轴的位置, 用来测量拉动的距离
        let distance = -self.customRefreshControl.frame.origin.y

        // 当没有在执行刷新动画的时候调用以下方法, 根据拉动距离旋转图片
        if !self.isAnimating
        {
            if distance < 150.0
            {
                self.customRefreshControlView.imgView.transform = imageOriginTransform.rotated(by: distance / 75.0 * CGFloat(M_PI_2))
                self.customRefreshControlView.freshLabel.text = "下拉刷新"
            }
            else if distance >= 150.0
            {
                self.customRefreshControlView.imgView.transform = imageOriginTransform.rotated(by: 2 * CGFloat(M_PI_2))
                self.customRefreshControlView.freshLabel.text = "松开刷新"
            }
        }
    }
    
    // 在用户松开时, 判定条件, 并执行刷新动画
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if self.customRefreshControl.isRefreshing && !self.isAnimating
        {
            self.isAnimating = true
            self.customRefreshControlView.imgView.image = UIImage(named: "loading.png")
            self.customRefreshControlView.freshLabel.text = "刷新中..."
            
            UIView.animate(withDuration: 0.8, delay: 0.3, options: [.curveLinear], animations: {
                self.customRefreshControlView.imgView.transform = self.customRefreshControlView.imgView.transform.rotated(by: CGFloat(2 * M_PI_2))
            }, completion: {(completed) in
                self.refresh()
            })
        }
    }

    // 刷新, 并且将一些对象重新初始化, 以保证下一次刷新正确
    func refresh()
    {
        self.isAnimating = false
        self.customRefreshControl.endRefreshing()
        self.customRefreshControlView.imgView.image = UIImage(named: "arrow")
        
        self.tableValues = ["Cell One", "Cell Two", "Cell Three", "Cell Four", "Cell Five", "Cell Six"]
        self.tableView.reloadData()
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
