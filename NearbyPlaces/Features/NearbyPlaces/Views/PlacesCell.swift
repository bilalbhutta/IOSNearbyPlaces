//
//  PlacesCell.swift
//  QIAssignment
//
//  Created by Bilal Bhutta on 1/7/17.
//  Copyright © 2017 Bilal Bhutta. All rights reserved.
//

import UIKit
import AlamofireImage
import SafariServices

class PlacesCell: UICollectionViewCell {
    let maxWidht = 600
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    weak var delegate: PlaceCellDelegate?
    var place: QPlace?
    
    override func awakeFromNib() {
        super.awakeFromNib()        
        container.layer.borderWidth = 1
        container.layer.cornerRadius = 5
        container.clipsToBounds = true
    }
    
    func update(place:QPlace) {
        self.place = place
        label.text = place.getDescription()
        imageView.image = nil
        
        if let url = place.photos?.first?.getPhotoURL(maxWidth: maxWidht) {
            imageView.af_setImage(withURL: url)
        }
    }
    @IBAction func callbackWebsiteButton(_ sender: Any) {
        if let place = place, let delegate = delegate {
            delegate.didClickWebsite(place: place)
        }
    }
}

protocol PlaceCellDelegate: class {
    func didClickWebsite(place: QPlace)
}
