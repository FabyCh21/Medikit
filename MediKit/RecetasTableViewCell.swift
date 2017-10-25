//
//  RecetasTableViewCell.swift
//  MediKit
//
//  Created by administrador on 28/9/17.
//  Copyright © 2017 Tecnologico de Costa Rica. All rights reserved.
//

import UIKit

class RecetasTableViewCell: UITableViewCell {
    @IBOutlet weak var nombreMedicamento: UILabel!
    @IBOutlet weak var hora: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func borrar(_ sender: AnyObject) {
    }
    @IBOutlet weak var receta: UIButton!

}
