//
//  CategoriesViewController.swift
//  untiShop
//
//  Created by Marina Lunts on 1/15/19.
//  Copyright © 2019 earine. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var categories = [String]()
    var categoryPreviews = [UIImage]()
    var selectedType : String! 
    var viewController1: UIViewController?
    var viewController2: UIViewController?
    
    @IBOutlet weak var categoriesTableView: UITableView!
    @IBOutlet weak var typeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoriesTableView.delegate = self
        categoriesTableView.dataSource = self
        categoriesTableView.reloadData()
        typeLabel.text = selectedType
       
       
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesTableViewCell", for: indexPath)
            as! CategoriesTableViewCell
        
        cell.categoryLabel.text = categories[indexPath.row]
        cell.categoryPreview.image = categoryPreviews[indexPath.row]
        return cell
    }
    

    @IBAction func backButton(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
    
}

class CategoriesTableViewCell: UITableViewCell {
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryPreview: UIImageView!
}
