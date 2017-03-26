//
//  SeriesDTO.swift
//  Movie Finder
//
//  Created by Tarun Prajapati on 25/03/17.
//  Copyright © 2017 Tarun Prajapati. All rights reserved.
//

import Foundation


class SeriesDTO {
    var name : String
    var noOfSeasons: Int!
    var seasonsAndEpisodesMap : [Int: [EpisodeDTO]]
    
    init(){
        self.name = ""
        self.noOfSeasons = 0
        self.seasonsAndEpisodesMap = [:]
    }
    
    init(infoDictionary : [String: AnyObject]){
        self.name = infoDictionary[OMDb_RESPONSE_TITLE] as! String
        self.noOfSeasons = Int(infoDictionary[OMDb_RESPONSE_TOTALSEASONS] as? String ?? "") ?? 0
        self.seasonsAndEpisodesMap = [:]
    }
    
    func extractSeasonDetails(infoDictionary : [String: AnyObject]){
        let seasonNo = Int(infoDictionary[OMDb_RESPONSE_SEASON] as! String)!
        var episodes = [EpisodeDTO]()
        let episodesArray = infoDictionary[OMDb_RESPONSE_EPISODES] as! NSArray
        for index in 0..<episodesArray.count{
            let episode = EpisodeDTO(seriesName: self.name, seasonNo: seasonNo, episodeInfoDictionary: episodesArray[index] as! [String: AnyObject])
            episodes.append(episode)
        }
        self.seasonsAndEpisodesMap[seasonNo] = episodes
    }
    
}