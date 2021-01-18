//
//  ViewController.swift
//  GoogleBookd
//
//  Created by Abraao Nascimento on 16/01/21.
//  Copyright © 2021 ITSector. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchView: UIView!
    @IBOutlet var spinner: UIView!
    
    var currentQuery: String = ""
    
    var bookList: [BookViewModel]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.style()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func style() {
        
        let shadowView = UIView(frame: CGRect(x: 0,
                                              y: self.searchView.frame.origin.y +  self.searchView.frame.size.height - 2,
                                              width: self.searchView.frame.size.width,
                                              height: 2))
        self.view.insertSubview(shadowView, aboveSubview: self.searchView)
        
        shadowView.layer.shadowColor = UIColor(white: 0, alpha: 0.25).cgColor
        shadowView.layer.shadowOffset = CGSize(width: 0, height:0.05)
        shadowView.layer.shadowRadius = 0.8
        shadowView.layer.shadowOpacity = 0.5
        shadowView.layer.shadowPath = UIBezierPath(rect: shadowView.bounds).cgPath
        
    }
    
    func doSearch(text: String) {
        
        //
        clearResults()
        
        self.currentQuery = text.replacingOccurrences(of: " ", with: "+")
        self.spinner.isHidden = false
        
        Services.search(with: self.currentQuery) { (books) in
            guard let books = books else { return }
            self.loadResults(books)
        }
    }
    
    func loadResults(_ result: SearchResult, isPaging: Bool = false) {
        
        //TODO: add paging
        
        // Not found
        if result.totalItems == 0 {
            DispatchQueue.main.async { [weak self] in
                self?.addMsgNotFound()
            }
        }
        
        if !isPaging {
            self.bookList = [BookViewModel]()
        }
        
        // Append new photos
        result.items.forEach { (book) in
            let bookViewModel = BookViewModel(book)
            self.bookList?.append(bookViewModel)
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.spinner.isHidden = true
            self?.collectionView.reloadData()
        }
    }
    
    func clearResults() {
        self.searchTextField.resignFirstResponder()
        self.removeMsgNotFound()
        self.bookList?.removeAll()
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    func addMsgNotFound() {
        let label = UILabel(frame: CGRect(x: (screenSize.width - 200) / 2,
                                          y: (screenSize.height - 20) / 2,
                                          width: 200,
                                          height: 20))
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = .black
        label.text = "Ops! no results found 😮"
        label.tag = 236
        self.view.insertSubview(label, aboveSubview: self.collectionView)
    }
    
    func removeMsgNotFound() {
        if let notFoundLabel = self.view.viewWithTag(236) {
            notFoundLabel.removeFromSuperview()
        }
    }
}

extension ViewController: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let value = textField.text {
            self.doSearch(text: value)
        }
        
        return true
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "idCell", for: indexPath) as! ResultCollectionViewCell
        
        cell.imageView.image = UIImage(systemName: "rectangle")!
        
        if let book = bookList?[indexPath.row] {
            ImageCache.shared.load(book: book) { (photo) in
                DispatchQueue.main.async {
                    cell.imageView.image = book.image
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        //TODO: Load more results
        
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // TODO: Navigate to Detail View
    }
}
