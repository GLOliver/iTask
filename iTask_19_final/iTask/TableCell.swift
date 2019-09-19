//
//  TableCell.swift
//  iTask
//
//  Created by Aluno Mack on 18/09/19.
//  Copyright © 2019 Aluno Mack. All rights reserved.
//

import UIKit

class TableCell: UITableViewCell {
    
    @IBOutlet weak var tituloLbl: UILabel!
    @IBOutlet weak var dataLbl: UILabel!
    @IBOutlet weak var prioridadeLbl: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
