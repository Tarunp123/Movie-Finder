//
//  MotionPictureSearchResultsModel.swift
//  Movie Finder
//
//  Created by Tarun Prajapati on 26/03/17.
//  Copyright © 2017 Tarun Prajapati. All rights reserved.
//

import Foundation

protocol MotionPictureSearchResultsModelDelegate: class {
    func motionPictureSearchResultsModel_didUpdateModel(model: MotionPictureSearchResultsModel)
}


class MotionPictureSearchResultsModel: SearchModel_SearchResultsDelegate {

    private var motionPictureRequest: MotionPictureRequestDTO!
    private var searchModel : SearchModel!
    private var searchResults = [MotionPictureSummaryDTO]()
    private var isDownlaodingData = false
    private var totalResults = 0
    private var currentPage = 0
    
    var delegate: MotionPictureSearchResultsModelDelegate?
    
    
    init(motionPictureRequest: MotionPictureRequestDTO){
        
        self.motionPictureRequest = motionPictureRequest
        
        self.searchModel = SearchModel()
        self.searchModel.searchResults_delegate = self
    }
    
    func setInitialResults(results: [MotionPictureSummaryDTO]) {
        self.searchResults = results
        self.currentPage = 1
    }
    
    func setTotalResultsCount(totalResults: Int)  {
        self.totalResults = totalResults
    }
    
    func fetchNextPage(){
        if !self.isDownlaodingData{
            self.isDownlaodingData = true
            self.searchModel.getMotionPictureSearchResults(self.motionPictureRequest, page: currentPage+1)
        }
    }
    
    
    
    //MARK:- SearchModel Delegate Method
    func searchModel(model: SearchModel, didCompleteMotionPictureSearchWithResults results: [MotionPictureSummaryDTO], totalResultsAvailable total: Int, forRequest request: MotionPictureRequestDTO, withError error: NSError?) {
        if error == nil{
            self.currentPage += 1
        }
        self.isDownlaodingData = false
        self.searchResults.appendContentsOf(results)
        self.delegate?.motionPictureSearchResultsModel_didUpdateModel(self)
    }
    
    
    //MARK: API Methods
    func getCurrentResultsCount() -> Int {
        return self.searchResults.count
    }
    
    func getTotalResultsCount() -> Int {
        return self.totalResults
    }
    
    func getMotionPictureSummaryAtIndex(index: Int) -> MotionPictureSummaryDTO? {
        //fetch new data if necessary
        if index >= self.searchResults.count - 4 && self.totalResults > self.searchResults.count{
            self.fetchNextPage()
        }
        //return data
        return (index < self.searchResults.count) ? self.searchResults[index] : nil
    }
    
    func  isDownloadingData() -> Bool {
        return self.isDownlaodingData
    }
}
