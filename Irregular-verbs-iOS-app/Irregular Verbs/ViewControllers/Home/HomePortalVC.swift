//
//  HomePortalVC.swift
//  Irregular Verbs
//
//  Created by Lauriane Mollier on 02/11/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import UIKit
import SideMenu

class HomePortalVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        // Define the menus
        
        let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let menu = mainstoryboard.instantiateViewController(withIdentifier: "menuVC") as! MenuVC
        let menuLeftNavigationController = UISideMenuNavigationController(rootViewController: menu)
        menuLeftNavigationController.leftSide = true
        SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
        
        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        
        
        // (Optional) Prevent status bar area from turning black when menu appears:
        SideMenuManager.default.menuFadeStatusBar = false
    }
    
    
    /// Make appear the side menu on the left side
    ///
    /// - Parameters:
    ///     - sender: The button on the left side of the navigation controller bar
    @IBAction func showSideMenu(_ sender: UIBarButtonItem) {
        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    
    
   
}
