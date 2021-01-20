//
//  DetailViewController.swift
//  GoogleBookd
//
//  Created by Abraao Nascimento on 19/01/21.
//  Copyright © 2021 ITSector. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    enum Sections: Int {
        case image = 0
        case title
        case price
        case description
        case properties
        
        static var count: Int { return description.rawValue + 1 }
        
        func height() -> CGFloat {
            switch self {
            case .image:
                return 300
            case .title:
                return UITableView.automaticDimension
            case .price:
                return 44
            case .description:
                return UITableView.automaticDimension
            case .properties:
                return 30
            }
        }
        
        func identifier() -> String {
            switch self {
            case .image:
                return "idImage"
            case .title:
                return "idTitle"
            case .price:
                return "idPrice"
            case .description:
                return "idDescription"
            case .properties:
                return "idProperties"
            }
        }
    }
    
    @IBOutlet var tableView: UITableView!
    let favorites = Favorites.shared
    
    var bookViewModel: BookViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView(frame: .zero)
        
        updateBtnIcon()
    }
    
    @IBAction func close(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func like() {
        guard let bookId = self.bookViewModel?.id else { return }
        
        if favorites.isBookLiked(bookId) {
            self.favorites.remove(bookId)
        } else {
            self.favorites.add(bookId)
        }
        
        self.updateBtnIcon()
    }
    
    func updateBtnIcon() {
        let indexPath = IndexPath(row: 0, section: Sections.image.rawValue)
        guard let cell = tableView.cellForRow(at: indexPath) as? DetailImageCell else { return }
        
        guard let bookId = self.bookViewModel?.id else { return }
        var favIcon = #imageLiteral(resourceName: "icLikeHi")
        
        if !favorites.isBookLiked(bookId) {
            favIcon = #imageLiteral(resourceName: "icLike")
        }
        
        cell.btnLike.setImage(favIcon, for: .normal)
        
    }
    
}

extension DetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        Sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Sections(rawValue: section) else { return 0 }
        
        switch section {
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let section = Sections(rawValue: indexPath.section) else { return UITableViewCell() }
        let baseCell = tableView.dequeueReusableCell(withIdentifier: section.identifier(), for: indexPath)
        
        switch section {
        case .image:
            let cell = baseCell as! DetailImageCell
            cell.bookImageView.image = bookViewModel?.image
            cell.onLikeBook = {
                self.like()
            }
            
            return cell
        case .title:
            let cell = baseCell as! DetailTitleCell
            cell.bookTitle.text = bookViewModel?.title
            
            return cell
        case .price:
            let cell = baseCell as! DetailPriceCell
            cell.book = bookViewModel
            
            return cell
        case .description:
            let cell = baseCell as! DetailDescriptionCell
            cell.bookDescriptionLabel.text = bookViewModel?.bookDescription
            
            return cell
        case .properties:
            let cell = baseCell as! DetailPropertieCell
            return cell
        }
    }
}

extension DetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = Sections(rawValue: indexPath.section) else { return 0 }
        return section.height()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = Sections(rawValue: indexPath.section) else { return 0 }
        return section.height()
    }
}
