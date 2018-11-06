//
//  MenuVC.swift
//  Irregular Verbs
//
//  Created by Lauriane Mollier on 03/11/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import UIKit

class MenuVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuCellEnum.numberCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("MenuTVCell", owner: self, options: nil)?.first as! MenuTVCell
        let cellEnum = MenuCellEnum.allValues[indexPath.row]
        cell.setUp(cellEnum: cellEnum)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        cell.contentView.backgroundColor = UIColor.white
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! MenuTVCell
        cell.contentView.backgroundColor = UIColor.red
        
        let idSeque = cell.cellEnum.correspondingSegueId()
        self.performSegue(withIdentifier: idSeque, sender: self)
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
