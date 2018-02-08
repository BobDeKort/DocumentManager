//
//  CollectionType.swift
//  DocumentManager
//
//  Created by Bob De Kort on 1/22/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import Foundation
import UIKit

class Collection: Decodable {
    var collection_name: String
    var zipped_images_url: URL
    var unzippedImageURL: URL?
    
    enum Keys: String, CodingKey {
        case collectionName = "collection_name"
        case zippedImagesUrl = "zipped_images_url"
    }
    
    init(collectionName: String, zippedImagesUrl: URL, unzippedImageUrl: URL?) {
        self.collection_name = collectionName
        self.zipped_images_url = zippedImagesUrl
        self.unzippedImageURL = unzippedImageUrl
    }
    
    func downloadAndUnzip(completionHandler: @escaping ()->()){
        NetworkLayer.shared.downloadZipForCollection(collection: self) { (path) in
            self.unzip(filePath: path, completionHandler: { (url) in
                self.unzippedImageURL = url
                completionHandler()
            })
        }
    }
    
    func unzip(filePath: URL, completionHandler: @escaping (URL)->()){
        let path = DocumentManager.shared.unzipFile(filePath: filePath)
        if let path = path {
            completionHandler(path)
        }
    }
    
    func getPreviewImage() -> String? {
        let urls = getContentsOfZippedDirectory()
        
        if let urls = urls {
            guard let previewImageurl = urls.filter({ (url) -> Bool in
                url.deletingPathExtension().lastPathComponent.contains("_preview")
            }).first else {
                print("No preview URl")
                return nil
            }
            return previewImageurl.absoluteString
        } else {
            print("No Content of zip")
            return nil
        }
    }
    
    func getContentsOfZippedDirectory() -> [URL]? {
        if self.unzippedImageURL != nil {
            if let url = self.getProperCachesURL() {
                do {
                    let collectionFiles = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
                    
                    return collectionFiles
                } catch {
                    print("No collection files")
                    print(error)
                    return nil
                }
            }
            print("No propper url")
            return nil
        }
        print("No unzippedImageURL")
        return nil
    }
    
    func getProperCachesURL() -> URL? {
        let unzippedFolderTitle = self.zipped_images_url.deletingPathExtension().lastPathComponent.replacingOccurrences(of: "+", with: " ")
        let collectionCacheFileUrl = self.unzippedImageURL?.deletingLastPathComponent().appendingPathComponent(unzippedFolderTitle, isDirectory: true)
        return collectionCacheFileUrl
    }
}
