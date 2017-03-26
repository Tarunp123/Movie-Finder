//
//  MotionPictureSearchResultsVC.swift
//  Movie Finder
//
//  Created by Tarun Prajapati on 26/03/17.
//  Copyright © 2017 Tarun Prajapati. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class MotionPictureSearchResultsVC: UITableViewController, MotionPictureSearchResultsModelDelegate {

    private var searchResultsModel : MotionPictureSearchResultsModel!
    private var motionPictureRequest : MotionPictureRequestDTO!
    
    
    init(pictureRequest: MotionPictureRequestDTO){
        super.init(nibName: nil, bundle: nil)
        //Setup Model
        self.motionPictureRequest = pictureRequest
        self.searchResultsModel = MotionPictureSearchResultsModel(motionPictureRequest: self.motionPictureRequest)
        self.searchResultsModel.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dispatch_async(dispatch_get_main_queue()) { 
            self.startingPoint()
        }
    }

    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.title = "\(self.searchResultsModel.getTotalResultsCount()) Results"
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationItem.title = "Results"
    }
    
    func setPictureResults(results: [MotionPictureSummaryDTO], andTotalResults totalResults: Int) {
        self.searchResultsModel.setInitialResults(results)
        self.searchResultsModel.setTotalResultsCount(totalResults)
    }
    
    
    private func startingPoint(){
        //Setup View
        dispatch_async(dispatch_get_main_queue()) {
            self.tableView.backgroundColor = TABLE_VIEW_BG_COLOR
        }
    }
    

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == self.searchResultsModel.getCurrentResultsCount() && self.searchResultsModel.isDownloadingData(){
            return 75
        }
        return 150*MF
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.searchResultsModel.getCurrentResultsCount() == self.searchResultsModel.getTotalResultsCount(){
            return self.searchResultsModel.getCurrentResultsCount()
        }else{
            return self.searchResultsModel.getCurrentResultsCount() + 1
        }
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : MotionPictureSummaryTVC!
        cell = tableView.dequeueReusableCellWithIdentifier("cell") as? MotionPictureSummaryTVC ?? MotionPictureSummaryTVC(style: .Default, reuseIdentifier: "cell")
        print(indexPath.row)
        
        if indexPath.row == self.searchResultsModel.getCurrentResultsCount() && self.searchResultsModel.isDownloadingData(){
            let cell = UITableViewCell()
            let activityIndicator = NVActivityIndicatorView(frame: CGRectMake(0, 0, 30, 30), type: .BallPulseSync, color: UIColor.blackColor(), padding: 0)
            activityIndicator.center = cell.contentView.center
            cell.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            return cell
        }
        
        let pictureSummary = self.searchResultsModel.getMotionPictureSummaryAtIndex(indexPath.row)!
        cell.setPosterImg(pictureSummary.posterImgURL)
        cell.setTitle(pictureSummary.name)
        cell.setReleaseDate(pictureSummary.releaseDate)
        
        return cell
    }
    

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.selected = false
        
        let pictureSummary = self.searchResultsModel.getMotionPictureSummaryAtIndex(indexPath.row)
        
        var pictureRequest = MotionPictureRequestDTO()
        pictureRequest.name = pictureSummary?.name
        pictureRequest.type = pictureSummary?.type
        dispatch_async(dispatch_get_main_queue()) {
            if self.motionPictureRequest.type == .Movie{
                self.navigationController?.pushViewController(MotionPictureDetailVC(motionPictureRequest: pictureRequest), animated: true)
            }else if self.motionPictureRequest.type == .Series{
                let series = SeriesDTO()
                series.name = pictureSummary!.name
                
                let seasonSelector = SeasonSelectorVC()
                seasonSelector.setSeries(series)
                self.navigationController?.pushViewController(seasonSelector, animated: true)
            }
        }
    }
    
    
    //MARK:- MotionPictureSearchResultsModel delegate methods
    func motionPictureSearchResultsModel_didUpdateModel(model: MotionPictureSearchResultsModel) {
        dispatch_async(dispatch_get_main_queue()) {
            self.tableView.reloadData()
        }
    }
}
