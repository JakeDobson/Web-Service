//
//  ViewController.swift
//  Web Service Example
//
//  Created by Jake Dobson on 3/13/16.
//  Copyright © 2016 Jake Dobson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var forecastLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.forecastLabel.text = ""
        
        //instantiate a gray Activity Indicator View
        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        //add the activity to the ViewController's view
        view.addSubview(activityIndicatorView)
        //position the Activity Indicator View in the center of the view
        activityIndicatorView.center = view.center
        //tell the Activity Indicator View to begin animating
        activityIndicatorView.startAnimating()
        
        let manager = AFHTTPSessionManager()
        // make call to OpenWeatherMap's servers
        manager.GET("http://api.openweathermap.org/data/2.5/forecast/daily?q=Denver&mode=json&units=metric&cnt=1&appid=26a2eae33071cf115e87340c81bceab9",
            parameters: nil,
            progress: nil,
            success: { (operation: NSURLSessionDataTask,responseObject: AnyObject?) in
                let json = JSON(responseObject!)
                if let forecast = json["list"][0]["weather"][0]["description"].string {
                    self.forecastLabel.text = forecast
                }
                activityIndicatorView.removeFromSuperview()
            },
            failure: { (operation: NSURLSessionDataTask?,error: NSError) in
                print("Error: " + error.localizedDescription)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

