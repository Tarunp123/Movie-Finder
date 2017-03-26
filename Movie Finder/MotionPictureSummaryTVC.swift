//
//  MotionPictureSummaryTVC.swift
//  Movie Finder
//
//  Created by Tarun Prajapati on 26/03/17.
//  Copyright © 2017 Tarun Prajapati. All rights reserved.
//

import UIKit
import SGImageCache

class MotionPictureSummaryTVC: UITableViewCell {

    private var posterImgView : SGImageView!
    private var titleLabel : UILabel!
    private var releaseDateLabel: UILabel!
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        dispatch_async(dispatch_get_main_queue()) {
        self.startingPoint()
        }
    }
    

    
    private func startingPoint(){
        

        //View Setup
        self.backgroundColor = UIColor.whiteColor()
    
        self.posterImgView = SGImageView(frame: CGRectMake(8*MF, 8*MF, 90*MF, 134*MF), image: nil, contentMode: .ScaleAspectFill, cornerRadius: 0, clipsToBounds: true)
        self.posterImgView.backgroundColor = LIGHT_GREY_COLOR
        self.addSubview(self.posterImgView)
        
        self.titleLabel = UILabel(frame: CGRectMake(self.posterImgView.frame.maxX+8*MF, self.posterImgView.frame.minY, 300*MF, 58*MF), font: UIFont.boldSystemFontOfSize(24*MF), textColor: UIColor.blackColor(), alignment: .Left)
        self.titleLabel.numberOfLines = 2
        self.addSubview(self.titleLabel)
        
        self.releaseDateLabel = UILabel(frame: CGRectMake(self.titleLabel.frame.minX, self.titleLabel.frame.maxY+5*MF, 300*MF, 21*MF), font: UIFont.systemFontOfSize(18*MF, weight: UIFontWeightSemibold), textColor: DARK_GREY_COLOR, alignment: .Left)
        self.addSubview(self.releaseDateLabel)
     
    }
    

    
    func setPosterImg(imgURL: String){
        //Set poster image
        
        dispatch_async(dispatch_get_main_queue()) {
            self.posterImgView.setImageForURL(imgURL.getHTTPSUrlString())
        }
        
        
    }

    
    func setTitle(title: String){
        dispatch_async(dispatch_get_main_queue()) { 
            self.titleLabel.text = title
            //self.titleLabel.sizeToFit()
            self.releaseDateLabel.center = CGPointMake(self.releaseDateLabel.center.x, self.titleLabel.frame.maxY+16*MF)
        }
    }
    
    func setReleaseDate(releaseDate: String){
        dispatch_async(dispatch_get_main_queue()) {
            self.releaseDateLabel.text = releaseDate
        }
    }
    
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
