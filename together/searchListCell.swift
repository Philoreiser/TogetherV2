//
//  searchListCell.swift
//  together
//
//  Created by Chuei-Ching Chiou on 31/07/2017.
//  Copyright © 2017 Seven Tsai. All rights reserved.
//

import UIKit

class searchListCell: UITableViewCell {

    
    @IBOutlet weak var groupTitle: UILabel!
    @IBOutlet weak var groupContent: UILabel!
    @IBOutlet weak var groupDistance: UILabel!
    @IBOutlet weak var groupStatus: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
