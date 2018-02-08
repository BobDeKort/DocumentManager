//
//  PreviewTableViewCell.swift
//  DocumentManager
//
//  Created by Bob De Kort on 2/4/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import UIKit

class PreviewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var previewImage: UIImageView!
    
    var collection: Collection? {
        didSet {
            if (collection != nil) {
                getSetPreviewImage()
            }
        }
    }
    
    func getSetPreviewImage(){
        if let collection = collection {
            // Downloads and unzips zip file
            collection.downloadAndUnzip(completionHandler: {
                DispatchQueue.main.async {
                    self.titleLabel.text = collection.collection_name
                    let imageUrl = collection.getPreviewImage()
                    if let url = imageUrl {
                        let imageURL = URL(string: url)!
                        let data = try! Data(contentsOf: imageURL)
                        let image = UIImage(data: data)
                        self.previewImage.image = image
                    }
                }
            })
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
