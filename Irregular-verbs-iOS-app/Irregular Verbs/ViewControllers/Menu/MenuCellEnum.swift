//
//  MenuCellEnum.swift
//  Irregular Verbs
//
//  Created by Lauriane Mollier on 03/11/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation
import UIKit



enum MenuCellEnum: String{
    case home = "Home menu title"
    case revision = "Revision menu title"
    case addVerbs = "AddVerbs menu title"
    case statistics = "Statistics menu title"
    case allVerbs = "AllVerbs menu title"
    case settings = "Settings menu title"
    case inviteFriends = "InviteFriends menu title"
    case gradeTheApp = "GradeTheApp menu title"
    case help = "Help menu title"

    
    static let allValues = [home,
                            revision,
                            addVerbs,
                            statistics,
                            allVerbs,
                            settings,
                            inviteFriends,
                            gradeTheApp,
                            help]
    
    static let numberCells = allValues.count
    
    func correspondingSegueId() -> String{
        switch self {
        case MenuCellEnum.home:
            return "HomePortalVCSegueId"
        case MenuCellEnum.addVerbs:
            return "AddVerbsPortalVCSegueId"
        case MenuCellEnum.revision:
            return "RevisionPortalVCSegueId"
        case MenuCellEnum.statistics:
            return "StatisticsPortalVCSegueId"
        case MenuCellEnum.allVerbs:
            return "AllVerbsPortalVCSegueId"
        case MenuCellEnum.settings:
            return "SettingsPortalVCSegueId"
        case MenuCellEnum.inviteFriends:
            return "InviteFriendsPortalVCSegueId"
        case MenuCellEnum.gradeTheApp:
            return "GradeTheAppPortalVCSegueId"
        case MenuCellEnum.help:
            return "HelpPortalVCSegueId"
        }
    }
    
    
    func title() -> String {
        switch self {
        case MenuCellEnum.home:
            return "HomePortalVCSegueId"
        case MenuCellEnum.addVerbs:
            return "AddVerbsPortalVCSegueId"
        case MenuCellEnum.revision:
            return "RevisionPortalVCSegueId"
        case MenuCellEnum.statistics:
            return "StatisticsPortalVCSegueId"
        case MenuCellEnum.allVerbs:
            return "AllVerbsPortalVCSegueId"
        case MenuCellEnum.settings:
            return "SettingsPortalVCSegueId"
        case MenuCellEnum.inviteFriends:
            return "InviteFriendsPortalVCSegueId"
        case MenuCellEnum.gradeTheApp:
            return "GradeTheAppPortalVCSegueId"
        case MenuCellEnum.help:
            return "HelpPortalVCSegueId"
        }
    }
    
//    func iconArray() -> UIImage{
//        switch self {
//        case MenuCellEnum.home:
//            return #imageLiteral(resourceName: "home menu")
//        case MenuCellEnum.languageToLearn:
//            return #imageLiteral(resourceName: "language menu")
//        case MenuCellEnum.settings:
//            return #imageLiteral(resourceName: "settings menu")
//        case MenuCellEnum.inviteYourFriend:
//            return #imageLiteral(resourceName: "invite friend menu")
//        case MenuCellEnum.gradeApp:
//            return #imageLiteral(resourceName: "grade app menu")
//        case MenuCellEnum.help:
//            return #imageLiteral(resourceName: "help menu")
//        }
//    }
    
    
}
