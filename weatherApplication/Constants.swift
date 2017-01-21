//
//  Constants.swift
//  weatherApplication
//
//  Created by Gursimran Singh on 2016-06-21.
//  Copyright © 2016 gursimran. All rights reserved.
//

import Foundation
import UIKit

let BASE_URL = "http://api.apixu.com/v1/forecast.json"

let key = "88c3faaa16ce49ec9b8225047163105"

//Creating closures that is not returning anything and not having any parameters.
typealias DownloadComplete = () -> ()

struct Colors {
    static let blue = UIColor(red: 46.0 / 255.0, green: 117.0 / 255.0, blue: 146.0 / 255.0, alpha: 1.0)
    static let red = UIColor(red: 209.0 / 255.0, green: 42.0 / 255.0, blue: 24.0 / 255.0, alpha: 1.0)
    static let white = UIColor.whiteColor()
    static let clear = UIColor.clearColor()
}