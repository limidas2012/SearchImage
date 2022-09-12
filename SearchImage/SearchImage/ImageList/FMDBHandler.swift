//
//  FMDBHandler.swift
//  SearchImage
//
//  Created by Limi Das on 11/09/22.
//  Copyright © 2022 Limi Das. All rights reserved.
//

import Foundation

class FMDBHandler:LocalDataFetchable{
    func insert(images: [ImageModel]) {
        // get images from server api
        
        let headers = [
            "X-RapidAPI-Key": "bbe2cd6d8fmsh7eb13b1b8d3e949p123d93jsnfd06374b11d3",
            "X-RapidAPI-Host": "contextualwebsearch-websearch-v1.p.rapidapi.com"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://contextualwebsearch-websearch-v1.p.rapidapi.com/api/search/NewsSearchAPI?q=taylor%20swift&pageNumber=1&pageSize=10&autoCorrect=true&fromPublishedDate=null&toPublishedDate=null")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print("server response")
                print(httpResponse)
            }
        })

        dataTask.resume()
    }
    
    func fetchImageList() -> [ImageModel] {
        return [] //database logic implement
    }
    
    
}
