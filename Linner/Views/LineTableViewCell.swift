//
//  LineTableViewCell.swift
//  Linner
//
//  Created by Yves Songolo on 8/24/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import UIKit

class LineTableViewCell: UITableViewCell {

    @IBOutlet weak var lineDate: UILabel!
    @IBOutlet weak var linnerName: UILabel!
    @IBOutlet weak var lineStatus: UILabel!
    @IBOutlet weak var lineTitle: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var endTime: UILabel!
    @IBOutlet weak var duration: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
