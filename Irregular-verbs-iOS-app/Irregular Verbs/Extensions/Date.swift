//
//  Date.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 20/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation


extension Date {
    
    /// The data of yesterday at noon
    var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    
    /// The data of tomorow at noon
    var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    
    /// This data at noon
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    
    /// The month in this data
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    
    /// Is the last day of the month? 
    var isLastDayOfMonth: Bool {
        return tomorrow.month != month
    }
}
