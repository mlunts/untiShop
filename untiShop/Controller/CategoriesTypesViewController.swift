//
//  CategoriesTypesViewController.swift
//  untiShop
//
//  Created by Marina Lunts on 1/15/19.
//  Copyright © 2019 earine. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CategoriesTypesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var types = ["Одежда", "Обувь", "Аксессуары"]
    var categories = [String]() {
        didSet {
            print(categories.count)
            categoriesTableView.reloadData()
        }
    }
    var selectedType : Int?
    var selectedGender : String?
    
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    @IBOutlet weak var typesTableView: UITableView!
    @IBOutlet weak var categoriesTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        typesTableView.delegate = self
        typesTableView.dataSource = self
        categoriesTableView.isHidden = true
        categoriesTableView.delegate = self
        categoriesTableView.dataSource = self
        genderSegmentedControl.selectedSegmentIndex = 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == typesTableView {
            return self.types.count
        } else {
            return self.categories.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == typesTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TypesTableViewCell", for: indexPath)
                as! TypesTableViewCell
            
            cell.typeLabel.text = types[indexPath.row]
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesTableViewCell", for: indexPath)
                as! CategoriesTableViewCell
            
            cell.categoryLabel.text = categories[indexPath.row]
            
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == typesTableView {
            getCategories(gender: selectedGender ?? "f", type: indexPath.row)
            typesTableView.isHidden = true
            categoriesTableView.isHidden = false
            print(categories.count)
            
        } else {
            
        }
    }
    
    @IBAction func genderSelected(_ sender: Any) {
        switch genderSegmentedControl.selectedSegmentIndex
        {
        case 0:
            selectedGender = "f"
        case 1:
            selectedGender = "m"
        default:
            break;
        }
    }
    
    
    func getCategories(gender : String, type : Int) {
        Alamofire.request(CATEGORIES_URL, method: .get).responseJSON { response in
            if response.result.isSuccess {
                print("Success")
                let json : JSON = JSON(response.result.value!)
                
                for i in 0...json.count-1 {
                    if ((json[i]["gender"].string == "u" || json[i]["gender"].string == gender) && (json[i]["type"].intValue == type + 1)) {
                       print(json[i]["category"].stringValue)
                        self.categories.append(json[i]["category"].stringValue)
                    }
                }
            } else {print("oops")}
        }
    }

    
}

class TypesTableViewCell: UITableViewCell{
    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    
}

class CategoriesTableViewCell: UITableViewCell {
    @IBOutlet weak var categoryLabel: UILabel!
}
