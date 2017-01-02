//
//  BannerViewController.swift
//  Project 09 - Banner
//
//  Created by 一川 黄 on 21/12/2016.
//  Copyright © 2016 Jamie. All rights reserved.
//

import UIKit

class BannerViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var bannerDataArray:Array<String> = []
    var bannerCollectionDataArray:Array<String> = []
    var curIndex = -1
    var bannerTimer:Timer!
    
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var bannerCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bannerDataArray = ["image1.jpg","image2.jpg","image3.jpg","image4.jpg"]
        // Do any additional setup after loading the view.
        bannerCollectionDataArray = bannerDataArray
        
        let firstString = bannerDataArray.first
        let lastString = bannerDataArray.last
        
        bannerCollectionDataArray.insert(lastString!, at: 0)
        bannerCollectionDataArray.append(firstString!)
        
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        bannerCollectionView.isPagingEnabled = true

        bannerCollectionView.contentOffset = CGPoint(x: bannerCollectionView.bounds.width, y: 0)
        self.curIndex = 1
        
        bannerTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
        
        pageControl.frame = CGRect(x: 0, y: self.bannerCollectionView.bounds.height - 20, width: self.view.bounds.width, height: 37)
        pageControl.numberOfPages = bannerDataArray.count
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Collection View Data Source
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return bannerCollectionDataArray.count
    }
    
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerCell", for: indexPath) as! BannerCell
        cell.bannerImageView.image = UIImage(named: self.bannerCollectionDataArray[indexPath.row])
        return cell
    }
    
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    // MARK: - ScrollView Delegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let offsetX = self.bannerCollectionView.contentOffset.x
        curIndex = Int(offsetX / self.bannerCollectionView.bounds.width)
        if curIndex == 0
        {
            let indexPath = IndexPath(row: self.bannerCollectionDataArray.count-2, section: 0)
            self.bannerCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
            curIndex = self.bannerCollectionDataArray.count - 2
        }
        else if curIndex == self.bannerCollectionDataArray.count - 1
        {
            let indexPath = IndexPath(row: 1, section: 0)
            self.bannerCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
            curIndex = 1
        }
        self.pageControlShowCurrentPage(curIndex: curIndex)
        print(curIndex)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.bannerTimer.invalidate()
        self.bannerTimer = nil
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        bannerTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
    }
    
    // MARK: - Auto Scroll
    func autoScroll()
    {
        if curIndex == self.bannerCollectionDataArray.count - 1
        {
            let indexPath = IndexPath(row: 1, section: 0)
            self.bannerCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
            curIndex = 1
        }
        
        curIndex = curIndex + 1
        let indexPath = IndexPath(row: curIndex, section: 0)
        self.bannerCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        self.pageControlShowCurrentPage(curIndex: curIndex)
    }
    
    // MARK: - Page Control
    func pageControlShowCurrentPage(curIndex:Int)
    {
        if curIndex == 0
        {
            self.pageControl.currentPage = bannerCollectionDataArray.count - 3
        }
        else if curIndex == bannerCollectionDataArray.count - 1
        {
            self.pageControl.currentPage = 0
        }
        else
        {
            self.pageControl.currentPage = curIndex - 1
        }
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
