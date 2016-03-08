//
//  ViewController.swift
//  GrubScore
//
//  Created by Margeaux Spring on 3/2/16.
//  Copyright © 2016 Margeaux Spring. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        //use gps for location
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        var latitude:CLLocationDegrees = 38.2500
        
        var longitude:CLLocationDegrees = -85.7667
        
        //for zooming
        var latDelta: CLLocationDegrees = 0.02
        var lonDelta: CLLocationDegrees = 0.02
        
        //make span which is combination of 2 deltas
        var span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        
        var location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        var region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        map.setRegion(region, animated: true)
        
        //pins
        var annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Louisville"
        annotation.subtitle = "Lots of places to score grub."
        map.addAnnotation(annotation)
        
        var uilpgr = UILongPressGestureRecognizer(target: self, action: "action:")
        uilpgr.minimumPressDuration = 2
        map.addGestureRecognizer(uilpgr)
        
    }
    
    //create function for action longpress
    func action(gestureRecognizer: UIGestureRecognizer) {
        print("Gesture Recognized")
        //user pins
        var touchPoint = gestureRecognizer.locationInView(self.map)
        var newCoordinate: CLLocationCoordinate2D = map.convertPoint(touchPoint, toCoordinateFromView: self.map)
        var annotation = MKPointAnnotation()
        annotation.coordinate = newCoordinate
        annotation.title = "New Restaurant"
        annotation.subtitle = "Grubbage."
        map.addAnnotation(annotation)
    
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        
        //return location of user
        var userLocation: CLLocation = locations[0]
        var latitude = userLocation.coordinate.latitude
        var longitude = userLocation.coordinate.longitude
        //for zooming
        var latDelta: CLLocationDegrees = 0.01
        var lonDelta: CLLocationDegrees = 0.01
        
        //make span which is combination of 2 deltas
        var span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        
        var location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        var region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        self.map.setRegion(region, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

