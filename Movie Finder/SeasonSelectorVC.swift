//
//  SeasonSelectorVC.swift
//  Movie Finder
//
//  Created by Tarun Prajapati on 26/03/17.
//  Copyright © 2017 Tarun Prajapati. All rights reserved.
//

import UIKit

class SeasonSelectorVC: UIViewController, UITableViewDelegate, UITableViewDataSource, SearchModel_SeriesDelegate {

    private var series: SeriesDTO?
    private var seasonsTabelView : UITableView!
    private var searchModel: SearchModel!
    
    
    func setSeries(series: SeriesDTO) {
        self.series = series
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.startingPoint()
    }

    override func viewWillAppear(animated: Bool) {
        self.navigationItem.title = "Seasons"
        
    }
    
    private func startingPoint(){
    
        //Setup tableView
        if self.seasonsTabelView == nil{
            self.initializeTableView()
        }
        
        //Initailize Model and request data if data is not already present
        if self.searchModel == nil && self.series!.seasonsAndEpisodesMap.isEmpty{
            self.showLoadingAnimation()
            self.searchModel = SearchModel()
            self.searchModel.series_delegate = self
            var pictureRequest = MotionPictureRequestDTO()
            pictureRequest.name = self.series!.name
            pictureRequest.type = .Series
            self.searchModel.findMotionPicture(pictureRequest)
        }
        
    }
    
    
    private func initializeTableView(){
        self.seasonsTabelView = UITableView(frame: CGRectMake(0, 0, self.view.frame.width, UIScreen.mainScreen().bounds.height - self.navigationController!.navigationBar.frame.height), style: .Grouped)
        self.seasonsTabelView.backgroundColor = TABLE_VIEW_BG_COLOR
        self.seasonsTabelView.separatorStyle = .SingleLine
        self.seasonsTabelView.delegate = self
        self.seasonsTabelView.dataSource = self
        self.view.addSubview(self.seasonsTabelView)
    }
    
    
    //MARK:- TableView DataSource and Delegate Methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.series?.name
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.series?.noOfSeasons ?? 0
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") ?? UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        cell.textLabel?.text = "Season \(indexPath.row+1)"
        cell.accessoryType = .DisclosureIndicator
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.selected = false
        
        //Switch to episode selection VC
        let episodeSelectorVC = EpisodeSelectorVC()
        episodeSelectorVC.setSeries(self.series!)
        episodeSelectorVC.setSeason(indexPath.row+1)
        self.navigationController?.pushViewController(episodeSelectorVC, animated: true)
        
    }
    
    //MARK:- SearchModel_MotionPictureDelegate delegate methods

    func searchModel(model: SearchModel, didCompleteSeriesSearch series: SeriesDTO?, withError error: NSError?) {
        
        //Stop Loading Animation
        self.stopLoadingAnimation()
        
        guard error == nil && series != nil && series?.noOfSeasons > 0 else{
            //No data found. Show failure.
            self.showTextOnFullscreenWhiteBg(SEASON_DETAILS_NOT_FOUND_ERROR)
            return
        }
        
        //Data found. Save Data.
        self.series = series
        
        //show data
        dispatch_async(dispatch_get_main_queue()) {
            self.seasonsTabelView.reloadData()
        }
    
    }
    
        
    

    
    
}