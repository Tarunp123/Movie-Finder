//
//  SearchModel.swift
//  Movie Finder
//
//  Created by Tarun Prajapati on 25/03/17.
//  Copyright © 2017 Tarun Prajapati. All rights reserved.
//

import Foundation

protocol SearchModelDelegate: class {
    func searchModel(model: SearchModel, didFindMotionPicture motionPicture: MotionPictureDTO?)
    func searchModel(model: SearchModel, didEncounterError error: NSError?)
}



class SearchModel: NSObject {

    private var httpRequestor : HTTPRequestor?
    
    var delegate: SearchModelDelegate?
    
    
    func findMotionPicture(motionPicture: MotionPictureRequestDTO){
        
        let qualityOfServiceClass = QOS_CLASS_BACKGROUND
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        dispatch_async(backgroundQueue, {
            
            let urlString = OMDb_BASE_URL + OMDb_PARAM_TITLE + "=" + motionPicture.name.replaceWhiteSpaceWithPlus() + "&" + OMDb_PARAM_TYPE + "=" + motionPicture.type.rawValue
            self.httpRequestor = HTTPRequestor(URLString: urlString)
            self.httpRequestor?.makeRequest({ (response, error) in
                
                //Error and NUll Check
                guard error == nil && response != nil else{
                    self.delegate?.searchModel(self, didEncounterError: error)
                    return
                }
                
                //Checking if response object actually contains any data
                if response!["Response"] as! String == "False"{
                    self.delegate?.searchModel(self, didEncounterError: error)
                    return
                }
                
                //Success! Inform the delegate
                let motionPictureDTO = MotionPictureDTO(infoDictionary: response!)
                self.delegate?.searchModel(self, didFindMotionPicture: motionPictureDTO)
            })
            
        })
        
    }
    
    
    
    
    
    
}
