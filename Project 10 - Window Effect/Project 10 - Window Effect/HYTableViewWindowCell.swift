//
//  HYTableViewWindowCell.swift
//  Project 10 - Window Effect
//
//  Created by Jamie on 2018/3/21.
//  Copyright © 2018年 Jamie. All rights reserved.
//

import UIKit

class HYTableViewWindowCell: UITableViewCell {

    lazy var picView: UIImageView! = {
        var picView = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 500))

        picView.image = UIImage(named: "longpic")
        picView.contentMode = UIViewContentMode.scaleToFill

        return picView
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        //set clipsToBounds to true, make sure the image only showed within the cell
        self.clipsToBounds = true
        self.addSubview(self.picView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func resetImagePosition(){
        // get the cell bounds in window
        let cellBoundsInWindow = self.convert(self.picView.bounds, to: self.window)

        if (cellBoundsInWindow.origin.y <= ((self.window?.bounds.height)!-self.picView.bounds.height)/2) {
            //when cell move to image top, the image should move with the cell.
            return
        }

        // get the middle center point Y of cell bounds in window
        let cellCenterY = cellBoundsInWindow.midY
        // get the middle center point Y of window
        let windowCenterY = self.window?.center.y;

        // the offset between cell center point Y and window center point Y
        let offsetY = cellCenterY - windowCenterY!;
        // every time user move the scroll view, reset the picview transform, make the picview position fix to screen center.
        let transform = CGAffineTransform(translationX: 0, y: -offsetY)
        self.picView.transform = transform;
    }

}
