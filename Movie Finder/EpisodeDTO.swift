//
//  EpisodeDTO.swift
//  Movie Finder
//
//  Created by Tarun Prajapati on 25/03/17.
//  Copyright © 2017 Tarun Prajapati. All rights reserved.
//

import Foundation


struct EpisodeDTO {
    var seriesName : String!
    var seasonNo: Int!
    var episodeNo: Int!
    var title: String!
    var releaseDate: String!
    var rating: String!
    
    
    init(seriesName: String, seasonNo: Int, episodeInfoDictionary: [String: AnyObject]){
        self.seriesName = seriesName
        self.seasonNo = seasonNo
        self.title = episodeInfoDictionary[OMDb_RESPONSE_TITLE] as! String
        self.episodeNo = Int(episodeInfoDictionary[OMDb_RESPONSE_EPISODE] as! String)!
        self.releaseDate = episodeInfoDictionary[OMDb_RESPONSE_RELEASED] as? String ?? NA
        self.rating = episodeInfoDictionary[OMDb_RESPONSE_IMDBRATING] as? String ?? NA
    }
    
}