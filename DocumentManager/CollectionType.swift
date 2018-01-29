//
//  CollectionType.swift
//  DocumentManager
//
//  Created by Bob De Kort on 1/22/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import Foundation

struct Collection: Decodable {
    var collection_name: String
    var zipped_images_url: URL
    var unzippedImageURL: URL?
    
    enum Keys: String, CodingKey {
        case collectionName = "collection_name"
        case zippedImagesUrl = "zipped_images_url"
    }
}
