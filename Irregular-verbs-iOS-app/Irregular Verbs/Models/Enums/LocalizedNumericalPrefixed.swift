//
//  LocalizedNumericalPrefixed.swift
//  Irregular Verbs
//
//  Created by Lauriane Mollier on 09/11/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation


/// In a translation that depends of a number of object, each language has differents rules to accord nouns.
/// So for key-values pairs tranlation, we need a prefix in the `localizable.strings` files to accord correctly.
/// This class take care to define those prefixes
///
/// ***** Example *****
/// We want the translation of "`nbrOfElement` car"
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
/// To solve this problem, each traduction have a base kay. In our exemple, it would be "car", and then for each language, the base key has a prefic to accord correcty to the number of element we talk about.
///
/// For exemple, in French, we have the prefix "1 " (if there is one object) and ">1 " (if there is more than one object) for the 2 differents translation.
/// The localization keys for french have then to be:
///     "1 car" if there is one object
///     ">1 car" if there is more than one object
///
/// For Russian, we will have different keys:
///     "...1 car" for numbers that ends with 1 (except 11)
///     "...234 car" for numbers that ends with 2, 3 or 4 (exept 12, 13, and 14)
///     "...234 car" for the rest
///
/// Those prefixes are fixed by LocalizedNumericalPrefixed
///
/// *******************
///
/// - SeeAlso: LocalizedNumericalPrefixed.localizedNumericalPrefixed(string:, nbrOfElement:)
enum LocalizedNumericalPrefixed: String{
    
    case singular = "1 "
    case plurial = ">1 "
    case forRu1 = "...1 " // (Russian) for number of elements that ends with 1 (except 11)
    case forRu234 = "...234 " // (Russian) for number of elements that ends with 2, 3 or 4 (exept 12, 13, and 14)
    case forRu5 = "...>5 " // (Russian) for the rest of the possibilities
    
    /// Localized prefixed for the number of element of a traduction. Each language has its own system of according nouns. This function define a prefixe for each rules of a language, depending of the number of the object.
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
    /// This fonction define the prefix
    ///
    /// For exemple, in French, we have the prefix "1 " (if there is one object) and ">1 " (if there is more than one object) for the 2 differents prefixes.
    /// The prefixes for french have then to be:
    ///     "1 " if `nbrOfElement == 1`
    ///     ">1 " if `nbrOfElement > 1`
    ///
    /// For Russian, we will have different prefixes:
    ///     "...1 " for `nbrOfElement` that ends with 1 (except 11)
    ///     "...234 " for `nbrOfElement` that ends with 2, 3 or 4 (exept 12, 13, and 14)
    ///     "...234 " for the rest of the possibilities
    ///
    /// Those prefixes are fixed by LocalizedNumericalPrefixed
    ///
    /// *******************
    ///
    /// - SeeAlso: Locasisator.localized(_ string:, nbrOfElement:)
    ///
    /// - Parameters:
    ///     - lang: the langauge of the traduction
    ///     - nbrOfElement: The number of element that the tranduction talk about
    ///
    static func localizedNumericalPrefixed(lang: Lang, nbrOfElement: Int) -> String {

        switch lang{
        case Lang.ru:
            if isForRu1(nbrOfElement) {
                return LocalizedNumericalPrefixed.forRu1.rawValue
            } else if isForRu234(nbrOfElement) {
                return LocalizedNumericalPrefixed.forRu234.rawValue
            } else {
                return LocalizedNumericalPrefixed.forRu5.rawValue
            }

        default:
            if nbrOfElement == 1 {
                return LocalizedNumericalPrefixed.singular.rawValue
            } else {
                return LocalizedNumericalPrefixed.plurial.rawValue
            }
        }
    }
    
    
    /// Localized prefixed for the number of element of a traduction. Each language has its own system of according nouns. This function define a prefixe for each rules of a language, depending of the number of the object.
    ///
    /// This fonction is here to define the prefix of a language when there is 2 nouns that need to be accored.
    /// The prefix is in case the prefix of the first noun followed by the prefixe of the second noun
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
    /// This fonction define the prefix
    
    /// The prefixe would be:
    ///     - "1 1 " for `nbrOfElement1 == 1` and `nbrOfElement2 == 1`
    ///     - "1 >1 " for `nbrOfElement1 == 1` and `nbrOfElement2 > 1`
    ///     - ">1 1 " for `nbrOfElement1 > 1` and `nbrOfElement2 == 1`
    ///     - ">1 >1 " for `nbrOfElement1 > 1` and `nbrOfElement2 > 1`
    ///
    ///
    /// *******************
    ///
    /// - SeeAlso: LocalizedNumericalPrefixed.localizedNumericalPrefixed(lang:, nbrOfElement:)
    /// - SeeAlso: Localizator.localized(_ string:, nbrOfElement1:, nbrOfElement2:)
    ///
    /// - Parameters:
    ///     - lang: the langauge of the traduction
    ///     - nbrOfElement1: The number of element that the first noun in the tranduction refer to
    ///     - nbrOfElement1: The number of element that the second noun in the tranduction refer to
    ///
    /// - Returns: The traduction correct traduction for the number of elements
    static func localizedNumericalPrefixed(lang: Lang, nbrOfElement1: Int, nbrOfElement2: Int) -> String {
        let prefix1 = localizedNumericalPrefixed(lang: lang, nbrOfElement: nbrOfElement1)
        let prefix2 = localizedNumericalPrefixed(lang: lang, nbrOfElement: nbrOfElement2)
        
        return prefix1 + prefix2
    }
    
    
    // --------------------------------
    // MARK: - Private static fonctions
    // --------------------------------
    
    /// Retrun true if the rule `forRu1` can be applied to `nbrOfElement`
    ///
    /// - Parameters:
    ///     - nbrOfElement: The number of element to which the nouns should be accord
    ///
    /// - Returns: True if the rule `forRu1` can be applied to `nbrOfElement`
    private static func isForRu1(_ nbrOfElement: Int) -> Bool{
        if nbrOfElement == 11 {
            return false
        } else {
            let test: UInt = 0b00000001 & UInt(nbrOfElement)
            return test == UInt(1)
        }
    }
    
    /// Retrun true if the rule `forRu234` can be applied to `nbrOfElement`
    ///
    /// - Parameters:
    ///     - nbrOfElement: The number of element to which the nouns should be accord
    ///
    /// - Returns: True if the rule `forRu234` can be applied to `nbrOfElement`
    private static func isForRu234(_ nbrOfElement: Int) -> Bool{
        if nbrOfElement == 12 || nbrOfElement == 13 || nbrOfElement == 14 {
            return false
        } else {
            let endBy2: Bool = (0b00000010 & UInt(nbrOfElement))  == UInt(2)
            let endBy3: Bool = (0b00000011 & UInt(nbrOfElement))  == UInt(3)
            let endBy4: Bool = (0b000000100 & UInt(nbrOfElement))  == UInt(4)
            return endBy2 || endBy3 || endBy4
        }
    }
    
}
