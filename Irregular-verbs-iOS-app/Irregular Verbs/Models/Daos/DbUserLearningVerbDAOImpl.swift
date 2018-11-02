//
//  DbVerbTranslationDAOImpl.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 17/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation
import SQLite

/// Dao to access to the UserLearningVerbTable
///
/// Singleton pattern
class DbUserLearningVerbDAOImpl: DbUserLearningVerbDAO{
    
    let db: Connection
    
    private init(connection: Connection){
        self.db = connection
    }
    
    static let shared = DbUserLearningVerbDAOImpl(connection: Database.shared.connection!)
    
    
    /// Create the `UserLearningVerbTable` table
    ///
    /// - Throws: an error if the query on the database throws one
    func createTable() throws {
        SpeedLog.print("Create VerbTranslationTable...")
        try self.db.run(UserLearningVerbTable.createTable)
        SpeedLog.print("VerbTranslationTable created")
    }
    
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
    func insert(learningVerb: DbUserLearningVerb) throws -> DbUserLearningVerb{
        SpeedLog.print("Insert DbUserLearningVerb ...")
        let insert = UserLearningVerbTable.learningVerbs.insert(
            UserLearningVerbTable.verbId <- learningVerb.verbId,
            UserLearningVerbTable.dateToReview <- learningVerb.dateToReview,
            UserLearningVerbTable.knowledge <- learningVerb.knowledge)
        
        let id: Int64 = try db.run(insert)
        SpeedLog.print("DbUserLearningVerb inserted ")
        return DbUserLearningVerb(id: id,
                                  verbId: learningVerb.verbId,
                                  dateToReview: learningVerb.dateToReview,
                                  knowledge: learningVerb.knowledge)
    }
    
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
    func insert(learningVerbs: [DbUserLearningVerb]) throws -> [DbUserLearningVerb]{
        return try learningVerbs.map({ v in try insert(learningVerb: v)})
    }
    
    
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
    func update(learningVerb: DbUserLearningVerb) throws -> Int{
        let table: Table = UserLearningVerbTable.learningVerbs.where(UserLearningVerbTable.id == learningVerb.id)
        let update: Update = table.update(UserLearningVerbTable.verbId <- learningVerb.id,
                                          UserLearningVerbTable.dateToReview <- learningVerb.dateToReview,
                                          UserLearningVerbTable.knowledge <- learningVerb.knowledge)
        return try db.run(update)
    }
    
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
    func update(learningVerbs: [DbUserLearningVerb]) throws -> [Int]{
        return try learningVerbs.map({ v in try update(learningVerb: v)})
    }
    
    
    /// Add `nbr` verbs to the review list. Those verbs are randomly choosen but belongs to one of a level passed in `ofLevel`
    ///
    /// - Parameters:
    ///     - ofLevel: The verb level that you want to add in the list
    ///     - nbr: The number of verb that you want to add in the list
    ///
    /// - Throws: an error if the query on the database throws one
    func addRandomVerbToReviewList(ofLevel: [Level], nbr: Int) throws {
        
        // TODO: to make it more effective in one query, because now it is horrible!
        let q = UserLearningVerbTable.learningVerbs
            .filter(UserLearningVerbTable.knowledge == Knowledge._0_notSeenYet.rawValue)
        
        
        let learningVerbs: [UserLearningVerb] = try db.prepare(q).map{ row in
            try toUserLearningVerb(userLVTableRow: row)
            }.filter({ofLevel.contains($0.verb.level)})
        
        let selected = learningVerbs.choose(nbr)
        for verb in selected{
            let updated = verb.set(knowledge: Knowledge._1_inexistant, dateToReview: Date())
            _ = try update(learningVerb: updated.toDbUserLearningVerb())
        }
    }
    
    
    
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
    func find(verbId: Int64) throws -> UserLearningVerb? {
        
        let q = UserLearningVerbTable.learningVerbs.where(UserLearningVerbTable.verbId == verbId)
        
        if let row = try db.pluck(q) {
            return try toUserLearningVerb(userLVTableRow: row)
        } else {
            return nil
        }
    }
    
    /// Get all `UserLearningVerb` contained in the table
    ///
    /// - Throws: an error if the query on the database throws one
    ///
    /// - Returns: The array of all `UserLearningVerb` contained in the table
    func all() throws -> [UserLearningVerb]{
        let rows = try db.prepare(UserLearningVerbTable.learningVerbs)
        return try rows.map({ row in
            try toUserLearningVerb(userLVTableRow: row)
        })
    }
    
