//
//  HYTableViewController.swift
//  Project 10 - Window Effect
//
//  Created by Jamie on 2018/3/21.
//  Copyright © 2018年 Jamie. All rights reserved.
//

import UIKit

class HYTableViewController: UITableViewController {

    var dataArray:Array<String> = []
    var windowCell:HYTableViewWindowCell?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataArray = ["Cell1","Cell2","Cell3","Cell4","Cell5","Cell6","Cell7","WindowCell","Cell8","Cell9","Cell10","Cell11","Cell12","Cell13","Cell14","Cell15","Cell16","Cell17","Cell18","Cell19","Cell20"];

        self.tableView.register(HYTableViewWindowCell.self, forCellReuseIdentifier: "windowCell")
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
        return self.dataArray.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.dataArray[indexPath.row] == "WindowCell" {
            return 200
        }else {
            return 100
        }
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (self.dataArray[indexPath.row] == "WindowCell") {
            let cell = tableView.dequeueReusableCell(withIdentifier: "windowCell", for: indexPath) as! HYTableViewWindowCell
            self.windowCell = cell
            cell.resetImagePosition()
            return cell
        }else{
            let cell = UITableViewCell()
            cell.textLabel?.text = self.dataArray[indexPath.row]
            return cell
        }
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.windowCell?.resetImagePosition()
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
