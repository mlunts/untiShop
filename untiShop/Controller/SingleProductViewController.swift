//
//  SingleProductViewController.swift
//  untiShop
//
//  Created by Marina Lunts on 1/14/19.
//  Copyright © 2019 earine. All rights reserved.
//

import UIKit
import ImageSlideshow

class SingleProductViewController: UIViewController {
    
    @IBOutlet weak var imagesSlideshow: ImageSlideshow!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var discountPriceLabel: UILabel!
    
    var previousVC : String!
    var selectedProduct = Product()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
    }
    
    
    
    
    func updateUI() {
        productTitleLabel.text = selectedProduct.title
        
        productDescriptionLabel.text = selectedProduct.description
        productDescriptionLabel.sizeToFit()
        
        var imageSource: [ImageSource] = []
        for image in selectedProduct.images {
            let img = image
            imageSource.append(ImageSource(image:  img))
        }
        
        imagesSlideshow.setImageInputs(imageSource)
        
        if (selectedProduct.discountPrice != nil) {
            strikeOnLabel(price: selectedProduct.price ?? 0, oldPriceLabel: productPriceLabel)
            discountPriceLabel.text = "$\(selectedProduct.discountPrice ?? 0)"
            discountPriceLabel.sizeToFit()
            productPriceLabel.sizeToFit()
        } else {
            productPriceLabel.text = "$\(selectedProduct.price ?? 0)"
            productPriceLabel.sizeToFit()
        }
        
        imagesSlideshow.contentScaleMode = UIView.ContentMode.scaleAspectFill
        imagesSlideshow.clipsToBounds = true
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}
