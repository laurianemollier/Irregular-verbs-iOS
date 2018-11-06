//
//  Localisator.swift
//  Irregular Verbs
//
//  Created by Lauriane Mollier on 03/11/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation
import UIKit





/// Allow to change the navigation language, and localize string that are not in the storybords
/// The navigation language is the language in which the app in written for the user
/// At each language change, a notification is send witht key `Localisator.kNotificationLanguageChanged`
class Localisator {
    
    //---------------------------
    // MARK: - Private properties
    //---------------------------
    
    /// The default language of the app if no proper language is found
    private let defaultLang = Conf.defaulfNavLang
    
    private let userDefaults = UserDefaults.standard
    
    /// Availlable navigation languages for this app
    private var availableLanguagesArray = Lang.allValues
    
    /// The diconary of key-values pairs in the navigation language selected
    private var dicoLocalisation: NSDictionary!
    
    /// The key to store the wanted navigation language.
    private let key = AppInfos.appId + "navigationLang"
    
    /// The current navigation language. i.e his mother tong
    private var currentNavigationLang: Lang  = Lang.DeviceLanguage
    

    //--------------------------
    // MARK: - Static properties
    //--------------------------
    
    /// At each language change, a notification is send with this key
    static let kNotificationLanguageChanged: String = "kNotificationLanguageChanged";
    
    
    // ------------------------
    // MARK: - Singleton method
    // ------------------------
    
    static let shared = Localisator()
    
    
    // -------------------
    // MARK: - Init method
    // -------------------
    
    /// Set the default navigation language from the setting of the phone
    init() {
        SpeedLog.print(NSLocale.current.languageCode!)
        SpeedLog.print(NSLocale.preferredLanguages)
        if let languageSaved = userDefaults.object(forKey: key) as? String {
            if languageSaved != "DeviceLanguage" {
                let l = Lang(rawValue: languageSaved)!
                _ = self.loadDictionaryForLanguage(l)
                currentNavigationLang = l
            }
        }
        else if let defaultLang = Lang(rawValue: NSLocale.current.languageCode!){
            currentNavigationLang = defaultLang
        }
        else if let defaultLang = Lang(rawValue: NSLocale.preferredLanguages.first ?? "error"){
            currentNavigationLang = defaultLang
        }
        else{
            currentNavigationLang = defaultLang
        }
    }
    
    // ------------------------
    // MARK: - Public functions
    // -------------------------
    
    /// Return the tranduction of string of key `key` in the current navigation language
    ///
    /// - Parameters:
    ///     - key: The key of the wanted traduction
    ///
    /// - Returns: The traduction
    func localized(_ string: String) -> String{
        return localizedStringForKey(string)
    }
    
    /// Set the new navigation language to `newLanguage`
    ///
    /// - Parameters:
    ///     - newLanguage: The new language to be set
    ///
    /// - Returns: True is the langauge has be correctly set/
    func setNavigationLanguage(_ newLanguage: Lang) -> Bool {
        if (newLanguage == currentNavigationLang) || !availableLanguagesArray.contains(newLanguage) {
            return false
        }
        else if (newLanguage == Lang.DeviceLanguage) {
            currentNavigationLang = newLanguage
            dicoLocalisation = nil
            NotificationCenter.default.post(name: Notification.Name(rawValue: Localisator.kNotificationLanguageChanged), object: nil)
            return true
        }
        else if loadDictionaryForLanguage(newLanguage) {
            NotificationCenter.default.post(name: Notification.Name(rawValue: Localisator.kNotificationLanguageChanged), object: nil)
            
            userDefaults.setValue(newLanguage.rawValue, forKey: key)
            userDefaults.synchronize()
            return true
        }
        else {
            return false
        }
    }
    
    /// Get the current navigation language
    ///
    /// - Returns: The current navigation language
    func getNavigationLanguage() -> Lang {
        return currentNavigationLang
    }
    
    /// The array of available navigation language of this app
    ///
    /// - Returns: All the possible navigation laguages
    func getArrayAvailableLanguages() -> [Lang] {
        return availableLanguagesArray
    }
    
    
    // -------------------------
    // MARK: - Private functions
    // -------------------------
    
    
    /// Load the new dictionnary for the new language wanted
    ///
    /// - Parameters:
    ///     - newLanguage: The new language
    ///
    /// - Returns: True if succeeded
    private func loadDictionaryForLanguage(_ newLanguage: Lang) -> Bool {
        let path = Bundle(for:object_getClass(self)!).url(forResource: "Localizable", withExtension: "strings", subdirectory: nil, localization: newLanguage.rawValue)?.path
        
        if ((path != nil) && FileManager.default.fileExists(atPath: path!)) {
            currentNavigationLang = newLanguage
            dicoLocalisation = NSDictionary(contentsOfFile: path!)
            return true
        }
        else{
            return false
        }
    }
    
    
    /// Return the tranduction of string of key `key` in the current navigation language
    ///
    /// - Parameters:
    ///     - key: The key of the wanted traduction
    ///
    /// - Returns: The traduction
    private func localizedStringForKey(_ key: String) -> String {
        if let dico = dicoLocalisation {
            if let localizedString = dico[key] as? String {
                return localizedString
            }  else {
                return key
            }
        } else {
            return NSLocalizedString(key, comment: key)
        }
    }
    
    
}

