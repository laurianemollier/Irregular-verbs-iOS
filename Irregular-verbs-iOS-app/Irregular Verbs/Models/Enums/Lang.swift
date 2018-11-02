//
//  Lang.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 17/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation
import AVFoundation


/// The language in witch the app is written. (ie. the user monther tongue)
enum Lang: String{
    case DeviceLanguage = "DeviceLanguage"
    
    /// French
    case fr = "fr"
    
    /// English
    case en = "en"
    
    /// Spanisch
    case es = "es"
    
    /// Russian
    case ru = "ru"
    
    /// Traditionnal chineese
    case zh = "zh-Hant"
    
    /// Arabe
    case ar = "ar"
    
    /// Italien
    case it = "it"
    
    /// Japoneese
    case ja = "ja"
    
    /// All Lang
    static let allValues = [DeviceLanguage, fr, en, es, ru, zh, ar, it, ja]
}
