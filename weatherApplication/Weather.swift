//
//  Weather.swift
//  weatherApplication
//
//  Created by Gursimran Singh on 2016-06-21.
//  Copyright © 2016 gursimran. All rights reserved.
//

import Foundation
import Alamofire

class Weather {
    
    private var _cityName: String!
    private var _maxTemp: String!
    private var _minTemp: String!
    private var _currentTemp: String!
    private var _day: String!
    private var _date: String!
    private var _feelsLike: String!
    private var _description: String!
    private var _humidity: String!
    private var _wind: String!
    private var _precipitation: String!
    private var _descImg: String!
    private var _weatherURL: String!
    private var _isDay: String!
    
    var isDay: String {
        return _isDay
    }
    
    var cityName: String {
        return _cityName
    }
    
    var maxTemp: String {
        return _maxTemp
    }
    
    var minTemp: String {
        return _minTemp
    }
    
    var currentTemp: String {
        return _currentTemp
    }
    
    var day: String {
        return _day
    }
    
    var date: String {
        return _date
    }
    
    var feelslike: String {
        return _feelsLike
    }
    
    var description: String {
        return _description
    }
    
    var descImg: String {
        return _descImg
    }
    
    var humidity: String {
        return _humidity
    }
    
    var precipitation: String {
        return _precipitation
    }
    
    var wind: String {
        return _wind
    }
    
    init(location: String) {
        self._cityName = location
        
        self._weatherURL = BASE_URL
    }
    
    func downloadWeatherDetails(completed: DownloadComplete){
        
        print("DID I REACH HERE")
       
        let url = NSURL(string: BASE_URL)
        
        var city = self._cityName
        print("outside city " + city)
       
        
        Alamofire.request(.GET, url!, parameters: ["q": city, "key": key]).validate().responseJSON { response in
            
            let result = response.result
            
            //print(result.value?.debugDescription)
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                print(dict)
                print("DID I REACH HERE 123")
                
                if let error = dict["error"]{
                    print("Error in city name")
                    self._cityName = "Ottawa"
                    city = self._cityName
                    print("inside city " + city)
                    self.downloadWeatherDetails{ () -> () in
                        
                        print("Error in City. Setting default to Ottawa")
                        
                    }
                }
                    
                
                if let location = dict["location"] as? Dictionary<String, AnyObject> {
                    //print(location)
                    
                    
                    
                    if let epochTime = location["localtime_epoch"] as? Int {
                        let Date = (NSDate(timeIntervalSince1970: Double(epochTime)))
                        
                        //print(Date)
                        
                        
                        let formatter = NSDateFormatter()
                        
                        formatter.dateStyle = NSDateFormatterStyle.FullStyle
                        //formatter.timeStyle = .ShortStyle
                        
                        let datString = formatter.stringFromDate(Date)
                        let dayState = datString.componentsSeparatedByString(",")
                        print(dayState)
                        print(dayState[0])
                        
                        self._day = dayState[0]
                        
                        //var dateCombine = dayState[1] + "," + dayState[2]
                        
                        //print(dateCombine)
                        
                        self._date = dayState[1]
                       

                    }
 
                    
                    if let name = location["name"] as? String {
                        self._cityName = name
                        print(name)

                    }
                }
 
 
                
                              
                if let current = dict["current"] as? Dictionary<String, AnyObject> {
                    //print(current)
                    
                    if let isnight = current["is_day"] as? Int {
                        self._isDay = "\(isnight)"
                    }
                    
                    if let feels_like = current["feelslike_c"] as? Int {
                        self._feelsLike = "\(feels_like) ºC"
                    }
                    
                    if let humid = current["humidity"] as? Int {
                        self._humidity = "\(humid)"
                    }
                    if let windDir = current["wind_kph"] as? Int {
                        self._wind = "\(windDir)"
                    }
                    if let current = current["temp_c"] as? Int {
                        self._currentTemp = "\(current) º C"
                    }
                    if let condition = current["condition"] as? Dictionary<String, AnyObject> {
                        if let desc = condition["text"] as? String {
                            self._description = desc
                        }
                        if let code = condition["code"] as? Int {
                                self._descImg = "\(code)"
                            }
                        
                        print(self._description)
                    }
                }
                
                if let forecast = dict["forecast"] as? Dictionary<String, AnyObject> {
                    if let forecastDay = forecast["forecastday"] as? [Dictionary<String, AnyObject>] {
                        
                        if let epochTime = forecastDay[0]["localtime_epoch"] as? Int {
                            let Date = (NSDate(timeIntervalSince1970: Double(epochTime)))
                            
                            //print(Date)
                            
                            let formatter = NSDateFormatter()
                            
                            formatter.dateStyle = NSDateFormatterStyle.FullStyle
                            //formatter.timeStyle = .ShortStyle
                            
                            let datString = formatter.stringFromDate(Date)
                            let day = datString.componentsSeparatedByString(",")
                            
                            self._day = day[0]
                            self._date = "\(day[1]),\(day[2])"
                            
                            
                        }
                        
                        if let day = forecastDay[0]["day"] as? Dictionary<String, AnyObject> {
                            if let maxT = day["maxtemp_c"] as? Int {
                                self._maxTemp = "\(maxT)ºC"
                            }
                            if let minT = day["mintemp_c"] as? Int {
                            self._minTemp = "\(minT)ºC"
                        }
                            if let prec = day["totalprecip_mm"] as? Int {
                                self._precipitation = "\(prec)"
                            }
                        }
                    }
                    

                }
                
                
            
    }
            
            completed()
     
        }
  

}
    
}