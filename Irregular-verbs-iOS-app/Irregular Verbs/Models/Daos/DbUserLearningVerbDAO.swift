//
//  DbUserLearningVerbDAO.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 17/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation

/// Dao to access to the UserLearningVerbTable
protocol DbUserLearningVerbDAO {
    /// Create the `UserLearningVerbTable` table
    ///
    /// - Throws: an error if the query on the database throws one
    func createTable() throws
    
    // ------------------------
    // MARK: - Insert functions
    // ------------------------
    
    /// Insert a new `DbUserLearningVerb` in the Table
    /// - Parameters:
    ///     - learningVerb: The verb that you want to insert. The id of this object will not be taken into account. The id placed in the table will be determine in the insertion
    ///
    /// - Throws: an error if the query on the database throws one
    ///
    /// - Returns: the `DbUserLearningVerb` insert in the table. With all the parameter passed in `learningVerb` and with the correct id
    func insert(learningVerb: DbUserLearningVerb) throws -> DbUserLearningVerb
    
    /// Insert a list of `DbUserLearningVerb` in the Table
    ///
    /// - SeeAlso: DbUserLearningVerbDAOImpl.insert(learningVerb:)
    ///
    /// - Parameters:
    ///     - learningVerb: The verb that you want to insert. The id of this object will not be taken into account. The id placed in the table will be determine in the insertion
    ///
    /// - Throws: an error if the query on the database throws one
    ///
    /// - Returns: the `DbUserLearningVerb` insert in the table. With all the parameter passed in `learningVerb` and with the correct id
    func insert(learningVerbs: [DbUserLearningVerb]) throws -> [DbUserLearningVerb]
    
    
    // ------------------------
    // MARK: - Update functions
    // ------------------------
    
    /// Update the `learningVerb` of id `learningVerb.id` to the arguments in `learningVerb`
    ///
    /// - Parameters:
    ///     - learningVerb: The learningVerb to update
    ///
    /// - Throws: an error if the query on the database throws one
    ///
    /// - Returns: If retrun value <= 0, the learningVer was not found
    ///            Else if the retrun value is > 0, the update was correctly done
    func update(learningVerb: DbUserLearningVerb) throws -> Int
    
    
    /// Update a list of `DbUserLearningVerb` of ids `learningVerb.id` to arguments in contained in each `learningVerb`
    ///
    /// - SeeAlso: DbUserLearningVerbDAOImpl.update(learningVerbs:)
    ///
    /// - Parameters:
    ///     - learningVerbs: The learningVerbs to update
    ///
    /// - Throws: an error if the query on the database throws one
    ///
    /// - Returns: An array of each learning verb update status.
    ///            If retrun value <= 0, the learningVer was not found
    ///            Else if the retrun value is > 0, the update was correctly done
    func update(learningVerbs: [DbUserLearningVerb]) throws -> [Int]
    
    
    /// Add `nbr` verbs to the review list. Those verbs are randomly choosen but belongs to one of a level passed in `ofLevel`
    ///
    /// - Parameters:
    ///     - ofLevel: The verb level that you want to add in the list
    ///     - nbr: The number of verb that you want to add in the list
    ///
    /// - Throws: an error if the query on the database throws one
    func addRandomVerbToReviewList(ofLevel: [Level], nbr: Int) throws
    
    
    
    // --------------------------------------
    // MARK: - Find, all and select functions
    // --------------------------------------
    
    /// Find the `UserLearningVerb` of id `verbId`
    ///
    /// - Parameters:
    ///     - verbId: The id of the UserLearningVerb to find
    ///
    /// - Throws: an error if the query on the database throws one
    ///
    /// - Returns: The `UserLearningVerb` if found else nil
    func find(verbId: Int64) throws -> UserLearningVerb?
    
    
    /// Get all `UserLearningVerb` contained in the table
    ///
    /// - Throws: an error if the query on the database throws one
    ///
    /// - Returns: The array of all `UserLearningVerb` contained in the table
    func all() throws -> [UserLearningVerb]
    
    
    /// Select all `UserLearningVerb` of knowledge `knowledge` contained in the table
    ///
    /// - Parameters:
    ///     - knowledge: The knowledge of the verbs
    ///
    /// - Throws: an error if the query on the database throws one
    ///
    /// - Returns: all `UserLearningVerb` of knowledge `knowledge` contained in the table
    func select(knowledge: Knowledge) throws -> [UserLearningVerb]
    
    
    /// --------------------------------
    /// MARK: - Verb to review functions
    /// --------------------------------
    
    /// The number of verb that the user has to review today
    ///
    /// - Throws: an error if the query on the database throws one
    ///
    /// - Returns: The number of verb that the user has to review today
    func nbrVerbToReviewToday() throws -> Int
    
    
    /// The number of verb that the user has to review on the date `on`
    ///
    /// - Parameters:
    ///     - on: The date
    ///
    /// - Throws: an error if the query on the database throws one
    ///
    /// - Returns: The number of verb that the user has to review on this date
    func nbrVerbToReview(on: Date) throws -> Int
    
    
    /// The number of verb in the review list
    ///
    /// - Throws: an error if the query on the database throws one
    ///
    /// - Returns: The number of verb in the review list
    func nbrVerbInReviewList() throws -> Int
    
    
    /// The number of verb NOT in the review list
    ///
    /// - Throws: an error if the query on the database throws one
    ///
    /// - Returns: The number of verb NOT in the review list
    func nbrVerNotbInReviewList() throws -> Int
    
    
    /// The verb that the user has to review today
    ///
    /// - Parameters:
    ///     - limit: The limit of verb to get. (ex: get 10 `UserLearningVerb`) If set to nil, the query will not have a limit of rows, it will returns all the verbs to review today
    ///
    /// - Throws: an error if the query on the database throws one
    ///
    /// - Returns: The `UserLearningVerb` that the user has to review today
    func verbsToReviewToday(limit: Int?) throws -> [UserLearningVerb]
    
    
    /// The verb that the user has to review on the date `on`
    ///
    /// - Parameters:
    ///     - limit: The limit of verb to get. (ex: get 10 `UserLearningVerb`) If set to nil, the query will not have a limit of rows, it will returns all the verbs to review today
    ///     - on: The date
    ///
    /// - Throws: an error if the query on the database throws one
    ///
    /// - Returns: The `UserLearningVerb` that the user has to review on the date `on`
    func verbsToReview(on: Date, limit: Int?) throws -> [UserLearningVerb]
    
    
 
}




