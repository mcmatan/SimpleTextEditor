//
//  ImageService.swift
//  MobilizeBoxEditor
//
//  Created by Matan Cohen on 26/08/2016.
//  Copyright © 2016 MACMatan. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper


class ImageWidget: Mappable {
    var imageThemb: String?
    var imageOriginal: String?
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map) {
        imageThemb <- map["imageThumb"]
        imageOriginal <- map["original"]
    }
}

class ImageWidgetResponse: Mappable {
    var imageWidgets: [ImageWidget]?
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map) {
        imageWidgets <- map
    }
}



let url = "https://s3-us-west-2.amazonaws.com/ios-homework/ios/feed.json"
class ImageService {
    
    func getImages(completion:(success: Bool,imageWidget: ImageWidget )->Void) {
        
        Alamofire.request(.GET, url, parameters: nil)
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                    let user = Mapper<ImageWidgetResponse>().map(JSON)
                    print(user)
                }
        }
        
        

//        Alamofire.request(.GET, url).responseObject() { (response: Response<ImageWidgetResponse, NSError>) in
//            
//            let imagesResponse = response.result.value
//            print(imagesResponse)
////            print(weatherResponse?.location)
////            
////            if let threeDayForecast = weatherResponse?.threeDayForecast {
////                for forecast in threeDayForecast {
////                    print(forecast.day)
////                    print(forecast.temperature)           
////                }
////            }
//        }
    }
}