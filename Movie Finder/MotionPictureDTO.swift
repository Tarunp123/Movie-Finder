//
//  MotionPictureDTO.swift
//  Movie Finder
//
//  Created by Tarun Prajapati on 24/03/17.
//  Copyright © 2017 Tarun Prajapati. All rights reserved.
//

import Foundation

struct MotionPictureDTO {

    var name: String
    var genre: String
    var releaseDate: String
    var plot: String
    var rating: String
    var votes: String
    var posterImgURL: String
    var runtime : String
    var type: MotionPictureType?
    
    
    init(infoDictionary: [String: AnyObject]){
        self.name = infoDictionary[OMDb_RESPONSE_TITLE] as! String
        self.genre = infoDictionary[OMDb_RESPONSE_GENRE] as? String ?? NA
        self.releaseDate = infoDictionary[OMDb_RESPONSE_RELEASED] as? String ?? NA
        self.plot = infoDictionary[OMDb_RESPONSE_PLOT] as? String ?? NA
        self.rating = infoDictionary[OMDb_RESPONSE_IMDBRATING] as? String ?? NA
        self.votes = infoDictionary[OMDb_RESPONSE_IMDBVOTES] as? String ?? NA
        self.posterImgURL = infoDictionary[OMDb_RESPONSE_POSTER] as? String ?? ""
        self.runtime = infoDictionary[OMDb_RESPONSE_RUNTIME] as? String ?? NA
        self.type = MotionPictureType(rawValue: ((infoDictionary[OMDb_RESPONSE_TYPE] as! String).capitalizedString))
    }
    
}
