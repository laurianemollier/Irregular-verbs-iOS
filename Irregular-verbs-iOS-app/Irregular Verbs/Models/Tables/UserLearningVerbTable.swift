//
//  UserLearningVerbTable.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 17/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation
import SQLite

/// The SQLite table that store the user progression
class UserLearningVerbTable{
    
    static let learningVerbs = Table("userLearningVerbs")
    
    /// The id for the verb
    static let id = Expression<Int64>("id")
    
    /// The verb id that the user wants to review
    static let verbId = Expression<Int64>("verbId")
    
    /// The date at which the user has to review this verb
    static let dateToReview = Expression<Date?>("dateToReview")
    
    /// The knowledge of the user for this verb
    static let knowledge = Expression<String>("knowledge")
    
    static let createTable = UserLearningVerbTable.learningVerbs.create { (t) in
        t.column(UserLearningVerbTable.id, primaryKey: .autoincrement)
        t.column(UserLearningVerbTable.verbId)
        t.column(UserLearningVerbTable.dateToReview)
        t.column(UserLearningVerbTable.knowledge)
    }
}
