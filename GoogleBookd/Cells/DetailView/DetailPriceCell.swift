//
//  DetailPriceCell.swift
//  GoogleBookd
//
//  Created by Abraao Nascimento on 19/01/21.
//  Copyright © 2021 ITSector. All rights reserved.
//

import UIKit

class DetailPriceCell: UITableViewCell {

    @IBOutlet weak var bookPriceLabel: UILabel!
    @IBOutlet var btnBuy: UIButton!
    
    var book: BookViewModel? {
        didSet {
            self.bookPriceLabel.text = book?.price
            if !(book?.isAvailable ?? false) {
                self.setBuyButtonDisable()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setBuyButtonDisable() {
        
        btnBuy.isEnabled = false
        btnBuy.backgroundColor = .gray
        self.bookPriceLabel.text = "Indisponível"
        
    }
    
    @IBAction func buy(_ sender: Any) {
        guard let bookUrl = book?.buyLink else { return }
        guard let url = URL(string: bookUrl) else { return }
        UIApplication.shared.open(url)
    }
    
}
