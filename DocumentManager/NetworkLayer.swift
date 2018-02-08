//
//  NetworkLayer.swift
//  DocumentManager
//
//  Created by Bob De Kort on 1/22/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import Foundation
import Alamofire

class NetworkLayer {
    static let shared = NetworkLayer()
    
    func getCollections(url: String, completionHandler: @escaping ([Collection]) -> ()){
        Alamofire.request(url).responseJSON { (response) in
            if let data = response.data {
                let decoder = JSONDecoder()
                do {
                    let collectionArray = try decoder.decode([Collection].self, from: data)
                    completionHandler(collectionArray)
                } catch {
                    print("error trying to convert data to JSON")
                    print(error)
                }
            }
        }
    }
    
    func downloadZipForCollection(collection: Collection, completionHandler: @escaping (URL) -> ()) {
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            
                let temURL = try! FileManager.default.url(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: false)
                let tempURL = temURL.appendingPathComponent("\(collection.collection_name)").appendingPathExtension("zip")
                return (tempURL, [.removePreviousFile])
        }
        Alamofire.download(collection.zipped_images_url, to: destination).response { response in
            if response.error == nil {
                if let url = response.destinationURL {
                    completionHandler(url)
                    return
                }
            }
        }
    }
}
