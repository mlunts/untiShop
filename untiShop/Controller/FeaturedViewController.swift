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
    
    var service = Service()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! FeaturedItemViewCell
        
        let product = products[indexPath.item]
        
        cell.productTitle.text = product.title
        cell.productBrandLabel.text = product.brand
        strikeOnLabel(price: product.price ?? 0, oldPriceLabel: cell.productPriceLabel)
        cell.productPriceLabel.sizeToFit()
        cell.productDiscountPriceLabel.text = "$\(product.discountPrice ?? 0)"
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
        Alamofire.request(FEATURED_URL, method: .get).responseJSON { response in
            if response.result.isSuccess {
                print("Success")
                let json : JSON = JSON(response.result.value!)
                
                for i in 0...json.count-1 {
                    let product = Product()
                    self.service.fetchProduct(product: product, i: i, json: json)
                    self.products.append(product)
                }
            } else {print("oops")}
        }
    }
    
    
}


