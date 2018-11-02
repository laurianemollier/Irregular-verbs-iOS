//
//  Knowledge.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 14/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation
import UIKit


/// The user knowlegde for a verb
///
/// Here is what happens with the knowlegde for a verb:
///
/// When the user has never seen this verb, then the knowledge "_0_notSeenYet" is associated to it
/// But as soon as the user starts to learn this verb, the knowlege associated is one beetween 1 and 8.
///     ex: "_1_inexistant" for not  knowing the verb at all, but to want to learn it (ie. in the review list)
///         "_3_poor" if the user know poorly a verb, etc...
///         "toIgnore" if the user wants to ignore this verb.
enum Knowledge: String {
    
    case _0_notSeenYet = "notSeenYet"
    case _1_inexistant = "inexistant"
    case _2_veryPoor = "veryPoor"
    case _3_poor = "poor"
    case _4_quiteGood = "quiteGood"
    case _5_good = "good"
    case _6_veryGood = "veryGood"
    case _7_excelent = "excelent"
    case _8_optimal = "optimal"
    case toIgnore = "toIgnore"
    
    /// All knowlegde
    static let allValues = [_0_notSeenYet, _1_inexistant, _2_veryPoor , _3_poor, _4_quiteGood, _5_good, _6_veryGood, _7_excelent, _8_optimal, toIgnore]
    
    // -------------------------
    // MARK: - Publics functions
    // -------------------------
    
    /// Does it means - regarding this level of knowlege of the user about one verb - that this verb is in the review list?
    /// - Returns: True if this knowlege shows that the verb to wich he belongs too is in the review list
    func isInReviewList() -> Bool{
        return !self.isNotInReviewList()
    }
    
    /// Does it means - regarding this level of knowlege of the user about one verb - that this verb is in the review list?
    /// - Returns: True if this knowlege shows that the verb to wich he belongs too is NOT in the review list
    func isNotInReviewList() -> Bool{
        return self == Knowledge._0_notSeenYet || self == Knowledge._0_notSeenYet
    }
    
    
    // --------------------------------------------
    // MARK: - Associate each Knowlege with a value
    // --------------------------------------------
    
    /// Assiociate this Knowlege to an image
    /// - Returns: if the knowlege belongs to a verb in the review list: A face (smailey) traducing this Knonledge
    ///            else return nil
    func image() -> UIImage? {
        switch self { // TODO
        case Knowledge._1_inexistant:
            return #imageLiteral(resourceName: "UP Verypoor")
        case Knowledge._2_veryPoor:
            return #imageLiteral(resourceName: "UP Poor")
        case Knowledge._3_poor:
            return #imageLiteral(resourceName: "UP Good")
        case Knowledge._4_quiteGood:
            return #imageLiteral(resourceName: "UP Very Good")
        case Knowledge._5_good:
            return #imageLiteral(resourceName: "UP Excelent")
        case Knowledge._6_veryGood:
            return #imageLiteral(resourceName: "UP Excelent")
        case Knowledge._7_excelent:
            return #imageLiteral(resourceName: "UP Superb")
        case Knowledge._8_optimal:
            return #imageLiteral(resourceName: "UP Fantastic")
        default:
            return nil
        }
        
    }
    
    /// Assiociate this Knowlege to a name in the language "lang"
    /// - Parameters:
    ///     - lang: the language in witch we wants the name of this knowledge
    func name(lang: Lang) -> String {
        switch self { // TODO
        case Knowledge._1_inexistant:
            return "Inexistant"
        case Knowledge._2_veryPoor:
            return "Très faible"
        case Knowledge._3_poor:
            return "Faible"
        case Knowledge._4_quiteGood:
            return "Assez bien"
        case Knowledge._5_good:
            return "Bien"
        case Knowledge._6_veryGood:
            return "Très bien"
        case Knowledge._7_excelent:
            return "Excelent"
        case Knowledge._8_optimal:
            return "Optimal"
        case Knowledge._0_notSeenYet:
            return "Pas encore revu(s)"
        case Knowledge.toIgnore:
            return "À ignorer"
        }
    }
    

    // ------------------------------------------------
    // MARK: - Navigation between the progression level
    // ------------------------------------------------
    
    /// Give the information about the new level and the date to review a verb, when the user
    /// regress in the knowlege of this verb
    ///
    /// - Parameters:
    ///   - reviewedDate: The date one wich a verb has been reviewed
    ///
    /// - Returns:
    ///   - newProgression: The new progression level at wich the user is, if he regress of one level
    ///   - dateToReview: The new date at witch the verb has to be reviewed
    func regression(reviewedDate: Date) -> (newProgression: Knowledge, dateToReview: Date)? {
        return (Knowledge._1_inexistant, reviewedDate)
    }
    
