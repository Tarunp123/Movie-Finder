//
//  SearchVC.swift
//  Movie Finder
//
//  Created by Tarun Prajapati on 25/03/17.
//  Copyright © 2017 Tarun Prajapati. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class SearchVC: UIViewController, UITextFieldDelegate, SearchModelDelegate {

    private var searchView: SearchView!
    private var searchModel: SearchModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.startingPoint()
    }

    override func viewWillAppear(animated: Bool) {
        self.navigationItem.title = "Back"
        self.navigationController?.navigationBarHidden = true
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
    
    
    private func startingPoint(){
        
        //View Setup
        self.searchView = SearchView(frame: self.view.frame)
        self.view = self.searchView
        self.searchView.searchTF.delegate = self
        
        //Model Setup
        self.searchModel = SearchModel()
        self.searchModel.delegate = self
    }
    
    
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        self.searchView.stopLoadingAnimation()
        return true
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        //Dismiss Keyboard
        self.view.endEditing(true)
        
        //Check if user has entered anything in search box
        guard !textField.text!.isEmpty else{
            return true
        }
        
        //Start loading animation
        self.searchView.startLoadingAnimation()
        
        //Pack the data in request object
        var motionPictureRequestDTO = MotionPictureRequestDTO()
        motionPictureRequestDTO.name = textField.text!
        motionPictureRequestDTO.type = .Movie
        
        //Ask Model to search
        self.searchModel.findMotionPicture(motionPictureRequestDTO)
        
        return true
    }
    
    
    
    func searchModel(model: SearchModel, didFindMotionPicture motionPicture: MotionPictureDTO?) {
        //Stop Loading Animation
        self.searchView.stopLoadingAnimation()
        
        //Null Check
        guard motionPicture != nil else{
            //Give failure feedback to user
            self.searchView.failureAlert()
            return
        }
        
        //Show Detail View Controller
        dispatch_async(dispatch_get_main_queue()) { 
            let detailVC = MotionPictureDetailVC()
            detailVC.setPictureDetails(motionPicture!)
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    
    func searchModel(model: SearchModel, didEncounterError error: NSError?) {
        //Stop Loading Animation
        self.searchView.stopLoadingAnimation()
        
        //Give failure feedback to user
        self.searchView.failureAlert()
    }
    
    
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }


}
