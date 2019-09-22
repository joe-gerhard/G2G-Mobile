//
//  SearchViewController.swift
//  G2G
//
//  Created by Joseph Gerhard on 9/21/19.
//  Copyright © 2019 David Bae. All rights reserved.
//

import UIKit
import GoogleMaps
import Firebase

class SearchViewController: UIViewController {
    private let locationManager = CLLocationManager()
    
    var db: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // [START setup]
        let settings = FirestoreSettings()
        
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        mapView.delegate = self
        locationManager.requestWhenInUseAuthorization()

        
    }
    
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    private func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) {
        
        // 1
        let geocoder = GMSGeocoder()
        
        // 2
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            guard let address = response?.firstResult(), let lines = address.lines else {
                return
            }
            
            // 3
            self.addressLabel.text = lines.joined(separator: "\n")
            
            // 4
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
        }
    }

}

// MARK: - CLLocationManagerDelegate
//1
extension SearchViewController: CLLocationManagerDelegate {
    // 2
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // 3
        guard status == .authorizedWhenInUse else {
            return
        }
        // 4
        locationManager.startUpdatingLocation()
        
        //5
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    
    // 6
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        // 7
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        
        // 8
        locationManager.stopUpdatingLocation()
    }
}

extension SearchViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        reverseGeocodeCoordinate(position.target)
    }
    
    private func getCollection() {
        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
    private func addAda() {
        var ref: DocumentReference? = nil
        ref = db.collection("users").addDocument(data: [
            "first": "Ada",
            "last": "Lovelace",
            "born": 1815,

        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    private func addBR1() {
        var ref: DocumentReference? = nil
        ref = db.collection("bathrooms").addDocument(data: [
            "type": "Starbucks",
            "ADA": true,
            "NGB": false,
            "lat": 31.268950,
            "lon": -97.8
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                }
        }
    }
    
    private func addBR2() {
        var ref: DocumentReference? = nil
        ref = db.collection("bathrooms").addDocument(data: [
            "type": "IHOP",
            "ADA": false,
            "NGB": false,
            "lat": 32.268950,
            "lon": -97.8
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    private func addBR3() {
        var ref: DocumentReference? = nil
        ref = db.collection("bathrooms").addDocument(data: [
            "type": "Barnes and Nobles",
            "ADA": true,
            "NGB": true,
            "lat": 31.48950,
            "lon": -98.8
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    private func addBR4() {
        var ref: DocumentReference? = nil
        ref = db.collection("bathrooms").addDocument(data: [
            "type": "Whitecastle",
            "ADA": false,
            "NGB": false,
            "lat": 32.48950,
            "lon": -96.8
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    private func addBR5() {
        var ref: DocumentReference? = nil
        ref = db.collection("bathrooms").addDocument(data: [
            "type": "Starbucks",
            "ADA": false,
            "NGB": false,
            "lat": 31.48950,
            "lon": -98.8
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    private func addBR6() {
        var ref: DocumentReference? = nil
        ref = db.collection("bathrooms").addDocument(data: [
            "type": "Jackalope",
            "ADA": true,
            "NGB": false,
            "lat": 31.2,
            "lon": -95.8
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    private func addBR7() {
        var ref: DocumentReference? = nil
        ref = db.collection("bathrooms").addDocument(data: [
            "type": "I'm running out of places",
            "ADA": false,
            "NGB": false,
            "lat": 33.48950,
            "lon": -100.8
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    private func addBR8() {
        var ref: DocumentReference? = nil
        ref = db.collection("bathrooms").addDocument(data: [
            "type": "McDonalds",
            "ADA": true,
            "NGB": true,
            "lat": 29.48950,
            "lon": -98.8
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    private func addBR9() {
        var ref: DocumentReference? = nil
        ref = db.collection("bathrooms").addDocument(data: [
            "type": "Burger King",
            "ADA": true,
            "NGB": false,
            "lat": 34.1351,
            "lon": -97.1315
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    private func addBR10() {
        var ref: DocumentReference? = nil
        ref = db.collection("bathrooms").addDocument(data: [
            "type": "Thistle",
            "ADA": true,
            "NGB": true,
            "lat": 31.13451,
            "lon": -97.1258
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
}
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


