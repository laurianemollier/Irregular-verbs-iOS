//
//  FirstLaunch.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 16/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation

/// Check if it is the first app launch.
/// Imutable class
///
/// PS: To init just one time, at the app launch
final class FirstLaunch{
    
    // ---------------------
    // MARK: - Public fields
    // ---------------------
    
    /// Is true is the app was lunch before
    let wasLaunchedBefore: Bool
    
    /// Is true is it is the first time that the app is run
    let isFirstLaunch: Bool

    
    // ----------------------
    // MARK: - Private fields
    // ----------------------
    
    private let userDefaults: UserDefaults = .standard
    
    /// The key to staore in the userDefaults
    private let key = AppInfos.appId + "wasLaunchedBefore"
    
    
    // -----------------------
    // MARK: - Initialisations
    // -----------------------
    
    /// Init the class and compute at that moment if the app was launched before or not.
    /// That means that this class has to be instenciate just one time, at the app launch
    init() {
        let wasLaunchedBefore = self.userDefaults.bool(forKey: key)
        self.wasLaunchedBefore = wasLaunchedBefore
        self.isFirstLaunch = !wasLaunchedBefore
        
        if self.isFirstLaunch {
            self.userDefaults.set(true, forKey: key)
        }
    }
    
    
}
