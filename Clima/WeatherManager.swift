

import Foundation
import CoreLocation

protocol WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager : WeatherManager, weather : WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager{
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=8aba7fe823a4df3c2e40b63f7c18a899&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func featchWeather(cityName : String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        
        print(urlString)
        
        performRequest(with: urlString)
    }
    
    func featchWeather(latitude : CLLocationDegrees, longitude : CLLocationDegrees){
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        print(urlString)
        
        performRequest(with: urlString)
    }
    
    func performRequest( with urlString : String){
        
        
        if let url = URL(string: urlString){
            
            
            let session = URLSession(configuration: .default)
            
            let task =  session.dataTask(with: url) { (data, response, error) in
                if(error != nil){
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    //                    let dataString = String(data: safeData, encoding: .utf8)
                    
                    if let weather =  self.parseJson(safeData){
                        self.delegate?.didUpdateWeather(self, weather:weather)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJson(_ weatherData : Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do{
            let decodedData =   try
            decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.weather[0].id)
            
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let cityName = decodedData.name
            let windSpeed = decodedData.wind.speed
            
            let weather = WeatherModel(conditionId: id, cityName: cityName, temparature: temp)
            return weather
            print(weather.conditionName)
            print(weather.temperatureString)
           
            //            print(decodedData.wind.speed)
            
        } catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
}
