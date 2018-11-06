//
//  MenuTVCell.swift
//  Irregular Verbs
//
//  Created by Lauriane Mollier on 04/11/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import UIKit

class MenuTVCell: UITableViewCell {

    var cellEnum: MenuCellEnum!
    
    @IBOutlet weak var title: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    func setUp(cellEnum: MenuCellEnum) {
        self.cellEnum = cellEnum
        
        title.text = cellEnum.title()
    }
    
    
    
    
}
