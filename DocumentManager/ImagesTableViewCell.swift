//
//  ImagesTableViewCell.swift
//  DocumentManager
//
//  Created by Bob De Kort on 2/5/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import UIKit

class ImagesTableViewCell: UITableViewCell {
    
    var imageurl: URL? {
        didSet{
            if let url = imageurl {
                let data = try! Data(contentsOf: url)
                let image = UIImage(data: data)
                self.mainImageView.image = image
            }
        }
    }
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
