//
//  PerfilesTableViewCell.swift
//  MediKit
//
//  Created by administrador on 28/9/17.
//  Copyright © 2017 Tecnologico de Costa Rica. All rights reserved.
//

import UIKit

class PerfilesTableViewCell: UITableViewCell {
    @IBOutlet weak var nombreUsuario: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func perfil(_ sender: AnyObject) {
    }

    @IBAction func borrar(_ sender: AnyObject) {
    }
}
