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
    var previewImages = ["female_clothes", "female_shoes", "female_acc"]
    
    var categories = [String]()
    var categoryPreviews = [UIImage]()
    var selectedType : Int?
    var selectedGender : String?
    
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    @IBOutlet weak var typesTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        typesTableView.delegate = self
        typesTableView.dataSource = self
        genderSegmentedControl.selectedSegmentIndex = 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.types.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TypesTableViewCell", for: indexPath)
                as! TypesTableViewCell
            
            cell.typeLabel.text = types[indexPath.row]
            cell.previewImage.image = UIImage(named: previewImages[indexPath.row])
            return cell
      
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            categories.removeAll()
        categoryPreviews.removeAll()
        selectedType = indexPath.row
            getCategories(gender: selectedGender ?? "f", type: indexPath.row)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goToCategories") {
            let vc = segue.destination as! CategoriesViewController
            vc.categories = categories
            vc.categoryPreviews = categoryPreviews
            vc.selectedType = types[selectedType ?? 0]
        }
    }
    
    @IBAction func genderSelected(_ sender: Any) {
        switch genderSegmentedControl.selectedSegmentIndex
        {
        case 0:
            selectedGender = "f"
            previewImages.removeAll()
            previewImages = ["female_clothes", "female_shoes", "female_acc"]
            typesTableView.reloadData()
        case 1:
            selectedGender = "m"
            previewImages.removeAll()
            previewImages = ["male_clothes", "male_shoes", "male_acc"]
            typesTableView.reloadData()
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
                        self.categories.append(json[i]["category"].stringValue)
                        if gender == "f" {
                            print("\(IMAGE_URL)\(json[i]["female_preview"].string!)")
                            self.categoryPreviews.append(getImageFromURL(urlpath: "\(IMAGE_URL)\(json[i]["female_preview"].string!)"))
                        } else {
                            self.categoryPreviews.append(getImageFromURL(urlpath: "\(IMAGE_URL)\(json[i]["male_preview"].string!)"))
                        }
                    }
                }
                self.performSegue(withIdentifier: "goToCategories", sender: nil)
            } else {print("oops")}
        }
       
    }

    
}

class TypesTableViewCell: UITableViewCell{
    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    
}

