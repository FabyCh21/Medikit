//
//  MedicamentosTableViewCell.swift
//  MediKit
//
//  Created by administrador on 15/11/17.
//  Copyright © 2017 Tecnologico de Costa Rica. All rights reserved.
//

import UIKit

class MedicamentosTableViewCell: UITableViewCell {

    @IBOutlet weak var nombreMedicamentoLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
