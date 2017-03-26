//
//  EpisodeSelectorVC.swift
//  Movie Finder
//
//  Created by Tarun Prajapati on 26/03/17.
//  Copyright © 2017 Tarun Prajapati. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class EpisodeSelectorVC: UIViewController, UITableViewDelegate, UITableViewDataSource, SearchMode_SeasonDelegate {
    
    private var series: SeriesDTO?
    private var episodesTabelView : UITableView!
    private var selectedSeason: Int = 1
    private var searchModel: SearchModel!
    
    
    func setSeries(series: SeriesDTO) {
        self.series = series
    }
    
    func setSeason(seasonNo: Int){
        self.selectedSeason = seasonNo
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startingPoint()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.title = "Episodes"
        
    }
    
    private func startingPoint(){
        // load tableView
        if self.episodesTabelView == nil{
            self.initializeTableView()
        }
        
        //Initailize Model and request data if data is not already present
        if self.searchModel == nil && self.series!.seasonsAndEpisodesMap[selectedSeason] == nil{
            self.showLoadingAnimation()
            self.searchModel = SearchModel()
            self.searchModel.season_delegate = self
            self.searchModel.findSeasonDetailsForSeries(series!, seasonNo: self.selectedSeason)
        }
        
    }
    
    
    private func initializeTableView(){
        self.episodesTabelView = UITableView(frame: CGRectMake(0, 0, self.view.frame.width, UIScreen.mainScreen().bounds.height - self.navigationController!.navigationBar.frame.height), style: .Grouped)
        self.episodesTabelView.backgroundColor = TABLE_VIEW_BG_COLOR
        self.episodesTabelView.separatorStyle = .SingleLine
        self.episodesTabelView.delegate = self
        self.episodesTabelView.dataSource = self
        self.view.addSubview(self.episodesTabelView)
    }
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (self.series?.name)! + " ➤ Season " + "\(self.selectedSeason)"
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.series?.seasonsAndEpisodesMap[selectedSeason]?.count  ?? 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 54
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") ?? UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        let episode = self.series!.seasonsAndEpisodesMap[self.selectedSeason]![indexPath.row]
        cell.textLabel?.text = "\(indexPath.row+1). " + episode.title
        cell.detailTextLabel?.text = "⭐ " + episode.rating //+ " ," + episode.releaseDate
        cell.accessoryType = .DisclosureIndicator
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.selected = false
        
        var pictureRequest = MotionPictureRequestDTO()
        pictureRequest.name = self.series?.name
        pictureRequest.type = .Series
        pictureRequest.seasonNo = self.selectedSeason
        pictureRequest.episodeNo = indexPath.row + 1
        self.navigationController?.pushViewController(MotionPictureDetailVC(motionPictureRequest: pictureRequest), animated: true)
    }
    
    
    
    //MARK:- SearchModel_SeasonDetail delegate methods
    func searchModel(model: SearchModel, didSeasonDetailSearch series: SeriesDTO, withError error: NSError?) {
        //Stop Loading Animation
        self.stopLoadingAnimation()
        
        guard error == nil && series.seasonsAndEpisodesMap[self.selectedSeason] != nil else{
            //No data found. Show failure.
            self.showTextOnFullscreenWhiteBg(SEASON_DETAILS_NOT_FOUND_ERROR)
            return
        }
        
        //Data found. Save Data.
        self.series = series
        
        //show data
        dispatch_async(dispatch_get_main_queue()) {
            self.episodesTabelView.reloadData()
        }
        
    }
    
        
    
}
