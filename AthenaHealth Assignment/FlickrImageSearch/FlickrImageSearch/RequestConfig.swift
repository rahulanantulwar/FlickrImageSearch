//
//  RequestConfig.swift
//  FlickrImageSearch
//
//  Created by RAHUL ANANTULWAR on 26/03/21.
//  Copyright © 2021 RAHUL ANANTULWAR. All rights reserved.
//

import UIKit

enum RequestConfig {
    
    case searchRequest(String, Int)
    
    var value: Request? {
        
        switch self {
            
        case .searchRequest(let searchText, let pageNo):
            let urlString = String(format: Constants.searchURL, searchText, pageNo)
            let reqConfig = Request.init(requestMethod: .get, urlString: urlString)
            return reqConfig
        }
    }
}
