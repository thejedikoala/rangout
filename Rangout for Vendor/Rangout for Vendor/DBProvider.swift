//
//  DBProvider.swift
//  Rangout for Vendor
//
//  Created by Eiji Kawahira on 24/11/16.
//  Copyright © 2016 Eiji Kawahira. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DBProvider{
    private static let _instance = DBProvider();
    
    static var Instance: DBProvider {
        return _instance;
    }
    
    var dbRef: FIRDatabaseReference {
        return FIRDatabase.database().reference();
    }
    
    var driversRef: FIRDatabaseReference {
        return dbRef.child(Constants.VENDORS);
    }
    
    var requestRef: FIRDatabaseReference {
        return dbRef.child(Constants.FOOD_REQUEST);
    }
    
    var requestAcceptedRef: FIRDatabaseReference {
        return dbRef.child(Constants.FOOD_ACCEPTED);
    }
    
    func saveUser(withID: String, email: String, password: String) {
        let data: Dictionary<String, Any> = [Constants.EMAIL: email, Constants.PASSWORD: password, Constants.isBuyer: false];
        driversRef.child(withID).child(Constants.DATA).setValue(data);
    }
    
}
