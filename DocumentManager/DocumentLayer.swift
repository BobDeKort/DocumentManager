//
//  DocumentLayer.swift
//  DocumentManager
//
//  Created by Bob De Kort on 1/24/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import Foundation
import Zip

class DocumentManager {
    static let shared = DocumentManager()
    let cachesURL = try! FileManager.default.url(for: FileManager.SearchPathDirectory.cachesDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: false)
    
    func unzipFile(filePath: URL) -> URL? {
        do {
            try Zip.unzipFile(filePath, destination: cachesURL, overwrite: true, password: nil)
            print("Path: \(cachesURL)")
            // Library/Caches/swimming
            let fileName = filePath.deletingPathExtension().lastPathComponent
            let fullURL = cachesURL.appendingPathComponent(fileName)
            
            return fullURL
        }
        catch {
            print("Something went wrong")
            return nil
        }
    }
    
    
}
