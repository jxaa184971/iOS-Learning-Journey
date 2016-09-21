//
//  VideoBackgroundViewController.swift
//  Project 06 - VideoBackground
//
//  Created by 一川 黄 on 20/09/2016.
//  Copyright © 2016 Jamie. All rights reserved.
//

import UIKit
import AVKit

class VideoBackgroundViewController: UIViewController {

    //
    var videoPlayer: AVPlayerViewController = AVPlayerViewController()
    
    var videoSoundLevel:Float = 1.0
    
    var contentUrl: NSURL = NSURL()
    {
        didSet
        {
            self.setVideoPlayer(url: contentUrl)
        }
    }

    var videoFrame: CGRect = CGRect()
    
    var startTime: Float = 0.0
    
    var duration: Float = 0.0
    
    var backgroundColor: UIColor = UIColor.black
    
    var sound: Bool = true
    {
        didSet
        {
            if sound
            {
                self.videoSoundLevel = 1.0
            }
            else
            {
                self.videoSoundLevel = 0.0
            }
        }
    }
    
    var alpha: CGFloat = 0.8
    {
        didSet
        {
            self.videoPlayer.view.alpha = alpha
        }
    }
    
    var alwaysRepeat: Bool = true
    {
        didSet
        {
            //添加观察 如果视频播放完毕 调用重播方法
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setVideoPlayer(url: NSURL)
    {
        
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
