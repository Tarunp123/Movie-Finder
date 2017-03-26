//
//  SearchModel.swift
//  Movie Finder
//
//  Created by Tarun Prajapati on 25/03/17.
//  Copyright © 2017 Tarun Prajapati. All rights reserved.
//

import Foundation

protocol SearchModel_MotionPictureDelegate: class {
    func searchModel(model: SearchModel, didFindMotionPicture motionPicture: MotionPictureDTO?)
    func searchModel(model: SearchModel, didEncounterError error: NSError?)
}

protocol SearchModel_SeriesDelegate: class {
    func searchModel(model: SearchModel, didFindSeriesDetails series: SeriesDTO?)
}

protocol SearchMode_SeasonDelegate:class {
    func searchModel(model: SearchModel, didFindSeasonDetailsForSeries series: SeriesDTO)
    func searchModel(model: SearchModel, didEncounterError error: NSError?)
}


class SearchModel: NSObject {

    private var httpRequestor : HTTPRequestor?
    
    var motionPicture_delegate: SearchModel_MotionPictureDelegate?
    var series_delegate : SearchModel_SeriesDelegate?
    var season_delegate : SearchMode_SeasonDelegate?
    
    
    func findMotionPicture(motionPicture: MotionPictureRequestDTO){
        
        let qualityOfServiceClass = QOS_CLASS_BACKGROUND
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        dispatch_async(backgroundQueue, {
            var urlString = ""
            if motionPicture.type == .Movie{
                urlString = OMDb_BASE_URL + OMDb_REQUEST_PARAM_TITLE + "=" + motionPicture.name.replaceWhiteSpaceWithPlus() + "&" + OMDb_REQUEST_PARAM_TYPE + "=" + motionPicture.type.rawValue
            }else if motionPicture.type == .Series{
                if let seasonNo = motionPicture.seasonNo, let episodeNo = motionPicture.episodeNo{
                    //If episode was searched
                    urlString = OMDb_BASE_URL + OMDb_REQUEST_PARAM_TITLE + "=" + motionPicture.name.replaceWhiteSpaceWithPlus() + "&" + OMDb_REQUEST_PARAM_TYPE + "=" + motionPicture.type.rawValue + "&" + OMDb_REQUEST_PARAM_SEASON + "=" + "\(seasonNo)" + "&" + OMDb_REQUEST_PARAM_EPISODE + "=" + "\(episodeNo)"
                }else{
                    //If series was searched
                    urlString = OMDb_BASE_URL + OMDb_REQUEST_PARAM_TITLE + "=" + motionPicture.name.replaceWhiteSpaceWithPlus() + "&" + OMDb_REQUEST_PARAM_TYPE + "=" + motionPicture.type.rawValue
                }
            }
            self.httpRequestor = HTTPRequestor(URLString: urlString)
            self.httpRequestor?.makeRequest({ (response, error) in
                
                //Error and NUll Check
                guard error == nil && response != nil else{
                    self.motionPicture_delegate?.searchModel(self, didEncounterError: error)
                    return
                }
                
                //Checking if response object actually contains any data
                if response![OMDb_RESPONSE_RESPONSE] as! String == "False"{
                    self.motionPicture_delegate?.searchModel(self, didEncounterError: error)
                    return
                }
                
                //Success! Inform the delegate
                if motionPicture.type == .Movie{    //If movie was searched
                    let motionPictureDTO = MotionPictureDTO(infoDictionary: response!)
                    self.motionPicture_delegate?.searchModel(self, didFindMotionPicture: motionPictureDTO)
                }else if motionPicture.type == .Series{
                    if motionPicture.seasonNo != nil{
                        //If Episode was searched.
                        let motionPictureDTO = MotionPictureDTO(infoDictionary: response!)
                        self.motionPicture_delegate?.searchModel(self, didFindMotionPicture: motionPictureDTO)
                    }else{
                        //If series was searched
                        let seriesDTO = SeriesDTO(infoDictionary: response!)
                        self.series_delegate?.searchModel(self, didFindSeriesDetails: seriesDTO)
                    }
                }
            })
            
        })
        
    }
    
    
    func findSeasonDetailsForSeries(series: SeriesDTO, seasonNo: Int){
        let qualityOfServiceClass = QOS_CLASS_BACKGROUND
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        dispatch_async(backgroundQueue, {
        
            let urlString = OMDb_BASE_URL + OMDb_REQUEST_PARAM_TITLE + "=" + series.name.replaceWhiteSpaceWithPlus() + "&" + OMDb_REQUEST_PARAM_SEASON + "=" + "\(seasonNo)"
            
            self.httpRequestor = HTTPRequestor(URLString: urlString)
            self.httpRequestor?.makeRequest({ (response, error) in
                
                //Error and NUll Check
                guard error == nil && response != nil else{
                    self.season_delegate?.searchModel(self, didEncounterError: error)
                    return
                }
                
                //Checking if response object actually contains any data
                if response![OMDb_RESPONSE_RESPONSE] as! String == "False"{
                    self.season_delegate?.searchModel(self, didEncounterError: error)
                    return
                }

                //Extract the data from response
                series.extractSeasonDetails(response!)
                
                //Inform the delegate
                self.season_delegate?.searchModel(self, didFindSeasonDetailsForSeries: series)
                
            })
        
        })
    }
    
    
    
}
