//
//  plantaTableViewCell.swift
//  tableview
//
//  Created by Aluno02 on 15/05/22.
//  Copyright © 2022 Daniel Morais. All rights reserved.
//

import UIKit

class plantaTableViewCell: UITableViewCell {

    @IBOutlet weak var plantaImageView: UIImageView!
    
    @IBOutlet weak var plantaLabel: UILabel!
    
    @IBOutlet weak var pcell: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        pcell.layer.cornerRadius = 15.0
        pcell.layer.masksToBounds = true

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
