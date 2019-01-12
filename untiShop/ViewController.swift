//
//  ViewController.swift
//  untiShop
//
//  Created by Marina Lunts on 1/11/19.
//  Copyright © 2019 earine. All rights reserved.
//

import UIKit
import WebKit
import Foundation
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
    
    var products = [Product]() {
        didSet {
            self.featuredCollectionView?.reloadData()
        }
    }
    
    @IBOutlet weak var featuredCollectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(products.count)
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as!        FeaturedItemViewCell
        
        let product = products[indexPath.item]
        
        cell.productTitle.text = product.title
        cell.productBrandLabel.text = product.brand
        cell.productPriceLabel.text = "$\(product.price)"
        cell.productDiscountPriceLabel.text = "$\(product.discountPrice)"
        cell.productImage.image = product.image1
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(products.count)
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getData()
        self.featuredCollectionView.reloadData()
    }
    
    func getData() {
        Alamofire.request(FEATURED_URL, method: .get).responseJSON { response in
            if response.result.isSuccess {
                print("Success")
                let json : JSON = JSON(response.result.value!)
                
                for i in 0...json.count-1 {
                    var product = Product()
                    product.id = json[i]["id"].int
                    product.title = json[i]["title"].string
                    product.price = json[i]["price"].double
                    product.discountPrice = product.calculateDiscountPrice(percent: json[i]["discount_percent"].double ?? 10)
                    product.brand = json[i]["brand_name"].string
                    
                    let url = URL(string: "\(IMAGE_URL)\(json[i]["image-1"].string!)")
                    let data = try? Data(contentsOf: url!)
                    
                    if let imageData = data {
                        product.image1 = UIImage(data: imageData)
                        
                    }
                    
                   self.products.append(product)
                    
                }
            } else {print("oops")}
        }
        
    }
    
    
}

class FeaturedItemViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productBrandLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productDiscountPriceLabel: UILabel!
    
}
