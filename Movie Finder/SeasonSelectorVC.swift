//
//  SeasonSelectorVC.swift
//  Movie Finder
//
//  Created by Tarun Prajapati on 26/03/17.
//  Copyright © 2017 Tarun Prajapati. All rights reserved.
//

import UIKit

class SeasonSelectorVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var series: SeriesDTO?
    private var seasonsTabelView : UITableView!
    
    
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
    
    
    
}