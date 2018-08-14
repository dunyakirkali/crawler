//
//  ViewController.swift
//  Crawler
//
//  Created by Dunya Kirkali on 8/4/18.
//  Copyright © 2018 Ahtung. All rights reserved.
//

import Cocoa
import MapKit

class ViewController: NSViewController {

    @IBOutlet weak var fromField: NSTextField!
    @IBOutlet weak var toField: NSTextField!
    @IBOutlet weak var searchButton: NSButton!
    @IBOutlet weak var mapView: MKMapView!
    
    fileprivate var searchCompleter = MKLocalSearchCompleter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchCompleter.delegate = self
        mapView.delegate = self
        fromField.delegate = self
        toField.delegate = self
        
        searchButton.action = #selector(ViewController.search)
        
        let request = MKDirectionsRequest()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 52.3446243, longitude: 4.8002163), addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 52.3626209, longitude: 4.8765708), addressDictionary: nil))
        request.requestsAlternateRoutes = true
        request.transportType = .walking
        
        let directions = MKDirections(request: request)
        
        directions.calculate { [unowned self] response, error in
            guard let unwrappedResponse = response else { return }
            
            for route in unwrappedResponse.routes {
                self.mapView.add(route.polyline)
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.strokeColor = .blue
        return renderer
    }
}

extension ViewController: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        if let result = completer.results.first {
            print(result.title)
        }
    }
}

extension ViewController: NSTextFieldDelegate {
    override func controlTextDidChange(_ obj: Notification) {
        let field = obj.object as! NSTextField
        searchCompleter.region = mapView.region
        switch field {
        case fromField:
            searchCompleter.queryFragment = fromField.stringValue
        case toField:
            searchCompleter.queryFragment = toField.stringValue
        default:
            print("~~")
        }
    }
}

extension ViewController {
    @objc func search() {
        print("Search")
    }
    
    @IBAction func printRoute(sender: NSButton) {
        let printOperation = NSPrintOperation(view: mapView)
        printOperation.run()
    }
}
