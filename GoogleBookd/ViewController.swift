//
//  ViewController.swift
//  GoogleBookd
//
//  Created by Abraao Nascimento on 16/01/21.
//  Copyright © 2021 ITSector. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Services.search(with: "iOS") { (result) in
            guard let result = result else { return }
            result.items.forEach { (book) in
                print("- ", book.volumeInfo.title)
            }
        }
    }
}

