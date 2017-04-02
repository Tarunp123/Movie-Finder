//
//  MotionPictureSummaryDTO.swift
//  Movie Finder
//
//  Created by Tarun Prajapati on 26/03/17.
//  Copyright © 2017 Tarun Prajapati. All rights reserved.
//
//

import Foundation

struct MotionPictureSummaryDTO {
    let id : String
    let name: String
    let releaseDate: String
    let type : MotionPictureType
    let posterImgURL: String
    
    
    init(infoDictionary: [String: AnyObject], andPictureType type: MotionPictureType){
        self.id = infoDictionary[OMDb_RESPONSE_ID] as! String
        self.name = infoDictionary[OMDb_RESPONSE_TITLE] as! String
        self.releaseDate = infoDictionary[OMDb_RESPONSE_YEAR] as? String ?? NA
        self.posterImgURL = infoDictionary[OMDb_RESPONSE_POSTER] as? String ?? ""
        self.type = type
    }
    
}
