//
//  BoughtIAPProducts.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 13/09/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation

/// Common object to store if an app product has been bought
///
/// Singleton pattern.
final class BoughtIAPProducts{
    
    // ----------------------
    // MARK: - Statics fields
    // ----------------------
    
    static let shared = BoughtIAPProducts()
    
    
    // -----------------------
    // MARK: - Initialisations
    // -----------------------
    
    private init(){}
    
    
    
    /// Check if the product of id "productIdentifier" has been previously stored has "bought"
    /// - Parameters:
    ///     - productIdentifier: The id of the product
    /// - Returns: True if this product has been previously stored has "bought", else false
    func isBought(productIdentifier: String) -> Bool{
        if let result = UserDefaults.standard.object(forKey: key(productIdentifier)) as? Bool {
            return result
        }else{
            return false
        }
    }
    
    /// Store that the product of id "productIdentifier" has been bought
    /// - Parameters:
    ///     - productIdentifier: The id of the product
    func bought(productIdentifier: String){
        UserDefaults.standard.setValue(true, forKey: key(productIdentifier))
        UserDefaults.standard.synchronize()
    }
    
    
    // -------------------------
    // MARK: - Private functions
    // -------------------------
    
    /// Form the correct key to store this productIdentifier
    /// - Parameters:
    ///     - productIdentifier: The id of the product
    /// - Returns: The key to store the data associated with this product
    private func key(_ productIdentifier: String) -> String{
        return AppInfos.appId + productIdentifier
    }
    
}
