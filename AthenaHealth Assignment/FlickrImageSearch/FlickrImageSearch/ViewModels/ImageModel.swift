//
//  ImageModel.swift
//  FlickrImageSearch
//
//  Created by RAHUL ANANTULWAR on 26/03/21.
//  Copyright © 2021 RAHUL ANANTULWAR. All rights reserved.
//

import UIKit

struct ImageModel {

    let imageURL: String
    
    init(withPhotos photo: Photo) {
        imageURL = photo.imageURL
    }
}
