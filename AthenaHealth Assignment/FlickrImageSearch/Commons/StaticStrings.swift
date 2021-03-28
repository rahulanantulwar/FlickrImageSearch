//
//  StaticStrings.swift
//  ImageSearchAssignment
//
//  Created by RAHUL ANANTULWAR on 28/03/21.
//  Copyright © 2021 Satyadev Chauhan. All rights reserved.
//

import Foundation

class StaticStrings {
    private init(){}
    static let shared = StaticStrings()
    
    // Static Message strings
    let emptyString = ""
    let noDataToShow = "Nothing to show."
    let flickr = "Flickr"
    let ok = "OK"
    let userGuide = "User Guide"
    let userGuideMsg = "Please search images with name. \n Example: Try searching 'Kittens'"
    let firstLaunchStr = "isFirstLaunch"
}
