//
//  DetailsCell.swift
//  Talabat
//
//  Created by amr ahmed abdel hamied on 3/27/20.
//  Copyright © 2020 amr ahmed abdel hamied. All rights reserved.
//

import UIKit

class DetailsCell: UITableViewCell {
    
    
    @IBOutlet weak var orderImageView: UIImageView!
    @IBOutlet weak var orderNameLabel: UILabel!
    @IBOutlet weak var orderPriceLabel: UILabel!
    @IBOutlet weak var orderQuantityLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
