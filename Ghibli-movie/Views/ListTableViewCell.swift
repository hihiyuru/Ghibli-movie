//
//  ListTableViewCell.swift
//  Ghibli-movie
//
//  Created by 徐于茹 on 2023/8/17.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    
    @IBOutlet var posterImageViews: [UIImageView]!
    @IBOutlet var movieNameLabels: [UILabel]!
    @IBOutlet var yearLabels: [UILabel]!
    
    @IBOutlet var imageButtons: [UIButton]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
