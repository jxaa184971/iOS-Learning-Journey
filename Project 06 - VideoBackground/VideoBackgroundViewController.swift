//
//  VideoBackgroundViewController.swift
//  Project 06 - VideoBackground
//
//  Created by 一川 黄 on 20/09/2016.
//  Copyright © 2016 Jamie. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class VideoBackgroundViewController: UIViewController {

    // 视频播放视图控制器, 用来控制视频的播放
    var videoPlayer: AVPlayerViewController = AVPlayerViewController()
    // 视频声音大小, 用来开关声音
    var videoSoundLevel:Float = 1.0
    // 视频的URL
    open var contentUrl: URL!
    {
        didSet
        {
            self.setVideoPlayer(url: contentUrl!)
        }
    }
    // 视频在父视图的位置
    open var videoFrame: CGRect = CGRect()
    // 视频开始播放的时间点
    open var startTime: Float = 0.0
    // 视频长度
    open var duration: Float = 0.0
    // 声音开关
    open var sound: Bool = true
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
    // 视频的透明度
    open var alpha: CGFloat = 0.8
    {
        didSet
        {
            self.videoPlayer.view.alpha = alpha
        }
    }
    // 是否重复播放
    open var alwaysRepeat: Bool = true
    {
        didSet
        {
            if alwaysRepeat
            {
                // 添加观察 如果视频播放完毕 调用重播方法
                NotificationCenter.default.addObserver(self,
                    selector: #selector(VideoBackgroundViewController.videoPlayedToEnd),
                    name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                    object: self.videoPlayer.player?.currentItem)
            }
        }
    }
    
    
    
    @IBOutlet var logoView: UIImageView!
    @IBOutlet var logInBtn: UIButton!
    @IBOutlet var signUpBtn: UIButton!
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 添加视频进入项目时需要勾上add to target, 否则会找不到视频路径
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: "Bigbang", ofType: "mp4")!)
        
        self.videoFrame = self.view.frame
        self.alwaysRepeat = true
        self.sound = true
        self.startTime = 1.0
        self.alpha = 0.8
        self.contentUrl = url
        
        // 将视频画面铺满整个屏幕
        self.videoPlayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        // 将播放器的视图设置为不可交互
        self.videoPlayer.view.isUserInteractionEnabled = false
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.logInBtn.layer.cornerRadius = 4.0
        self.signUpBtn.layer.cornerRadius = 4.0
        
        // 将视频播放器的frame设置为frame属性的值
        self.videoPlayer.view.frame = videoFrame
        // 隐藏视频播放控制条
        self.videoPlayer.showsPlaybackControls = false
        // 将视频播放器的视图添加到当前view
        view.addSubview(self.videoPlayer.view)
        // 将视频播放器的视图放在最后, 不挡住其他控件
        view.sendSubview(toBack: self.videoPlayer.view)
    }

    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self) 
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setVideoPlayer(url: URL)
    {
        let player = AVPlayer(url: url)
        self.videoPlayer.player = player
        self.videoPlayer.player?.play()
        self.videoPlayer.player?.volume = self.videoSoundLevel
    }

    // 重播视频
    func videoPlayedToEnd()
    {
        self.videoPlayer.player?.seek(to: kCMTimeZero)
        self.videoPlayer.player?.play()
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
