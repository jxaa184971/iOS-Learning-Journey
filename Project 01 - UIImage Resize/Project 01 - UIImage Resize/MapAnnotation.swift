//
//  MapAnnotation.swift
//  Project 01 - UIImage Resize
//
//  Created by 一川 黄 on 27/06/2016.
//  Copyright © 2016 Jamie. All rights reserved.
//

import MapKit

class MapAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String!
    
    init(coordinate:CLLocationCoordinate2D, title: String)
    {
        self.coordinate = coordinate
        self.title = title
    }
}
