//
//  ProductsByCategoryViewController.swift
//  untiShop
//
//  Created by Marina Lunts on 1/15/19.
//  Copyright © 2019 earine. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ProductsByCategoryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var selectedCategory = Category()
    var service = Service()
    var products = [Product]() {
        didSet {
            self.productsListCollectionView?.reloadData()
            activityIndicator.stopAnimating()
        }
    }
    
    
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var productsListCollectionView: UICollectionView!
    var activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(products.count)
        categoryTitle.sizeToFit()
        categoryTitle.text = selectedCategory.title
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        getData()
        productsListCollectionView?.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(products.count)
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! ProductViewCell
        
        let product = products[indexPath.item]
        
        cell.productTitle.text = product.title
        cell.productBrandLabel.text = product.brand
        
        cell.productPriceLabel.sizeToFit()
        if product.discountPrice != nil {
            strikeOnLabel(price: product.price ?? 0, oldPriceLabel: cell.productPriceLabel)
            cell.productDiscountPriceLabel.text = "$\(product.discountPrice ?? 0)"
        } else {
            cell.productPriceLabel.text = "$\(product.price ?? 0)"
        }
        cell.productImage.image = product.images[0]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "SingleProductViewController") as! SingleProductViewController
        
        newViewController.selectedProduct = products[indexPath.item]
        newViewController.previousVC = "featured"
        self.present(newViewController, animated: true, completion: nil)
    }
    
    func getData() {
        
        let link = "\(PRODUCTSLIST_URL)?id=\(selectedCategory.id ?? 1)&gender=\(selectedCategory.gender ?? "f")"
        print(link)
        Alamofire.request(link, method: .get).responseJSON { response in
            if response.result.isSuccess {
                print("Success")
                let json : JSON = JSON(response.result.value!)
                
                for i in 0...json.count-1 {
                    let product = Product()
                    self.service.fetchProduct(product: product, i: i, json: json)
                    print(product.title)
                    self.products.append(product)
                    print(self.products.count)
                }
            } else {print("oops")}
        }
    }
    
    
    
}

class ProductViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productBrandLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productDiscountPriceLabel: UILabel!
    
}
