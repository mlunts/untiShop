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

class FeaturedViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
    
    
    var products = [Product]() {
        didSet {
            self.featuredCollectionView?.reloadData()
            bannerImage.isHidden = false
            activityIndicator.stopAnimating()
        }
    }
    
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var featuredCollectionView: UICollectionView!
    var activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(products.count)
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as!        FeaturedItemViewCell
        
        let product = products[indexPath.item]
        
        cell.productTitle.text = product.title
        cell.productBrandLabel.text = product.brand
        cell.productPriceLabel.text = "$\(product.price ?? 0)"
        cell.productDiscountPriceLabel.text = "$\(product.discountPrice ?? 0)"
        cell.productImage.image = product.image1
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "SingleProductViewController") as! SingleProductViewController
        print(products[indexPath.item].brand)
        newViewController.selectedProduct = products[indexPath.item]
        newViewController.previousVC = "featured"
        self.present(newViewController, animated: true, completion: nil)
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(products.count)
       
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        view.addSubview(activityIndicator)
        bannerImage.isHidden = true
        activityIndicator.startAnimating()
        self.getData()
        self.featuredCollectionView.reloadData()
        bannerImage.image = getImageFromURL(urlpath: "https://rmssugar.000webhostapp.com/support_img/sale.jpg")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    
    func getData() {
        Alamofire.request(FEATURED_URL, method: .get).responseJSON { response in
            if response.result.isSuccess {
                print("Success")
                let json : JSON = JSON(response.result.value!)
                
                for i in 0...json.count-1 {
                    let product = Product()
                    product.id = json[i]["id"].int
                    product.title = json[i]["title"].string
                    product.price = round(100*json[i]["price"].doubleValue)/100
                    product.discountPrice = product.calculateDiscountPrice(percent: json[i]["discount_percent"].doubleValue)
                    product.brand = json[i]["brand_name"].string
                    product.description = json[i]["description"].stringValue
                    
                    product.image1 = getImageFromURL(urlpath: "\(IMAGE_URL)\(json[i]["image-1"].string!)")
                    if (json[i]["image-2"].string != nil) {
                    product.image2 = getImageFromURL(urlpath: "\(IMAGE_URL)\(json[i]["image-2"].string!)")
                    }
                    if (json[i]["image-3"].string != nil) {
                    product.image3 = getImageFromURL(urlpath: "\(IMAGE_URL)\(json[i]["image-3"].string!)")
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
