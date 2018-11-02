//
//  Form.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 17/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation
import AVFoundation


/// Each verb belongs to a conjugation's form
/// There is 10 ways to conjugation a german irregular verb and some of the verbs do not fit the one of this 10 pattern
/// So we have 11 forms
public enum Form: String {
    case aiea = "a–ie(i)–a"
    case aua = "a-u-a"
    case eae = "e-a-e"
    case eao = "e-a-o"
    case eiieie = "ei-ie-ie"
    case eiii = "ei-i-i"
    case iao = "i-a-o"
    case iau = "i-a-u"
    case ieoo = "ie(e)-o-o"
    case undefine = "undefine"
    case weak = "weak"
    
    static let allValues = [aiea, aua, eae, eao, eiieie, eiii, iao, iau, ieoo, undefine, weak]
}
