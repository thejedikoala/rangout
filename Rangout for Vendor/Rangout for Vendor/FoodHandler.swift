//
//  FoodHandler.swift
//  Rangout for Vendor
//
//  Created by Eiji Kawahira on 24/11/16.
//  Copyright © 2016 Eiji Kawahira. All rights reserved.
//

import Foundation
import FirebaseDatabase

protocol FoodController: class {
    func acceptFood(lat: Double, long: Double);
    func buyerCanceledFood();
    func foodCanceled();
    func updateBuyersLocation(lat: Double, long: Double);
}

class FoodHandler {
    private static let _instance = FoodHandler();
    
    weak var delegate: FoodController?;
    
    var buyer = "";
    var vendor = "";
    var vendor_id = "";
    
    static var Instance: FoodHandler {
        return _instance;
    }
    
    func observeMessagesForDriver() {
        // BUYER REQUEST FOOD
        DBProvider.Instance.requestRef.observe(FIRDataEventType.childAdded) { (snapshot: FIRDataSnapshot) in
            
            if let data = snapshot.value as? NSDictionary {
                if let latitude = data[Constants.LATITUDE] as? Double {
                    if let longitude = data[Constants.LONGITUDE] as? Double {
                        self.delegate?.acceptFood(lat: latitude, long: longitude);
                    }
                }
                
                if let name = data[Constants.NAME] as? String {
                    self.buyer = name;
                }
                
            }
            
            // BUYER CANCELED FOOD
            DBProvider.Instance.requestRef.observe(FIRDataEventType.childRemoved, with: { (snapshot: FIRDataSnapshot) in
                
                if let data = snapshot.value as? NSDictionary {
                    if let name = data[Constants.NAME] as? String {
                        if name == self.buyer {
                            self.buyer = "";
                            self.delegate?.buyerCanceledFood();
                        }
                    }
                }
                
            });
            
        }
        
        // UPDATE BUYERS LOCATION
        DBProvider.Instance.requestRef.observe(FIRDataEventType.childChanged) { (snapshot: FIRDataSnapshot) in
            
            if let data = snapshot.value as? NSDictionary {
                if let lat = data[Constants.LATITUDE] as? Double {
                    if let long = data[Constants.LONGITUDE] as? Double {
                        self.delegate?.updateBuyersLocation(lat: lat, long: long);
                    }
                }
            }
            
        }
        
        // VENDOR ACCEPT FOOD REQUEST
        DBProvider.Instance.requestAcceptedRef.observe(FIRDataEventType.childAdded) { (snapshot: FIRDataSnapshot) in
            
            if let data = snapshot.value as? NSDictionary {
                if let name = data[Constants.NAME] as? String {
                    if name == self.vendor {
                        self.vendor_id = snapshot.key;
                    }
                }
            }
            
        }
        
        // VENDOR CANCELED FOOD
        DBProvider.Instance.requestAcceptedRef.observe(FIRDataEventType.childRemoved) { (snapshot: FIRDataSnapshot) in
            
            if let data = snapshot.value as? NSDictionary {
                if let name = data[Constants.NAME] as? String {
                    if name == self.vendor {
                        self.delegate?.foodCanceled();
                    }
                }
            }
            
        }
        
    } // observeMessagesForVendor
    
    func foodAccepted(lat: Double, long: Double) {
        let data: Dictionary<String, Any> = [Constants.NAME: vendor, Constants.LATITUDE: lat, Constants.LONGITUDE: long];
        
        DBProvider.Instance.requestAcceptedRef.childByAutoId().setValue(data);
    }
    
    func cancelFoodForVendor() {
        DBProvider.Instance.requestAcceptedRef.child(vendor_id).removeValue();
    }
    
    func updateVendorLocation(lat: Double, long: Double) {
        DBProvider.Instance.requestAcceptedRef.child(vendor_id).updateChildValues([Constants.LATITUDE: lat, Constants.LONGITUDE: long]);
    }
    
}

