//
//  MotionPictureDetailVC.swift
//  Movie Finder
//
//  Created by Tarun Prajapati on 25/03/17.
//  Copyright © 2017 Tarun Prajapati. All rights reserved.
//


import UIKit

class MotionPictureDetailVC: UIViewController, SearchModel_MotionPictureDelegate, UINavigationControllerDelegate {

    private var motionPictureDetailView: MotionPictureDetailView!
    private var motionPictureRequest : MotionPictureRequestDTO?
    private var searchModel : SearchModel?
    
    
    
    
    init(motionPictureRequest: MotionPictureRequestDTO?) {
        super.init(nibName: nil, bundle: nil)
        self.motionPictureRequest = motionPictureRequest
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private var pictureDetails: MotionPictureDTO?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.delegate = self
        self.view.backgroundColor = PAPER_COLOR
    }

    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.title = "Details"
    }
    

    private func startingPoint(){
        
        
            //Check if motion picture data is available.
            //If available skip to view setup
            //else start downloading data
            guard self.pictureDetails != nil else{
                self.showLoadingAnimation()
                self.searchModel = SearchModel()
                self.searchModel?.motionPicture_delegate = self
                self.searchModel?.findMotionPicture(self.motionPictureRequest!)
                return
            }
        
        self.initializeViews()
            
    }
    
    

    private func initializeViews(){
        dispatch_async(dispatch_get_main_queue()) {
        //View Setup
        if self.motionPictureDetailView == nil{
            self.motionPictureDetailView = MotionPictureDetailView(frame: self.view.frame)
            self.view = self.motionPictureDetailView
        }
        
        if let details = self.pictureDetails{
            self.motionPictureDetailView.setPosterImg(details.posterImgURL)
            self.motionPictureDetailView.setTitle(details.name)
            self.motionPictureDetailView.setRating(details.rating)
            self.motionPictureDetailView.setVotes(details.votes)
            self.motionPictureDetailView.setRuntimeAndReleaseDate(details.runtime, releaseDate: details.releaseDate)
            self.motionPictureDetailView.setGenre(details.genre)
            self.motionPictureDetailView.setSummary(details.plot)
        }
        
        }
    }
    
    
    func setPictureDetails(details: MotionPictureDTO){
        self.pictureDetails = details
    }
    
    
    
    //MARK:- SearchModel delegate methods
    func searchModel(model: SearchModel, didCompleteMotionPictureSearch motionPicture: MotionPictureDTO?, withError error: NSError?) {
        //stop loading animation
        self.stopLoadingAnimation()
        
        //Handle failure
        guard error == nil && motionPicture != nil else{
            self.showTextOnFullscreenWhiteBg(ERROR_TRY_AGAIN_LATER)
            return
        }
        
        //Save the data and load view
        self.pictureDetails = motionPicture
        self.initializeViews()
    }
    
    
    //MARK:- NavigationController delegate methods
    func navigationController(navigationController: UINavigationController, didShowViewController viewController: UIViewController, animated: Bool) {
        self.startingPoint()
    }
    
}
