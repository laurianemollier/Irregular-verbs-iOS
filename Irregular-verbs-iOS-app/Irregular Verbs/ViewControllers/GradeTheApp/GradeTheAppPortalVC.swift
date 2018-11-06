//
//  GradeTheAppPortalVC.swift
//  Irregular Verbs
//
//  Created by Lauriane Mollier on 02/11/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import UIKit
import SideMenu

class GradeTheAppPortalVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    /// Make appear the side menu on the left side
    ///
    /// - Parameters:
    ///     - sender: The button on the left side of the navigation controller bar
    @IBAction func showSideMenu(_ sender: UIBarButtonItem) {
        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
    }
}
