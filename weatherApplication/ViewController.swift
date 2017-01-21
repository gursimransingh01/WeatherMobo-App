//
//  ViewController.swift
//  weatherApplication
//
//  Created by Gursimran Singh on 2016-06-03.
//  Copyright © 2016 gursimran. All rights reserved.
//

import UIKit
import Alamofire
import CTShowcase

class ViewController: UIViewController {
    
    var weather: Weather!
    
    var timer = NSTimer()
    
    var city = "Ottawa"
    


    @IBAction func reloadButton(sender: AnyObject) {
        weather.downloadWeatherDetails { () -> () in
            print("Reloaded")
            self.updateUI()
            
        }
    }
    @IBAction func changeCity(sender: AnyObject) {
        
        let prefs = NSUserDefaults.standardUserDefaults()

        let alert = UIAlertController(title: "Enter City Name", message: "Enter City Name", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addTextFieldWithConfigurationHandler {
            (textField) -> Void in
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: {
            (action) -> Void in
            
            let textf = alert.textFields![0] as UITextField
            self.weather = Weather(location: textf.text!)
            
            self.city = textf.text!
            
            prefs.setObject(self.city, forKey: "cityName")
            
            //let name = prefs.objectForKey("cityName") as? String
            
            //self.weather = Weather(location: name!)

            //prefs.setValue(self.cityName.text, forKey: "userCity")
            
            self.weather.downloadWeatherDetails { () -> () in
                //print("Hello")
                self.updateUI()
            }
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: {
            (action) -> Void in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    
    }
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var minTemp: UILabel!
    @IBOutlet weak var descImg: UIImageView!
    @IBOutlet weak var weatherDesc: UILabel!
    @IBOutlet weak var currentTemp: UILabel!
    @IBOutlet weak var feelsTemp: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var preciptation: UILabel!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Hello")
        
        let prefs = NSUserDefaults.standardUserDefaults()

        
        timer = NSTimer.scheduledTimerWithTimeInterval(120, target: self, selector: "update", userInfo: nil, repeats: true)
        
        
      
        let showcase = CTShowcaseView(withTitle: "Change City", message: "Click on change location button to change City. Tap to dismiss this screen!", key: nil) { () -> Void in
            print("This closure will be executed after the user dismisses the showcase")
        }
        showcase.setupShowcaseForView(currentTemp)
        showcase.messageLabel.textColor = UIColor.yellowColor()
        let highlighter = CTDynamicGlowHighlighter()
        
        // Configure its parameters if you don't like the defaults
        highlighter.highlightColor = UIColor.yellowColor()
        highlighter.animDuration = 0.5
        highlighter.glowSize = 5
        highlighter.maxOffset = 10
        
        // Set it as the highlighter
        showcase.highlighter = highlighter
        
        showcase.setupShowcaseForView(currentTemp)
        showcase.show()

        //prefs.setObject("Ottawa", forKey: "cityName")
        
        //let name = prefs.objectForKey("cityName") as? String
        
        weather = Weather(location: city)
        
        weather.downloadWeatherDetails { () -> () in
            //print("Hello Ji")
            self.updateUI()
        }
       

    
    }
    
    
    func updateUI() {
        maxTemp.text = weather.maxTemp
        minTemp.text = weather.minTemp
        windSpeed.text = weather.wind
        humidity.text = weather.humidity
        feelsTemp.text = weather.feelslike
        preciptation.text = weather.precipitation
        weatherDesc.text = weather.description
        currentTemp.text = weather.currentTemp
        day.text = weather.day
        date.text = weather.date
        cityName.text = weather.cityName
        
        if weather.isDay == "1" {
            descImg.image = UIImage(named: "\(weather.descImg).png")
        } else {
            descImg.image = UIImage(named: "\(weather.descImg)n.png")
        }
    }
    
    func update() {
        weather.downloadWeatherDetails { () -> () in
            print("Updated")
            self.updateUI()
        }
    }

}

