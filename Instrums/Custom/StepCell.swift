//
//  StepCell.swift
//  Instrums
//
//  Created by Stefan Adisurya on 01/05/21.
//

import UIKit

class StepCell: UITableViewCell {

    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var stepImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
