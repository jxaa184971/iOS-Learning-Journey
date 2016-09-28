//
//  ViewController.swift
//  Project 02 - HTTP Request & JSON
//
//  Created by 一川 黄 on 28/06/2016.
//  Copyright © 2016 Jamie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var hostLabel: UILabel!
    @IBOutlet var languageLabel: UILabel!
    @IBOutlet var originLabel: UILabel!
    @IBOutlet var urlLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func requestBtnClicked(_ sender: AnyObject) {
        let array = self.sendRequest()
        
        if array != nil
        {
            self.hostLabel.text = "Host: \(array![0])"
            self.languageLabel.text = "Accept Language: \(array![1])"
            self.originLabel.text = "Origin: \(array![2])"
            self.urlLabel.text = "URL: \(array![3])"
        }
    }
    
    @IBAction func clearBtnClicked(_ sender: AnyObject) {
        
        self.hostLabel.text = "Host:"
        self.languageLabel.text = "Accept Language: "
        self.originLabel.text = "Origin: "
        self.urlLabel.text = "URL: "
    }
    
    func sendRequest() -> Array<String>?
    {
        let url = URL(string: "http://httpbin.org/get")
        let request: URLRequest = URLRequest(url: url!)
        let response: AutoreleasingUnsafeMutablePointer<URLResponse?>? = nil
        
        do
        {
            let data:Data = try NSURLConnection.sendSynchronousRequest(request, returning: response)
            let results = self.parseJSONToString(data)
            if results != nil
            {
                return results!
            }
        }
        catch
        {
            print("Error when sending request")
        }
        return nil
    }
    
    
    func parseJSONToString(_ data:Data) -> Array<String>?
    {
        var results = Array<String>()
        
        do {
            let entry = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
            
            let headers = entry.value(forKey: "headers") as! NSDictionary
            let host = headers.value(forKey: "Host") as! String
            let acceptLanguage = headers.value(forKey: "Accept-Language") as! String
            
            let origin = entry.value(forKey: "origin") as! String
            let url = entry.value(forKey: "url") as! String
            
            results.append(host)
            results.append(acceptLanguage)
            results.append(origin)
            results.append(url)
            
            return results
        }
        catch
        {
            print("error serializing JSON: \(error)")
            return nil
        }
    }
    
}

