//
//  Audio.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 06/09/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation
import UIKit



/// Common object to aPllow or not the app to emit some sound.
/// This setting is is automaticly stored on change.
/// By default, the Audio is on.
///
/// Singleton pattern.
final class Audio{
    
    // ---------------------
    // MARK: - Statics fields
    // ---------------------
    
    /// Shared Audio object
    static let shared = Audio()
    
    
    // ----------------------
    // MARK: - Private fields
    // ----------------------
    
    private let userDefaults: UserDefaults = .standard
    
    /// The key to staore in the userDefaults
    private let key = AppInfos.appId + "audio"
    

    // -----------------------
    // MARK: - Initialisations
    // -----------------------
    
    private init(){}
    

    // ------------------------
    // MARK: - Public functions
    // ------------------------
    
    /// Turn on the Audio and store this state for the next app's run
    public func on(){
        userDefaults.setValue(true, forKey: key)
        userDefaults.synchronize()
    }
    
    /// Turn off the Audio and store this state for the next app's run
    public func off(){
        userDefaults.setValue(false, forKey: key)
        userDefaults.synchronize()
    }
    
    /// Check if the Audio has been set to on of off.
    /// If the Audio has never been set, the default behaviour is on.
    ///
    /// - Returns: True if the audio is on and else false
    public func isOn() -> Bool {
        if let audio = userDefaults.object(forKey: key) as? Bool {
            return audio
        }else{
            return true
        }
    }
}


