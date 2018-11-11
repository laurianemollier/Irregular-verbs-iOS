//
//  RevisionPortalVC.swift
//  Irregular Verbs
//
//  Created by Lauriane Mollier on 02/11/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import UIKit
import SideMenu

class RevisionPortalVC: UIViewController {

    // --------------
    // MARK: - Datas
    // -------------
    
    /// The number of verb that is on the review list of this user
    var nbrVerbInReviewList: Int!
    
    /// The number of verb that the user as to review today
    var nbrVerbToReviewToday: Int!
    
    /// Determine number of verb that the user will review in one review session
    var nbrVerbInReviewSession = 10 // TODO: make in the settings
    
    
    // ----------------
    // MARK: - Outlets
    // ----------------
    
    /// The button where the number of verb to review today is displayed. Goes to the revision screen. If the user click on it, it will start to review the verb that need to be reviewed today
    @IBOutlet weak var nbrVerbToReviewButton: UIButton!
    
    /// The label that tell the user how many verb he has in his review list
    @IBOutlet weak var nbrVerbInReviewListLabel: UILabel!
    
    /// The button to go the revision screen. If the user click on it, it will start to review the verb that need to be reviewed today
    @IBOutlet weak var reviewButton: UIButton!
    
    
    
    // ---------------------------------
    // MARK: - Overriden views functions
    // ---------------------------------
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let menu = mainstoryboard.instantiateViewController(withIdentifier: "menuVC") as! MenuVC
        let menuLeftNavigationController = UISideMenuNavigationController(rootViewController: menu)
        SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
        
        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpData()
        setUpDataText()
        setUpFunctionalities()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    
    // ------------------------
    // MARK: - Set up functions
    // ------------------------
    
    
    // Set up the data of this controller that are stored in the database
    // In case of the failure to the database access, do not not set those data
    private func setUpData(){
        if Database.shared.successfulConnection{
            do{
                self.nbrVerbInReviewList = try DbUserLearningVerbDAOImpl.shared.nbrVerbInReviewList()
                self.nbrVerbToReviewToday = try DbUserLearningVerbDAOImpl.shared.nbrVerbToReviewToday()
            }
            catch{
                // TODO: To show the user that they is an error
                SpeedLog.print(error)
            }
        }
    }
    
    /// Set up the text that depending on data
    /// In case of the failure to the database access, do not not set those text
    /// **Need to be called after `setUpData`**
    ///
    /// - SeeAlso: setUpData()
    private func setUpDataText(){
        self.nbrVerbToReviewButton.setTitle(String(self.nbrVerbToReviewToday), for: .normal)
//        self.nbrVerbInReviewListLabel.text = String(format: Localizator.shared.localized(key()), self.nbrVerbInReviewList)
        // TODO
        
        func keyVerbIn() -> String{
            if self.nbrVerbInReviewList == 1 {
                return "(...1) verbs to review today over %@ in your review list"
            } else if self.nbrVerbInReviewList == 2{
                return "(...2) verbs to review today over %@ in your review list"
            } else if self.nbrVerbInReviewList == 3 || self.nbrVerbInReviewList == 4 {
                return "(...3/4) verbs to review today over %@ in your review list"
            } else {
                return "(...>4) verbs to review today over %@ in your review list"
            }
        }
    }
    
    
    
    
    
    /// If they are no verbs to review to today, desisable the possiblility to click on the button the review verbs
    /// **Need to be called after `setUpData`**
    ///
    /// - SeeAlso: setUpData()
    private func setUpFunctionalities(){
        if self.nbrVerbToReviewToday == 0 {
            self.nbrVerbToReviewButton.isEnabled = false
            self.reviewButton.isEnabled = false
        }
        else{
            self.nbrVerbToReviewButton.isEnabled = true
            self.reviewButton.isEnabled = true
        }
    }
    

    // ------------------
    // MARK: - Navigation
    // ------------------
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "revisionType" {
            let vc = segue.destination as! RevisionTypeVC
            do {
                vc.verbsToReview = try DbUserLearningVerbDAOImpl.shared.verbsToReviewToday(limit: nbrVerbInReviewSession)
            }
            catch{
                vc.verbsToReview = []
            }
        }
    }

    /// Make appear the side menu on the left side
    ///
    /// - Parameters:
    ///     - sender: The button on the left side of the navigation controller bar
    @IBAction func showSideMenu(_ sender: UIBarButtonItem) {
        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
    }
    

}
