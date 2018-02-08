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

