//
//  ViewController.swift
//  Movie Finder
//
//  Created by Tarun Prajapati on 21/03/17.
//  Copyright © 2017 Tarun Prajapati. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var x = 0{
        didSet{
            print("Did Set X = \(x)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        //self.closureTest(9, num2: 0)

        
    }

    
    
   // func closureTest(num1: Int, num2: Int) -> (Int -> Int){}
    
   
   


}

