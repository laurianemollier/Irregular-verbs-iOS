//
//  VerbDAOImpl.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 17/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation
import SQLite

/// Dao to access to the VerbTable
///
/// Singleton pattern
class VerbDAOImpl: VerbDAO{
    
    let db: Connection
    
    private init(connection: Connection){
        self.db = connection
    }
    
    static let shared = VerbDAOImpl(connection: Database.shared.connection!)
    

    /// Find the verb of id `id`
    /// - Parameters:
    ///     - id: The id for the verb to find
    ///
    /// - Throws: an error if the query on the database throws one
    ///
    /// - Returns: The verb if found else nil
    func find(id: Int64) throws -> Verb?{
        return Verbs.verbs.first(where: {$0.id == id})
    }
  
}


