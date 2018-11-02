//
//  ViewController.swift
//  Irregular Verbs
//
//  Created by Lauriane Mollier on 28/10/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import UIKit
import SideMenu


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Define the menus
        let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let menu = mainstoryboard.instantiateViewController(withIdentifier: "menuViewController") as! MenuViewController
        let menuLeftNavigationController = UISideMenuNavigationController(rootViewController: menu)

//        SideMenuManager.default.menuRightNavigationController = menuLeftNavigationController

//        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
//        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        
        // (Optional) Prevent status bar area from turning black when menu appears:
        SideMenuManager.default.menuFadeStatusBar = false
    }


}

