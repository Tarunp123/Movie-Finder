//
//  MotionPictureDetailView.swift
//  Movie Finder
//
//  Created by Tarun Prajapati on 25/03/17.
//  Copyright © 2017 Tarun Prajapati. All rights reserved.
//

import UIKit
import SGImageCache

class MotionPictureDetailView: UIView {
    
    private var posterImgView: SGImageView!
    private var titleLabel: UILabel!
    private var ratingLabel: UILabel!
    private var votesLabel: UILabel!
    private var runTimeAndreleaseDateLabel: UILabel!
    private var genreLabel: UILabel!
    private var summaryHeaderLabel: UILabel!
    private var summaryLabel: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.startingPoint()
    }
    
    
    private func startingPoint(){
    
        //View Setup
        self.backgroundColor = PAPER_COLOR
        
        self.posterImgView = SGImageView(frame: CGRectMake(8*MF, 18*MF, 165*MF, 245*MF), image: nil, contentMode: .ScaleAspectFill, cornerRadius: 0, clipsToBounds: true)
        self.posterImgView.backgroundColor = PAPER_COLOR
        self.addSubview(self.posterImgView)
        
        
        self.titleLabel = UILabel(frame: CGRectMake(self.posterImgView.frame.maxX+8*MF, self.posterImgView.frame.minY, 224*MF, 58*MF), font: UIFont.boldSystemFontOfSize(24*MF), textColor: UIColor.blackColor(), alignment: .Left)
        self.titleLabel.numberOfLines = 2
        self.addSubview(self.titleLabel)
        
        
        let starImg = UIImageView(frame: CGRectMake(self.titleLabel.frame.minX, self.titleLabel.frame.maxY+12*MF, 32*MF, 32*MF), image: UIImage(named: STAR_ICON), contentMode: .ScaleAspectFit, cornerRadius: 0, clipsToBounds: false)
        self.addSubview(starImg)
        
        
        self.ratingLabel = UILabel(frame: CGRectMake(starImg.frame.maxX+8*MF, 0, 40*MF, 26*MF), font: UIFont.boldSystemFontOfSize(22*MF), textColor: DARK_GREY_COLOR, alignment: .Left)
        self.ratingLabel.center = CGPointMake(self.ratingLabel.center.x, starImg.center.y)
        self.addSubview(self.ratingLabel)
        
        
        self.votesLabel = UILabel(frame: CGRectMake(self.ratingLabel.frame.maxX+8*MF, self.titleLabel.frame.maxY+22*MF, 136*MF, 15*MF), font: UIFont.systemFontOfSize(13*MF, weight: UIFontWeightSemibold), textColor: MEDIUM_GREY_COLOR, alignment: .Left)
        self.addSubview(self.votesLabel)
        
        
        self.runTimeAndreleaseDateLabel = UILabel(frame: CGRectMake(self.titleLabel.frame.minX, starImg.frame.maxY+24*MF, 224*MF, 19*MF), font: UIFont.systemFontOfSize(16*MF, weight: UIFontWeightSemibold), textColor: LIGHT_GREY_COLOR, alignment: .Left)
        self.addSubview(self.runTimeAndreleaseDateLabel)
        
        
        self.genreLabel = UILabel(frame: CGRectMake(self.titleLabel.frame.minX, starImg.frame.maxY+16*MF, 224*MF, 42*MF), font: UIFont.systemFontOfSize(18*MF, weight: UIFontWeightSemibold), textColor: DARK_GREY_COLOR, alignment: .Left)
        self.genreLabel.numberOfLines = 2
        self.addSubview(self.genreLabel)
        
        
        self.summaryHeaderLabel = UILabel(frame: CGRectMake(8*MF, self.posterImgView.frame.maxY+18*MF, 398*MF, 24*MF), font: UIFont.systemFontOfSize(20*MF, weight: UIFontWeightSemibold), textColor: DARK_GREY_COLOR, alignment: .Left)
        self.summaryHeaderLabel.text = "Summary"
        self.addSubview(self.summaryHeaderLabel)
        
        
        self.summaryLabel = UILabel(frame: CGRectMake(8*MF, self.summaryHeaderLabel.frame.maxY+8*MF, 398*MF, 105*MF), font: UIFont.systemFontOfSize(18*MF, weight: UIFontWeightMedium), textColor: MEDIUM_GREY_COLOR, alignment: .Left)
        self.summaryLabel.numberOfLines = 0
        self.addSubview(self.summaryLabel)
        
    }
    
    
    func setPosterImg(imgURL: String){
        //Set poster image
        self.posterImgView.setImageForURL(imgURL)
    }
    
    
    func setTitle(title: String){
        self.titleLabel.text = title
    }
    
    
    func setRating(rating: String){
        self.ratingLabel.text = rating
    }
    

    func setVotes(votes: String){
        self.votesLabel.text = votes + " votes"
    }
    
    
    func setRuntimeAndReleaseDate(runTime:String, releaseDate: String){
        self.runTimeAndreleaseDateLabel.text = runTime + " | " + releaseDate
    }
    
    
    func setGenre(genre: String) {
        self.genreLabel.text = genre
    }
    
    
    func setSummary(summary: String) {
        self.summaryLabel.text = summary
        self.summaryLabel.sizeToFit()
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
