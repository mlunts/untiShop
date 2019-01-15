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
    
    
    var previousVC : String!
    var selectedProduct = Product()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
       
    }
    

    
    
    func updateUI() {
        productTitleLabel.text = selectedProduct.title
        productPriceLabel.text = "$\(selectedProduct.price ?? 0)"
        productDescriptionLabel.text = selectedProduct.description
        
        productDescriptionLabel.sizeToFit()
        
        if (selectedProduct.image3 != nil){
            imagesSlideshow.setImageInputs([
            ImageSource(image: selectedProduct.image1!),
            ImageSource(image: selectedProduct.image2!),
            ImageSource(image: selectedProduct.image3!)
            ])
        } else {
        imagesSlideshow.setImageInputs([
            ImageSource(image: selectedProduct.image1!),
            ImageSource(image: selectedProduct.image2!)
            ])
        }
        imagesSlideshow.contentScaleMode = UIView.ContentMode.scaleAspectFill
        imagesSlideshow.clipsToBounds = true
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    


}
