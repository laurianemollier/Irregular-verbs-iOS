//
//  Localizator.swift
//  Irregular Verbs
//
//  Created by Lauriane Mollier on 03/11/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation
import UIKit





/// Allow to change the navigation language, and localize string that are not in the storybords
/// The navigation language is the language in which the app in written for the user
/// At each language change, a notification is send witht key `Localizator.kNotificationLanguageChanged`
class Localizator {
    
    //---------------------------
    // MARK: - Private properties
    //---------------------------
    
    /// The default language of the app if no proper language is found
    private let defaultLang = Conf.defaulfNavLang
    
    private let userDefaults = UserDefaults.standard
    
    /// Availlable navigation languages for this app
    private var availableLanguagesArray = Lang.allValues
    
    /// The diconary of key-values pairs in the navigation language selected
    private var dicoLocalization: NSDictionary!
    
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
    
    static let shared = Localizator()
    
    
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
    
    /// Return the translation of string of key `key` in the current navigation language depending of the number of element that we talk about
    ///
    /// ***** Example *****
    /// We want the translation of "`nbrOfElement` car(s)"
    ///
    /// In french, we have a form for 1 object, and an other for more than one:
    ///     - 1 voiture
    ///     - 2 voirures
    ///     - ... voitures
    ///
    /// In Russian, we have a form for numbers that ends with 1 (except 11), and an other for numbers that ends with 2, 3 or 4 (exept 12, 13, and 14), and a third form for the rest:
    ///     - 1 машина
    ///     - 2, 3 or 4 машины
    ///     - 5 машин
    ///
    /// To solve this problem, each traduction have a base key. In our exemple, it would be "%@ car(s)", and then for each language, the base key has a prefic to accord correcty to the number of element we talk about.
    ///
    /// For exemple, in French, we have the prefix "1 " (if there is one object) and ">1 " (if there is more than one object) for the 2 differents translation.
    /// The localization keys for french have then to be:
    ///     "1 %@ car(s)" if there is one object
    ///     ">1 %@ car(s)" if there is more than one object
    ///
    /// For Russian, we will have different keys:
    ///     "...1 %@ car(s)" for numbers that ends with 1 (except 11)
    ///     "...234 %@ car(s)" for numbers that ends with 2, 3 or 4 (exept 12, 13, and 14)
    ///     "...234 %@ car(s)" for the rest
    ///
    /// Those prefixes are fixed by LocalizedNumericalPrefixed
    ///
    /// *******************
    ///
    /// - SeeAlso: LocalizedNumericalPrefixed.localizedNumericalPrefixed(lang:, nbrOfElement:)
    /// - SeeAlso: Localizator.localized(_ string:) If the translation does to contain this number accord
    ///
    /// - Parameters:
    ///     - key: The key of the wanted traduction
    ///     - nbr: The number of element that the tranduction talk about
    ///
    /// - Returns: The traduction correct traduction for the number of elements
    func localized(_ string: String, nbrOfElement: Int) -> String{
        return localizedStringForKey(string)
    }
    
    /// Return the translation of string of key `key` in the current navigation language depending of the number of element that we talk about when they is 2 nouns to accord
    ///
    /// ***** Example *****
    /// We want the translation of "`nbrOfElement1` car(s) and `nbrOfElement2` dog(s)" defined as basic key as "%@ car(s) and %@ dog(s)"
    ///
    /// In french, we have a form for 1 object, and an other for more than one:
    ///     - 1 voiture et 1 chien
    ///     - 1 voiture et 2 chiens
    ///     - 2 voitures et 1 chien
    ///     - 2 voitures et 2 chiens
    ///
    /// For exemple, in French, we have the prefix "1 " (if there is one object) and ">1 " (if there is more than one object) for the 2 differents translation.
    /// The localization keys for french have then to be:
    ///     - "1 1 %@ car(s) and %@ dog(s)" for "1 voiture et 1 chien"
    ///     - "1 >1 %@ car(s) and %@ dog(s)" for "1 voiture et 2 chiens"
    ///     - ">1 1 %@ car(s) and %@ dog(s)" for "2 voitures et 1 chien"
    ///     - ">1 >1 %@ car(s) and %@ dog(s)" for "2 voitures et 2 chiens"
    ///
    /// So we need a prefix to define all this cases in the translation.
    ///
    /// Those prefixes are fixed by LocalizedNumericalPrefixed
    ///
    /// *******************
    ///
    /// - SeeAlso: LocalizedNumericalPrefixed.localizedNumericalPrefixed(lang:, nbrOfElement1:, nbrOfElement2:)
    /// - SeeAlso: Localizator.localized(_ string:, nbrOfElement2:) If the translation contains just one number accord
    /// - SeeAlso: Localizator.localized(_ string:) If the translation does to contain this number accord
    ///
    /// - Parameters:
    ///     - key: The key of the wanted traduction
    ///     - nbrOfElement1: The number of element that the first noun in the tranduction refer to
    ///     - nbrOfElement1: The number of element that the second noun in the tranduction refer to
    ///
    /// - Returns: The traduction correct traduction for the number of elements
    func localized(_ string: String, nbrOfElement1: Int, nbrOfElement2: Int) -> String{
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
            dicoLocalization = nil
            NotificationCenter.default.post(name: Notification.Name(rawValue: Localizator.kNotificationLanguageChanged), object: nil)
            return true
        }
        else if loadDictionaryForLanguage(newLanguage) {
            NotificationCenter.default.post(name: Notification.Name(rawValue: Localizator.kNotificationLanguageChanged), object: nil)
            
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
            dicoLocalization = NSDictionary(contentsOfFile: path!)
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
        if let dico = dicoLocalization {
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

