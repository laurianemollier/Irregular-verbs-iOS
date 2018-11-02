//
//  VerbDAO.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 17/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation



/// Dao to access to the VerbTable
protocol VerbDAO{
    
    /// Find the verb of id `id`
    /// - Parameters:
    ///     - id: The id for the verb to find
    ///
    /// - Throws: an error if the query on the database throws one
    ///
    /// - Returns: The verb if found else nil
    func find(id: Int64) throws -> Verb?
    
}
