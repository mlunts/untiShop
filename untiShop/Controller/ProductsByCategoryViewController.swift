//
//  ProductsByCategoryViewController.swift
//  untiShop
//
//  Created by Marina Lunts on 1/15/19.
//  Copyright © 2019 earine. All rights reserved.
//

import UIKit

class ProductsByCategoryViewController: UIViewController, UITabBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let index = tabBar.items?.index(of: item) else { return }
        switch index {
        case 0:
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "FeaturedViewController") as! FeaturedViewController
            
            self.present(newViewController, animated: true, completion: nil)
            
        case 1:
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "CategoriesTypesViewController") as! CategoriesTypesViewController
            
            self.present(newViewController, animated: true, completion: nil)
        default:
            break
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
