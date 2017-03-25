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
    
    
    init(infoDictionary: [String: AnyObject]){
        self.name = infoDictionary["Title"] as! String
        self.genre = infoDictionary["Genre"] as? String ?? "N/A"
        self.releaseDate = infoDictionary["Released"] as? String ?? "N/A"
        self.plot = infoDictionary["Plot"] as? String ?? "N/A"
        self.rating = infoDictionary["imdbRating"] as? String ?? "N/A"
        self.votes = infoDictionary["imdbVotes"] as? String ?? "N/A"
        self.posterImgURL = infoDictionary["Poster"] as? String ?? ""
    }
    
}
