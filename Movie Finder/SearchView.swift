//
//  SearchView.swift
//  Movie Finder
//
//  Created by Tarun Prajapati on 25/03/17.
//  Copyright © 2017 Tarun Prajapati. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import UITextField_Shake


class SearchView: UIView {

    var searchTF : UITextField!
    private var activityIndicatorView: NVActivityIndicatorView?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.startingPoint()
    }
    

    private func startingPoint(){
        self.backgroundColor = THEME_COLOR
        
        let geniusImgView = UIImageView(frame: CGRectMake(0, 32*MF, 39*MF, 44*MF), image: UIImage(named: GENIUS_ICON), contentMode: .ScaleAspectFit, cornerRadius: 0, clipsToBounds: false)
        geniusImgView.center = CGPointMake(self.center.x, geniusImgView.center.y)
        self.addSubview(geniusImgView)
        
        let titleLabel = UILabel(frame: CGRectMake(14*MF, geniusImgView.frame.maxY+5*MF, 386*MF, 86*MF), font: UIFont.boldSystemFontOfSize(36*MF), textColor: GOLDEN_COLOR, alignment: .Center)
        titleLabel.numberOfLines = 2
        titleLabel.text = APP_NAME
        self.addSubview(titleLabel)
        
        self.searchTF = UITextField(frame: CGRectMake(14*MF, titleLabel.frame.maxY+47*MF, 386*MF, 54*MF), placeholder: ENTER_MOVIE_NAME, font: UIFont.systemFontOfSize(20*MF), textColor: UIColor.blackColor())
        self.searchTF.backgroundColor = UIColor(sameRGB: 248)
        let leftView = UIView(frame: CGRectMake(0,0,54*MF, 54*MF))
        let searchImgView = UIImageView(frame: CGRectMake(9, 0, 26*MF, 54*MF), image: UIImage(named: SEARCH_ICON), contentMode: .ScaleAspectFit, cornerRadius: 0, clipsToBounds: false)
        leftView.addSubview(searchImgView)
        self.searchTF.leftView = leftView
        self.searchTF.leftViewMode = .Always
        self.searchTF.layer.cornerRadius = 6*MF
        self.searchTF.clearButtonMode = .WhileEditing
        self.searchTF.returnKeyType = .Search
        self.addSubview(self.searchTF)
        
        
        let footerLabel = UILabel(frame: CGRectMake(14*MF, self.frame.height - 42*MF, 386*MF, 19*MF), font: UIFont.systemFontOfSize(UIFont.smallSystemFontSize()), textColor: LIGHT_GREY_COLOR, alignment: .Center)
        footerLabel.text = POWERED_BY_OMDb
        self.addSubview(footerLabel)
        
        self.initializeActivityIndicatorView()
        
    }
    
    
    private func initializeActivityIndicatorView(){
        self.activityIndicatorView = NVActivityIndicatorView(frame: CGRectMake(0, 15, 54*MF, 24*MF), type: NVActivityIndicatorType.LineScale, color: UIColor.whiteColor(), padding: 0)
        self.activityIndicatorView?.color = UIColor.darkTextColor()
    }
    
    
    
    func startLoadingAnimation(){
        dispatch_async(dispatch_get_main_queue()) {
            if self.activityIndicatorView == nil{
                self.initializeActivityIndicatorView()
            }
            self.searchTF.rightView = (self.activityIndicatorView!)
            self.searchTF.rightViewMode = .Always
            self.activityIndicatorView?.startAnimating()
        }
    }
    
    
    func stopLoadingAnimation(){
        dispatch_async(dispatch_get_main_queue()) {
            self.activityIndicatorView?.stopAnimating()
            self.activityIndicatorView =  nil
            self.searchTF.rightViewMode = .Never
        }
    }

    
    func failureAlert() {
        dispatch_async(dispatch_get_main_queue()) { 
            self.searchTF.shake(5, withDelta: 5*MF, speed: 0.1)
        }
        
    }

    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
