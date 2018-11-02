//
//  Verb.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 09/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

/// A verb to learn
class Verb{
    
    // ---------------------
    // MARK: - Public fields
    // ---------------------
    
    /// The id for the verb
    let id: Int64
    
    /// The level at which you are supposed to learn this verb.
    let level: Level
    
    /// The form to which the verb belongs.
    let form: Form
    
    // ----------------------
    // MARK: - Private fields
    // ----------------------
    
    /// The differents temps of this verb
    /// (infinitive, present, simple past, past participle)
    private let verb: (infinitive: String, present: String, simplePast: String, pastParticiple: String)
    
    private let changingVowel : (infinitive: NSRange, present: NSRange, simplePast: NSRange, pastParticiple: NSRange)
    
    /// The translation avalable in each language
    private var translations = [Lang:String]()
 
    /// If true, display the pronoun while conjugating the verb
    private var pronoun: Bool = false
    
    private let colorChangedVowel = UIColor.red
    

    // -----------------------
    // MARK: - Initialisations
    // -----------------------
    
    /// Create a verb to learn
    ///
    /// - Parameters:
    ///     - level: The level at which you are supposed to learn this verb.
    ///     - form: The form to which the verb belongs.
    ///     - verb: The differents temps of this verb (infinitive, present, simple past, past participle)
    ///     - changingVowel: The range where is located the changing vowel (infinitive, present, simple past, past participle)
    ///     - translations: The translation avalable in each language
    ///
    /// - Returns: A verb
    init(id: Int64, level: Level, form: Form,
         verb: (String, String, String, String),
         changingVowel: (NSRange, NSRange, NSRange, NSRange),
         translations: [(Lang, String)]){
        self.id = id + 1
        self.level = level
        self.form = form
        self.verb = verb
        self.changingVowel = changingVowel
        
        translations.forEach({
            self.translations[$0] = $1
        })
    }
    
    // ----------------------------------------
    // MARK: - Getter fonctions: UNcolored text
    // ----------------------------------------
    
    /// Get the infinitive form of this verb
    /// - Returns: The infinitive
    func infinitive() -> String {return verb.0}
    
    /// Get the present form of this verb
    /// - Returns: The present form
    func present() -> String {return formatConjugatedForm(verb.1)}
    
    /// Get the simple past of this verb
    /// - Returns: The simple past
    func simplePast() -> String {return formatConjugatedForm(verb.2)}
    
    /// Get the past participle of this verb
    /// - Returns: The past participle
    func pastParticiple() -> String {return formatConjugatedForm(verb.3)}
    
    /// Get the translation of this verb in the given language
    /// - Parameters:
    ///     - lang: The language in which the translation is done
    func translation(_ lang: Lang) -> String {return translations[lang]!}
    
    
    // -----------------------------------------
    // MARK: - Getter fonctions: colored text
    // -----------------------------------------
    
    /// Get the infinitive form of this verb but with the changing vowel colored
    /// - Parameters:
    ///     - font: The font to get the text in
    /// - Returns: The infinitive colored
    func infinitiveColored(font: UIFont) -> NSMutableAttributedString {
        
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        let attributedString = NSMutableAttributedString(string: self.verb.infinitive, attributes: attributes)
        
        // here you change the character to the color that you want
        attributedString.addAttribute(.foregroundColor, value: self.colorChangedVowel, range: self.changingVowel.infinitive)

        return attributedString
    }
    
    /// Get the present form of this verb but with the changing vowel colored
    /// - Parameters:
    ///     - font: The font to get the text in
    /// - Returns: The present colored
    func presentColored(font: UIFont) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: self.verb.present,
                                                         attributes: [.font: font])
        
        // here you change the character to the color that you want
        attributedString.addAttribute(.foregroundColor, value: self.colorChangedVowel, range: self.changingVowel.present)
        
        return attributedString
    }


    /// Get the simple past form of this verb but with the changing vowel colored
    /// - Parameters:
    ///     - font: The font to get the text in
    /// - Returns: The simple past colored
    func simplePastColored(font: UIFont) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: self.verb.simplePast,
                                                         attributes: [.font: font])
        
        // here you change the character to the color that you want
        attributedString.addAttribute(.foregroundColor, value: self.colorChangedVowel, range: self.changingVowel.simplePast)
        
        return attributedString
    }
    
    /// Get the past participle form of this verb but with the changing vowel colored
    /// - Parameters:
    ///     - font: The font to get the text in
    /// - Returns: The past participle colored
    func pastParticipleColored(font: UIFont) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: self.verb.pastParticiple,
                                                         attributes: [.font: font])
        
        // here you change the character to the color that you want
        attributedString.addAttribute(.foregroundColor, value: self.colorChangedVowel, range: self.changingVowel.pastParticiple)
        
        return attributedString
    }
    
    
    // -------------------------
    // MARK: - Private functions
    // -------------------------
    

    /// Helper function let or to delete the pronoun on the conjugated form
    private func formatConjugatedForm(_ verb:String) -> String {
        if pronoun { return "er " + verb}
        else{
             return verb
        }
    }

    
}






