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


let url = "https://s3-us-west-2.amazonaws.com/ios-homework/ios/feed.json"
class ImageService {
    
    func getImagesWidgets(completion:(success: Bool,imageWidget: Array<ImageWidget>?)->Void) {
        
        Alamofire.request(.GET, url, parameters: nil)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    if let JSON = response.result.value {
                        let result : Array<ImageWidget> = Mapper<ImageWidget>().mapArray(JSON)!
                        completion(success: true, imageWidget: result)
                    }
                case .Failure(let error):
                    print(error)
                    completion(success: true, imageWidget: nil)
                }
        }

    }
}