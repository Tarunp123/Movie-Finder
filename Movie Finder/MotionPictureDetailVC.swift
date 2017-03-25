//
//  MotionPictureDetailVC.swift
//  Movie Finder
//
//  Created by Tarun Prajapati on 25/03/17.
//  Copyright © 2017 Tarun Prajapati. All rights reserved.
//

import UIKit

class MotionPictureDetailVC: UIViewController {

    private var motionPictureDetailView: MotionPictureDetailView!
    
    private var pictureDetails: MotionPictureDTO?{
        didSet{
            if self.pictureDetails != nil{
                self.startingPoint()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.startingPoint()
    }

    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.title = "Details"
    }
    

    private func startingPoint(){
        
        //View Setup
        if self.motionPictureDetailView == nil{
            self.motionPictureDetailView = MotionPictureDetailView(frame: self.view.frame)
        }
        self.view = self.motionPictureDetailView
        
        if let details = self.pictureDetails{
            self.motionPictureDetailView.setPosterImg(details.posterImgURL)
            self.motionPictureDetailView.setTitle(details.name)
            self.motionPictureDetailView.setRating(details.rating)
            self.motionPictureDetailView.setVotes(details.votes)
            self.motionPictureDetailView.setGenre(details.genre)
            self.motionPictureDetailView.setSummary(details.plot)
        }
        
    
    }
    

    func  setPictureDetails(details: MotionPictureDTO){
        self.pictureDetails = details
    }
    
    
}