    /// Select all `UserLearningVerb` of knowledge `knowledge` contained in the table
    ///
    /// - Parameters:
    ///     - knowledge: The knowledge of the verbs
    ///
    /// - Throws: an error if the query on the database throws one
    ///
    /// - Returns: all `UserLearningVerb` of knowledge `knowledge` contained in the table
    func select(knowledge: Knowledge) throws -> [UserLearningVerb] {
        let rows = try db.prepare(UserLearningVerbTable.learningVerbs
            .filter(UserLearningVerbTable.knowledge == knowledge.rawValue))
        return try rows.map({ row in
            try toUserLearningVerb(userLVTableRow: row)
        })
        
    }
    
    
    /// --------------------------------
    /// MARK: - Verb to review functions
    /// --------------------------------
    
    /// The number of verb that the user has to review today
    ///
    /// - Throws: an error if the query on the database throws one
    ///
    /// - Returns: The number of verb that the user has to review today
    func nbrVerbToReviewToday() throws -> Int{
        let today = Date()
        return try nbrVerbToReview(on: today)
    }
    
    /// The number of verb that the user has to review on the date `on`
    ///
    /// - Parameters:
    ///     - on: The date
    ///
    /// - Throws: an error if the query on the database throws one
    ///
    /// - Returns: The number of verb that the user has to review on this date
    func nbrVerbToReview(on: Date) throws -> Int{
        let verbs = UserLearningVerbTable.learningVerbs
            .filter(UserLearningVerbTable.dateToReview <= on)
        return try db.scalar(verbs.count)
    }
    
    /// The number of verb in the review list
    ///
    /// - Throws: an error if the query on the database throws one
    ///
    /// - Returns: The number of verb in the review list
    func nbrVerbInReviewList() throws -> Int {
        let verbs = UserLearningVerbTable.learningVerbs
            .filter(UserLearningVerbTable.knowledge != Knowledge._0_notSeenYet.rawValue)
        return try db.scalar(verbs.count)
    }
    
    /// The number of verb NOT in the review list
    ///
    /// - Throws: an error if the query on the database throws one
    ///
    /// - Returns: The number of verb NOT in the review list
    func nbrVerNotbInReviewList() throws -> Int {
        let verbs = UserLearningVerbTable.learningVerbs
            .filter(UserLearningVerbTable.knowledge == Knowledge._0_notSeenYet.rawValue)
        return try db.scalar(verbs.count)
    }
    
    
    /// The verb that the user has to review today
    ///
    /// - Parameters:
    ///     - limit: The limit of verb to get. (ex: get 10 `UserLearningVerb`) If set to nil, the query will not have a limit of rows, it will returns all the verbs to review today
    ///
    /// - Throws: an error if the query on the database throws one
    ///
    /// - Returns: The `UserLearningVerb` that the user has to review today
    func verbsToReviewToday(limit: Int?) throws -> [UserLearningVerb]{
        let today = Date()
        return try verbsToReview(on: today, limit: limit)
    }
    
    /// The verb that the user has to review on the date `on`
    ///
    /// - Parameters:
    ///     - limit: The limit of verb to get. (ex: get 10 `UserLearningVerb`) If set to nil, the query will not have a limit of rows, it will returns all the verbs to review today
    ///     - on: The date
    ///
    /// - Throws: an error if the query on the database throws one
    ///
    /// - Returns: The `UserLearningVerb` that the user has to review on the date `on`
    func verbsToReview(on: Date, limit: Int?) throws -> [UserLearningVerb]{
        let q_filter = UserLearningVerbTable.learningVerbs.filter(UserLearningVerbTable.dateToReview <= on)
        let q = toLimitedQuery(query: q_filter, limit: limit)
        
        return try db.prepare(q).map{ row in
            try toUserLearningVerb(userLVTableRow: row)
        }
    }
    
    
    // -------------------------
    // MARK: - Private functions
    // -------------------------
    

    /// Helper function to limit the query
    ///
    /// - Parameters:
    ///     - query: The query to limit to
    ///     - limit: The number of row to return. If null, return the table without limit
    ///
    /// - Returns: The table limited by `limit`
    private func toLimitedQuery(query: Table, limit: Int?) -> Table{
        if let l = limit{
            return query.limit(l)
        }
        else {return query}
    }
    
    /// Transforms a UserLearningVerbTable's row to UserLearningVerb.
    /// We assume that the datebase is constistant, and that for each UserLearningVerbTable's row exist an unit Verb.
    /// - Parameters:
    ///     - row: A UserLearningVerbTable's row
    /// - Returns: The UserLearningVerb that is associated with this row
    private func toUserLearningVerb(userLVTableRow: Row) throws -> UserLearningVerb{
        let id = userLVTableRow[UserLearningVerbTable.id]
        let verb: Verb = try VerbDAOImpl.shared.find(id: userLVTableRow[UserLearningVerbTable.verbId])!
        let knowledge = Knowledge(rawValue: userLVTableRow[UserLearningVerbTable.knowledge])!
        let dateToReview = userLVTableRow[UserLearningVerbTable.dateToReview]
        
        return UserLearningVerb(id: id, verb: verb, dateToReview: dateToReview, knowledge: knowledge)
    }
    
}
