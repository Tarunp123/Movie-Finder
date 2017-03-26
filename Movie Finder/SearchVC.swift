//
//  SearchVC.swift
//  Movie Finder
//
//  Created by Tarun Prajapati on 25/03/17.
//  Copyright © 2017 Tarun Prajapati. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class SearchVC: UIViewController, UITextFieldDelegate, SearchModel_SeriesDelegate, SearchModel_SearchResultsDelegate {

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
        self.searchModel.series_delegate = self
        self.searchModel.searchResults_delegate = self
    }
    
    
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        self.searchView.stopLoadingAnimation()
        return true
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        //Dismiss Keyboard
        textField.resignFirstResponder()
        self.view.endEditing(true)
        
        //Check if user has entered anything in search box
        guard !textField.text!.isEmpty else{
            return true
        }
        
        var motionPictureRequestDTO = MotionPictureRequestDTO()
        motionPictureRequestDTO.name = textField.text!
        
        //Ask search type from user
        let searchTypeAlertController = UIAlertController(title: WHAT_ARE_YOU_LOOKING_FOR, message: nil, preferredStyle: .ActionSheet)
        let moviesAction = UIAlertAction(title: MotionPictureType.Movie.rawValue, style: .Default) { (movieAction) in
            //Pack the data in request object
            motionPictureRequestDTO.type = .Movie
            self.performSearchForMotionPicture(motionPictureRequestDTO)
        }
        
        let seriesAction = UIAlertAction(title: MotionPictureType.Series.rawValue, style: .Default) { (seriesAction) in
            //Pack the data in request object
            motionPictureRequestDTO.type = .Series
            self.performSearchForMotionPicture(motionPictureRequestDTO)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (cancelAction) in
            return
        }
        
        searchTypeAlertController.addAction(moviesAction)
        searchTypeAlertController.addAction(seriesAction)
        searchTypeAlertController.addAction(cancelAction)
        self.presentViewController(searchTypeAlertController, animated: true, completion: nil)
        
        return true
    }
    
    
    private func performSearchForMotionPicture(motionPictureRequest: MotionPictureRequestDTO){
        
        //Start loading animation
        self.searchView.startLoadingAnimation()
        
        //Ask Model to search
        self.searchModel.getMotionPictureSearchResults(motionPictureRequest, page: 1)
    }
    
    
    
    //MARK:-SearchModel_Series delegate methods
    func searchModel(model: SearchModel, didCompleteSeriesSearch series: SeriesDTO?, withError error: NSError?) {
        //Stop Loading Animation
        self.searchView.stopLoadingAnimation()
        
        //Null Check
        guard error == nil && series != nil && series?.noOfSeasons > 0 else{
            //Give failure feedback to user
            self.searchView.failureAlert()
            return
        }
        
        //Show Detail View Controller
        dispatch_async(dispatch_get_main_queue()) {
            let seasonSelector = SeasonSelectorVC()
            seasonSelector.setSeries(series!)
            self.navigationController?.pushViewController(seasonSelector, animated: true)
        }

    }
    
    
    //MARK:- SearchModel_SearchResults delegate methods
    func searchModel(model: SearchModel, didCompleteMotionPictureSearchWithResults results: [MotionPictureSummaryDTO], totalResultsAvailable total: Int, forRequest request: MotionPictureRequestDTO, withError error: NSError?) {
        
        //Stop Loading Animation
        self.searchView.stopLoadingAnimation()
        
        guard error == nil && results.count > 0 else{
            //Give failure feedback to user
            self.searchView.failureAlert()
            return
        }
        
        dispatch_async(dispatch_get_main_queue()) {
            let pictureSearchResultsVC = MotionPictureSearchResultsVC(pictureRequest: request)
            pictureSearchResultsVC.setPictureResults(results, andTotalResults: total)
            self.navigationController?.pushViewController(pictureSearchResultsVC, animated: true)
        }
    }
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }


}
