//
//  SeriesDTO.swift
//  Movie Finder
//
//  Created by Tarun Prajapati on 25/03/17.
//  Copyright © 2017 Tarun Prajapati. All rights reserved.
//

import Foundation


struct Series {
    var seasons: Int!
    var seasonsAndEpisodesDictionary : [SeasonDTO : [EpisodeDTO]]
}