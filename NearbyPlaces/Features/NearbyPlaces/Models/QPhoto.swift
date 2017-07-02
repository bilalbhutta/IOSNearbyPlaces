//
//  QPhoto.swift
//  QIAssignment
//
//  Created by Bilal Bhutta on 1/7/17.
//  Copyright © 2017 Bilal Bhutta. All rights reserved.
//

import UIKit

private let widthKey = "width"
private let heightKey = "height"
private let photoReferenceKey = "photo_reference"

class QPhoto: NSObject {
    
    var width: Int?
    var height: Int?
    var photoRef: String?
    
    init(photoInfo: [String:Any]) {
        height = photoInfo[heightKey] as? Int
        width = photoInfo[widthKey] as? Int
        photoRef = photoInfo[photoReferenceKey] as? String
    }
    
    func getPhotoURL(maxWidth:Int) -> URL? {        
        if let ref = self.photoRef {
            return NearbyPlacesController.googlePhotoURL(photoReference: ref, maxWidth: maxWidth)
        }
        return nil
    }
}
