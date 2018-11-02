//
//  UserLearningVerb.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 15/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation
import AVFoundation


/// This class represent the user's learning data for this verb
///
/// Immutable class
class UserLearningVerb{
    
    /// The id (unique) in the database
    let id: Int64
    
    /// The verb that the user wants to review
    let verb: Verb
    
    /// The date at which the user has to review this verb
    let dateToReview: Date?
    
    /// The knowledge of the user for this verb
    let knowledge: Knowledge
    
    
    // -----------------------
    // MARK: - Initialisations
    // -----------------------
    
    
    /// Create a verb lerning process for this verb that is totally new for the user
    ///
    /// - Parameters:
    ///     - id: The id (unique) in the database
    ///     - verb: The verb that the user wants to review
    ///
    /// - Returns: A new UserLearningVerb that is new for the user too
    init(id: Int64, verb: Verb){
        self.id = id
        self.verb = verb
        self.dateToReview = Date()
        self.knowledge = Knowledge._1_inexistant
    }
    
    /// Create a verb lerning process for this verb that is already known by the user. (seen at least one time)
    ///
    /// - Parameters:
    ///     - id: The id (unique) in the database
    ///     - verb: The verb that the user wants to review
    ///     - dateToReview: The date at which the user has to review this verb
    ///     - knowledge: The knowledge of the user for this verb
    ///
    /// - Returns: A new UserLearningVerb that is new for the user too
    init(id: Int64, verb: Verb, dateToReview: Date?, knowledge: Knowledge){
        self.id = id
        self.verb = verb
        self.dateToReview = dateToReview
        self.knowledge = knowledge
    }
    

    // ------------------------
    // MARK: - Public functions
    // ------------------------
    
    /// Is this verb in the review list?
    /// - Returns: True if this verb is in the review list, else otherwise
    func isInReviewList() -> Bool{
        return self.knowledge.isInReviewList()
    }
    
    /// Upate this UserLearningVerb
    /// - Parameters:
    ///     - knowledge: The new knowledge of the user for this verb
    ///     - dateToReview: The next date, at wich he has to review this verb
    /// - Returns: A new UserLearningVerb updated
    func set(knowledge: Knowledge, dateToReview: Date) -> UserLearningVerb {
        return UserLearningVerb(id: self.id, verb: self.verb, dateToReview: dateToReview, knowledge: knowledge)
    }
    
    
    /// Tranform the current object to the DbUserLearningVerb
    /// - Returns: The DbUserLearningVerb form this UserLearningVerb
    func toDbUserLearningVerb() -> DbUserLearningVerb{
        return DbUserLearningVerb(id: self.id,
                                  verbId: self.verb.id,
                                  dateToReview: self.dateToReview,
                                  knowledge: self.knowledge.rawValue)
    }
}




