//
//  Factory.swift
//  LemonadeStand
//
//  Created by Charles Eison on 2/10/15.
//  Copyright (c) 2015 Charles Eison. All rights reserved.
//

import Foundation
import UIKit

class Factory {
    class func createCustomers() -> [Customers] {
        
        
        var numberOfCustomers = Int(arc4random_uniform(UInt32(10))) + 2
        var customers: [Customers] = []
        
        for var customerNumber = 0; customerNumber < numberOfCustomers; customerNumber++ {
            var preference = Double(arc4random_uniform(UInt32(10))) / 10
            var customerWithPreference = Customers()
            customerWithPreference.preference = preference
            customers.append(customerWithPreference)
        
        }
        return customers
    }
    
    
}

