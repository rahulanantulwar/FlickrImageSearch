//
//  SearchService.swift
//  FlickrImageSearch
//
//  Created by RAHUL ANANTULWAR on 26/03/21.
//  Copyright © 2021 RAHUL ANANTULWAR. All rights reserved.
//

import UIKit

class SearchService: NSObject {
    
    /**
     - Discription : Flickr API Call using the "flickr.photos.search" method, to retrieve photos based on search text from a given page
     - Parameters:
        - text: search term text
        - page: which page should display
        - completion: completion handler to retrieve result
     - Author: Rahul Anantulwar
     */
    
    func request(_ searchText: String, pageNo: Int, completion: @escaping (Result<Photos?>) -> Void) {
        
        guard let request = RequestConfig.searchRequest(searchText, pageNo).value else {
            return
        }
        
        NetworkManager.shared.request(request) { (result) in
            switch result {
            case .Success(let responseData):
                if let model = self.processResponse(responseData) {
                    if let stat = model.stat, stat.uppercased().contains("OK") {
                        return completion(.Success(model.photos))
                    } else {
                        return completion(.Failure(NetworkManager.errorMessage))
                    }
                } else {
                    return completion(.Failure(NetworkManager.errorMessage))
                }
            case .Failure(let message):
                return completion(.Failure(message))
            case .Error(let error):
                return completion(.Failure(error))
            }
        }
    }
    
    func processResponse(_ data: Data) -> SearchResults? {
        do {
            let responseModel = try JSONDecoder().decode(SearchResults.self, from: data)
            return responseModel
            
        } catch {
            //Data parsing error
            return nil
        }
    }
}
