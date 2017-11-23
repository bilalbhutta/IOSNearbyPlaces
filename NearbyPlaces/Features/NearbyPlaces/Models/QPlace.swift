//
//  QPlace.swift
//  QIAssignment
//
//  Created by Bilal Bhutta on 1/7/17.
//  Copyright © 2017 Bilal Bhutta. All rights reserved.
//

import UIKit
import CoreLocation


private let geometryKey = "geometry"
private let locationKey = "location"
private let latitudeKey = "lat"
private let longitudeKey = "lng"
private let nameKey = "name"
private let openingHoursKey = "opening_hours"
private let openNowKey = "open_now"
private let vicinityKey = "vicinity"
private let typesKey = "types"
private let photosKey = "photos"

class QPlace: NSObject {
    
    var placeId: String
    var location: CLLocationCoordinate2D?
    var name: String?
    var photos: [QPhoto]?
    var vicinity: String?
    var isOpen: Bool?
    var types: [String]?
    
    var details: [String : Any]?
    
    init(placeInfo:[String: Any]) {
        // id
        placeId = placeInfo["place_id"] as! String
        
        // coordinates
        if let g = placeInfo[geometryKey] as? [String:Any] {
            if let l = g[locationKey] as? [String:Double] {
                if let lat = l[latitudeKey], let lng = l[longitudeKey] {
                    location = CLLocationCoordinate2D.init(latitude: lat, longitude: lng)
                }
            }
        }
        
        // name
        name = placeInfo[nameKey] as? String
        
        // opening hours
        if let oh = placeInfo[openingHoursKey] as? [String:Any] {
            if let on = oh[openNowKey] as? Bool {
                isOpen = on
            }
        }
        
        // vicinity
        vicinity = placeInfo[vicinityKey] as? String
        
        // types
        types = placeInfo[typesKey] as? [String]
        
        // photos
        photos = [QPhoto]()
        if let ps = placeInfo[photosKey] as? [[String:Any]] {
            for p in ps {
                photos?.append(QPhoto.init(photoInfo: p))
            }
        }
    }
    
    func getDescription() -> String {
        
        var s : [String] = []
        
        if let name = name {
            s.append("Name: \(name)")
        }
        
        if let vicinity = vicinity {
            s.append("Vicinity: \(vicinity)")
        }
        
        if let types = types {
            s.append("Types: \(types.joined(separator: ", "))")
        }
        
        if let isOpen = isOpen {
            s.append(isOpen ? "OPEN NOW" : "CLOSED NOW")
        }
        
        return s.joined(separator: "\n")
    }
    
    func heightForComment(_ font: UIFont, width: CGFloat) -> CGFloat {
        let desc = getDescription()
        let rect = NSString(string: desc).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        return ceil(rect.height)
    }
    
    
    
    
}
