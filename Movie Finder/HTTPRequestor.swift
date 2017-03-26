//
//  HTTPRequestor.swift
//  Movie Finder
//
//  Created by Tarun Prajapati on 23/03/17.
//  Copyright © 2017 Tarun Prajapati. All rights reserved.
//

import Foundation


class HTTPRequestor{
    
    private var URL: NSURL!
    
    
    init(URLString: String){
        self.URL = NSURL(string: URLString) ?? NSURL(string: "")
    }
    
    
    func makeRequest(closure: (response: [String: AnyObject]?, error: NSError?) -> Void){
        let request = NSURLRequest(URL: self.URL)
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let downloadTask =  session.dataTaskWithRequest(request) { (responseData, urlResponse, error) -> Void in
            
            //Error Encountered!
            guard error == nil else{
                closure(response: nil, error: error)
                return
            }
            
            //Response Data is nil
            guard responseData != nil else{
                closure(response: nil, error: error)
                return
            }
            
            //Convert Data to Dictionary and call closure
            if let dictionary = responseData?.getDictionary() as? [String: AnyObject]{
                closure(response: dictionary, error: error)
                return
            }
            
            //Could not convert data to dictionary
            closure(response: nil, error: error)
        }
        downloadTask.resume()
    }
    
}