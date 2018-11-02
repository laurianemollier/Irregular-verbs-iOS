//
//  Database.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 16/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation
import SQLite


/// Singleton to access to the local database
///
/// ***** Example *****
/// Access to the connection objet of the database this way:
///    if Database.shared.successfulConnection{
///       Database.shared.connection
///    }
///    else{
///       Database.shared.error
///    }
/// *******************
class Database{
    
    // ----------------------
    // MARK: - Public fields
    // ----------------------
    
    /// The possible connection to the app database
    let connection: Connection?
    
    /// The possible error while tring to connect to the app database
    let error: Error?
    
    /// Is the connection to the app database sucessfull?
    let successfulConnection: Bool
    
    
    // -----------------------
    // MARK: - Initialisations
    // -----------------------
    
    /// The construstor for a successful database connection
    ///
    /// - Parameters:
    ///     - connection: The connection to the database
    private init(connection: Connection) {
        self.connection = connection
        self.error = nil
        self.successfulConnection = true
    }
    
    /// The construstor for a UNsuccessful database connection
    ///
    /// - Parameters:
    ///     - error: The error that made the database connection not successfull
    private init(error: Error) {
        self.connection = nil
        self.error = error
        self.successfulConnection = false
    }
    
    
    // ----------------------
    // MARK: - Statics fields
    // ----------------------
    
    /// Shared Database object
    static let shared: Database = {
        do{
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            
            let fileUrl = documentDirectory.appendingPathComponent("irregularVerbs").appendingPathExtension("sqlite3")
            
            let connection = try Connection(fileUrl.path)
            return Database(connection: connection)
        }
        catch{
            return Database(error: error)
        }
    }()
    
    
  
}
