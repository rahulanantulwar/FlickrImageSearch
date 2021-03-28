//
//  Constants.swift
//  FlickrImageSearch
//
//  Created by RAHUL ANANTULWAR on 26/03/21.
//  Copyright © 2021 RAHUL ANANTULWAR. All rights reserved.
//

import UIKit

/**
 - Description: In this class I have set the API key, how much data to show per page (60). This class also has sizes characteristics that I have found form Flickr site
 - Author: Rahul Anantulwar
 */

class Constants: NSObject {

    static let api_key = "a4f28588b57387edc18282228da39744"
    static let per_page = 60
    static let searchURL = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(Constants.api_key)&format=json&nojsoncallback=1&safe_search=1&per_page=\(Constants.per_page)&text=%@&page=%ld"
    static let imageURL = "https://farm%d.staticflickr.com/%@/%@_%@_\(Constants.size.url_s.value).jpg"
    
    enum size: String { // Size enum got from flickr constants from web
        case url_sq = "s"
        case url_q = "q"
        case url_t = "t"
        case url_s = "m"
        case url_n = "n"
        case url_m = "-"
        case url_z = "z"
        case url_c = "c"
        case url_l = "b"
        case url_h = "h"
        case url_k = "k"
        case url_o = "o"
        
        var value: String {
            return self.rawValue
        }
    }
}
