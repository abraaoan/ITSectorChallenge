//
//  DetailImageCell.swift
//  GoogleBookd
//
//  Created by Abraao Nascimento on 19/01/21.
//  Copyright © 2021 ITSector. All rights reserved.
//

import UIKit

class DetailImageCell: UITableViewCell {
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var btnLike: UIButton!
    
    var onLikeBook: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func like(_ sender: UIButton) {
        self.onLikeBook?()
    }
}
