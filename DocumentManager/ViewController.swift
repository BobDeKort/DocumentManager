//
//  ViewController.swift
//  DocumentManager
//
//  Created by Bob De Kort on 1/22/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var viewCollections = [Collection]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = "https://s3-us-west-2.amazonaws.com/mob3/image_collection.json"
        NetworkLayer.shared.getCollections(url: url) { (collections) in
            NetworkLayer.shared.downloadZipForCollection(collection: collections[0], completionHandler: { (path) in
                let filePath = DocumentManager.shared.unzipFile(filePath: path)
                if let pathString = filePath?.appendingPathComponent("forest/_preview.png").absoluteString {
                    print("Image Path \(pathString)")
                    print("Image loading")
                    let image = UIImage(contentsOfFile: pathString)
                    self.imageView.image = image
                    let myCollection = collections[0]
                    
                    self.viewCollections.append(Collection(collection_name: myCollection.collection_name, zipped_images_url: myCollection.zipped_images_url, unzippedImageURL: filePath))
                }
            })
        }
    }
    
    func getPreviewImage() -> URL? {
        let image = viewCollections[0]
        let collectionFiles = try? FileManager.default.contentsOfDirectory(at: image.unzippedImageURL!, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
        
        guard let previewImageURL = collectionFiles?.filter({ (url) -> Bool in
            url.deletingPathExtension().lastPathComponent.contains("_preview")
        }).first else {return nil}
        return previewImageURL
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