    /// Give the information about the new level and the date to review a verb, when the user
    /// stags in the knowlege of this verb
    ///
    /// - Parameters:
    ///   - reviewedDate: The date one wich a verb has been reviewed
    ///
    /// - Returns:
    ///   - newProgression: The new progression level at wich the user is, if he stags of one level
    ///   - dateToReview: The new date at witch the verb has to be reviewed
    func stagnation(reviewedDate: Date) -> (newProgression: Knowledge, dateToReview: Date)?{
        switch self {
        case Knowledge._1_inexistant:
            let newDate = Date(timeInterval: TimeInterval(1 * Constants.secondsInOneDay), since: Date())
            return (Knowledge._1_inexistant, newDate)
        case Knowledge._2_veryPoor:
            let newDate = Date(timeInterval: TimeInterval(2 * Constants.secondsInOneDay), since: Date())
            return (Knowledge._2_veryPoor, newDate)
            
        case Knowledge._3_poor:
            let newDate = Date(timeInterval: TimeInterval(3 * Constants.secondsInOneDay), since: Date())
            return (Knowledge._3_poor, newDate)
            
        case Knowledge._4_quiteGood:
            let newDate = Date(timeInterval: TimeInterval(5 * Constants.secondsInOneDay), since: Date())
            return (Knowledge._4_quiteGood, newDate)
            
        case Knowledge._5_good:
            let newDate = Date(timeInterval: TimeInterval(7 * Constants.secondsInOneDay), since: Date())
            return (Knowledge._5_good, newDate)
            
        case Knowledge._6_veryGood:
            let newDate = Date(timeInterval: TimeInterval(14 * Constants.secondsInOneDay), since: Date())
            return (Knowledge._6_veryGood, newDate)
            
        case Knowledge._7_excelent:
            let newDate = Date(timeInterval: TimeInterval(30 * Constants.secondsInOneDay), since: Date())
            return (Knowledge._7_excelent, newDate)
            
        case Knowledge._8_optimal:
            let newDate = Date(timeInterval: TimeInterval(90 * Constants.secondsInOneDay), since: Date())
            return (Knowledge._8_optimal, newDate)
            
        default:
            return nil
        }
    }
    
    /// Give the information about the new level and the date to review a verb, when the user
    /// progress in the knowlege of this verb
    ///
    /// - Parameters:
    ///   - reviewedDate: The date one wich a verb has been reviewed
    ///
    /// - Returns:
    ///   - newProgression: The new progression level at wich the user is, if he progress of one level
    ///   - dateToReview: The new date at witch the verb has to be reviewed
    func progression(reviewedDate: Date) -> (newProgression: Knowledge, dateToReview: Date)? {
        switch self {
        case Knowledge._1_inexistant:
            let newDate = Date(timeInterval: TimeInterval(2 * Constants.secondsInOneDay), since: Date())
            return (Knowledge._2_veryPoor, newDate)
            
        case Knowledge._2_veryPoor:
            let newDate = Date(timeInterval: TimeInterval(3 * Constants.secondsInOneDay), since: Date())
            return (Knowledge._3_poor, newDate)
            
        case Knowledge._3_poor:
            let newDate = Date(timeInterval: TimeInterval(5 * Constants.secondsInOneDay), since: Date())
            return (Knowledge._4_quiteGood, newDate)
            
        case Knowledge._4_quiteGood:
            let newDate = Date(timeInterval: TimeInterval(7 * Constants.secondsInOneDay), since: Date())
            return (Knowledge._5_good, newDate)
            
        case Knowledge._5_good:
            let newDate = Date(timeInterval: TimeInterval(14 * Constants.secondsInOneDay), since: Date())
            return (Knowledge._6_veryGood, newDate)
            
        case Knowledge._6_veryGood:
            let newDate = Date(timeInterval: TimeInterval(30 * Constants.secondsInOneDay), since: Date())
            return (Knowledge._7_excelent, newDate)
            
        case Knowledge._7_excelent:
            let newDate = Date(timeInterval: TimeInterval(90 * Constants.secondsInOneDay), since: Date())
            return (Knowledge._8_optimal, newDate)
        case Knowledge._8_optimal:
            let newDate = Date(timeInterval: TimeInterval(365 * Constants.secondsInOneDay), since: Date())
            return (Knowledge._8_optimal, newDate)
            
        default:
            return nil
        }
    }
    
    
    // --------------------------------------------------------
    // MARK: - Name of navigation between the progression level
    // --------------------------------------------------------
    
    /// The name of the regress action
    /// - Parameters:
    ///     - lang: the language in witch we wants the name of this knowledge
    func regressionName(lang: Lang) -> String? {
        return "Maintenant" // TODO
    }
    
    
    /// The name of the stag action
    /// - Parameters:
    ///     - lang: the language in witch we wants the name of this knowledge
    func stagnationName(lang: Lang) -> String?{
        switch self { // TODO
        case Knowledge._1_inexistant:
            return "Demain"
        case Knowledge._2_veryPoor:
            return "Dans 2 jours"
        case Knowledge._3_poor:
            return "Dans 3 jours"
        case Knowledge._4_quiteGood:
            return "Dans 5 jours"
        case Knowledge._5_good:
            return "Dans 1 semaine"
        case Knowledge._6_veryGood:
            return "Dans 2 semaines"
        case Knowledge._7_excelent:
            return "Dans 1 mois"
        case Knowledge._8_optimal:
            return "Dans 3 mois"
            
        default:
            return nil
        }
    }
    
    /// The name of the progress action
    /// - Parameters:
    ///     - lang: the language in witch we wants the name of this knowledge
    func progressionName(lang: Lang) -> String? {
        switch self { // TODO
        case Knowledge._1_inexistant:
            return "Dans 2 jours"
        case Knowledge._2_veryPoor:
            return "Dans 3 jours"
        case Knowledge._3_poor:
            return "Dans 5 jours"
        case Knowledge._4_quiteGood:
            return "Dans 1 semaine"
        case Knowledge._5_good:
            return "Dans 2 semaines"
        case Knowledge._6_veryGood:
            return "Dans 1 mois"
        case Knowledge._7_excelent:
            return "Dans 1 mois"
        case Knowledge._8_optimal:
            return "Dans 1 an"
            
        default:
            return nil
        }
    }

}
