//
//  WeatherData.swift
//  Clima
//
//  Created by Rishabh Sharma on 16/05/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Decodable{
    let name : String
    
    let main : Main
    
    let weather : [Weather]
    let wind : Wind
}

struct Main : Decodable{
    let temp : Double
}

struct Weather : Decodable{
    let id : Int
    let main : String
}

struct Wind : Decodable{
    let speed : Double
}
