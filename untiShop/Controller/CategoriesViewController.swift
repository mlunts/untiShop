//
//  CategoriesViewController.swift
//  untiShop
//
//  Created by Marina Lunts on 1/15/19.
//  Copyright © 2019 earine. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var categories = [Category]()
    
    var selectedType : String!
    var selectedCategory = Category()
    
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
        let c = categories[indexPath.row]
        cell.categoryLabel.text = c.title
        cell.categoryPreview.image = c.preview
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCategory = categories[indexPath.row]
        let newVC = self.storyboard?.instantiateViewController(withIdentifier: "ProductsByCategoryViewController") as! ProductsByCategoryViewController
        self.definesPresentationContext = true
        newVC.modalPresentationStyle = .overCurrentContext
        newVC.selectedCategory = selectedCategory
        self.present(newVC, animated: true, completion: nil)
        
        //         self.performSegue(withIdentifier: "goToProducts", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goToProducts") {
            let vc = segue.destination as! ProductsByCategoryViewController
            
            vc.selectedCategory = selectedCategory
        }
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

class CategoriesTableViewCell: UITableViewCell {
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryPreview: UIImageView!
}
