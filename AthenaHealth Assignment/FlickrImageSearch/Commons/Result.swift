//
//  Result.swift
//  FlickrImageSearch
//
//  Created by RAHUL ANANTULWAR on 26/03/21.
//  Copyright © 2021 RAHUL ANANTULWAR. All rights reserved.
//

import UIKit

enum Result <T>{
    case Success(T)
    case Failure(String)
    case Error(String)
}
