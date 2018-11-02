//
//  SetUpDatabase.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 17/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation

/// Set up the database (at first launch)
class SetUpDatabase{
    
    /// Set up the database
    ///
    /// - Throws: an error if the query on the database throws one
    static func setUp() throws {
        if Database.shared.successfulConnection {
            try createTables()
            try insertInitialsData()
        }else{
            throw Database.shared.error!
        }
    }
    
    /// Create the table used in the app
    ///
    /// - Throws: an error if the query on the database throws one
    static private func createTables() throws {
        try DbUserLearningVerbDAOImpl.shared.createTable()
    }
    
    /// Insert some data in the table for the first user use
    ///
    /// - Throws: an error if the query on the database throws one
    static private func insertInitialsData() throws {
        let dbUserLearningVerbs = Verbs.verbs.map{ v in
            // TODO to put this one in real

            DbUserLearningVerb(id: 0, verbId: v.id,
                               dateToReview: nil,
                               knowledge: Knowledge._0_notSeenYet.rawValue)
        }
        _ = try DbUserLearningVerbDAOImpl.shared.insert(learningVerbs: dbUserLearningVerbs)
        _ = try DbUserLearningVerbDAOImpl.shared.addRandomVerbToReviewList(ofLevel: [Level.A2], nbr: 10)
    }

}
