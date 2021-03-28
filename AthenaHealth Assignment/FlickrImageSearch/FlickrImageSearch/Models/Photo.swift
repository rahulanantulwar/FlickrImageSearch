//
//  Photo.swift
//  FlickrImageSearch
//
//  Created by RAHUL ANANTULWAR on 26/03/21.
//  Copyright © 2021 RAHUL ANANTULWAR. All rights reserved.
//

import UIKit

struct Photo: Codable {
    
    let farm : Int
    let id : String
    
    let isfamily : Int
    let isfriend : Int
    let ispublic : Int
    
    let owner: String
    let secret : String
    let server : String
    let title: String
    
    var imageURL: String {
        let urlString = String(format: Constants.imageURL, farm, server, id, secret)
        return urlString
    }
}
