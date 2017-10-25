//
//  historialTableViewCell.swift
//  MediKit
//
//  Created by administrador on 28/9/17.
//  Copyright © 2017 Tecnologico de Costa Rica. All rights reserved.
//

import UIKit

class historialTableViewCell: UITableViewCell {

    @IBOutlet weak var estadoCell: UILabel!
    @IBOutlet weak var horaCell: UILabel!
    @IBOutlet weak var diaCell: UILabel!
    @IBOutlet weak var medicamentoCell: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
