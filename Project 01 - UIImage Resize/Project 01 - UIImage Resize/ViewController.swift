//
//  ViewController.swift
//  Project 01 - UIImage Resize
//
//  Created by 一川 黄 on 27/06/2016.
//  Copyright © 2016 Jamie. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    
    @IBOutlet var mapView: MKMapView!
    var annotation: MapAnnotation!
    var clicked:Bool! = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -33.873059, longitude: 151.207048), span: MKCoordinateSpanMake(0.01, 0.01))
        mapView.setRegion(region, animated: true)
        mapView.delegate = self
        annotation = MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: -33.873059, longitude: 151.207048), title: "This is annotation")
        mapView.addAnnotation(annotation)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKAnnotationView(annotation: self.annotation, reuseIdentifier: "annotation")
        if self.clicked == true
        {
            annotationView.image = self.resizeImage(UIImage(named: "flag.png")!, newWidth: 30)
        }
        else
        {
            annotationView.image = UIImage(named: "flag.png")
        }
        return annotationView
    }
    
    
    @IBAction func buttonClicked(sender: AnyObject) {
        self.clicked = true
        self.mapView.removeAnnotation(self.annotation)
        
        self.mapView.addAnnotation(self.annotation)
    }
    
    // resize uiimage
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(newWidth, newHeight), false, 0.0);
        image.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }

}

