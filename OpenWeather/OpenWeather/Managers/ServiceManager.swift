//
//  ServiceManager.swift
//  OpenWeather
//
//  Created by Ujwal Manjunath on 6/25/17.
//  Copyright © 2017 Win-kel. All rights reserved.
//

import UIKit
import Alamofire

public typealias FetchSuccess = (_ responseObject:AnyObject?) -> Void
public typealias FetchFailure = (_ error:Error? ) -> Void

class ServiceManager: NSObject {
    
    let baseUrl:String  =  "http://api.openweathermap.org/data/2.5/"
    
    public override init() {
        super.init()
    }
    
    // process service request
    func processRequest(path:String, parameters:[String:AnyObject]?, completion:@escaping FetchSuccess, failure:@escaping FetchFailure) {
        
        let requestString = baseUrl + path
        Alamofire.request(requestString, parameters: parameters).responseJSON { response in
            
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if response.error != nil {
                failure(response.error)
                return
            }
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
                completion(json as AnyObject)
            }
        
        }
        
    }

}
