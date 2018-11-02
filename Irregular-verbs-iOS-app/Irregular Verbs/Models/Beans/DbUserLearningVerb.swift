//
//  DbUserLearningVerb.swift
//  Irregular Verbs
//
//  Created by Lauriane Mollier on 28/10/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation

// Beans to connect represent to databse data of an `UserLearningVerb`
class DbUserLearningVerb{
    
    /// The id (unique) in the database
    let id: Int64
    
    /// The verb id that the user wants to review
    let verbId: Int64
    
    /// The date at which the user has to review this verb
    let dateToReview: Date?
    
    /// The knowledge of the user for this verb
    let knowledge: String
    
    
    init(id: Int64, verbId: Int64, dateToReview: Date?, knowledge: String){
        self.id = id
        self.verbId = verbId
        self.dateToReview = dateToReview
        self.knowledge = knowledge
    }
    
}
