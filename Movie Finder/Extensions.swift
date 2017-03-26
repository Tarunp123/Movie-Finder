//
//  Extensions.swift
//  Movie Finder
//
//  Created by Tarun Prajapati on 23/03/17.
//  Copyright © 2017 Tarun Prajapati. All rights reserved.
//

import Foundation
import UIKit
import SGImageCache
import NVActivityIndicatorView


//MARK:- UIColor
extension UIColor{
    
    convenience init(sameRGB: Int){
        self.init(red: CGFloat(sameRGB)/255.0, green: CGFloat(sameRGB)/255.0, blue: CGFloat(sameRGB)/255.0, alpha: 1.0)
    }
    
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1.0)
    }
    
}


//MARK:- UIImageView
extension UIImageView{
    
    convenience init(frame: CGRect, image: UIImage?, contentMode: UIViewContentMode, cornerRadius: CGFloat, clipsToBounds: Bool){
        self.init(frame: frame)
        self.image = image
        self.contentMode = contentMode
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = clipsToBounds
    }

}

//MARK:- SGImageView
extension SGImageView{
    
    convenience init(frame: CGRect, image: UIImage?, contentMode: UIViewContentMode, cornerRadius: CGFloat, clipsToBounds: Bool){
        self.init(frame: frame)
        self.image = image
        self.contentMode = contentMode
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = clipsToBounds
    }
    
}




//MARK:- UILabel
extension UILabel{
    
    convenience init(frame: CGRect, font: UIFont, textColor: UIColor, alignment : NSTextAlignment?){
        self.init(frame: frame)
        self.font = font
        self.textColor = textColor
        self.textAlignment = alignment ?? .Center
    }
    
}

//MARK:- UITextField
extension UITextField{
    
    convenience init(frame: CGRect, placeholder: String, font: UIFont, textColor: UIColor) {
        self.init(frame: frame)
        self.placeholder = placeholder
        self.font = font
        self.textColor = textColor
    }
    
}


//MARK:- NSData
extension NSData{
    
    func getDictionary() -> NSDictionary?{
        
        do{
            let json = try NSJSONSerialization.JSONObjectWithData(self, options: .MutableContainers)
            if let dictionary = json as? NSDictionary{
                return dictionary
            }
        }catch{
            //Handle error
        }
        
        return nil
    }

}


//MARK:- String
extension String{

    func replaceWhiteSpaceWithPlus() -> String {
        return self.componentsSeparatedByString(" ").filter { !$0.isEmpty }.joinWithSeparator("+")
    }
    
    //check if img url is http
    //if yes then change it to https
    func getHTTPSUrlString() -> String {
        var url = self
        if(!url.containsString("https://")){
            url = url.stringByReplacingOccurrencesOfString("http://", withString: "https://")
        }
        return url
    }
}



//MARK:- UIViewController
extension UIViewController{
    
    //MARK:- Show String on White Fullscreen
    func showTextOnFullscreenWhiteBg(string: String){
        dispatch_async(dispatch_get_main_queue()) {
            self.view.backgroundColor = UIColor.whiteColor()
            let notLoggedInLabel = UILabel(frame: CGRectMake(0, 0, 394*MF, self.view.frame.height*0.6), font: UIFont.systemFontOfSize(20*MF, weight: UIFontWeightMedium), textColor: DARK_GREY_COLOR, alignment: .Center)
            notLoggedInLabel.center = CGPointMake(self.view.frame.width/2, self.view.frame.height*0.4)
            notLoggedInLabel.numberOfLines = 0
            notLoggedInLabel.text = string
            self.view.addSubview(notLoggedInLabel)
        }
    }

    
    func showLoadingAnimation(){
        dispatch_async(dispatch_get_main_queue()) {
            let activityIndicator = NVActivityIndicatorView(frame: CGRectMake(0, 0, 54*MF, 54*MF), type: NVActivityIndicatorType.BallTrianglePath, color: UIColor.whiteColor(), padding: 0)
            activityIndicator.center = CGPointMake(self.view.center.x, self.view.frame.height*0.4)
            activityIndicator.color = UIColor.darkTextColor()
            activityIndicator.startAnimating()
            self.view.addSubview(activityIndicator)
        }
    }
    
    func stopLoadingAnimation(){
        dispatch_async(dispatch_get_main_queue()) {
            for view in self.view.subviews{
                if view.isKindOfClass(NVActivityIndicatorView){
                    if let activityIndicator = view as? NVActivityIndicatorView{
                        activityIndicator.stopAnimating()
                    }
                }
            }
            
        }
        
    }

    
}
