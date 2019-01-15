//
//  Extensions.swift
//  untiShop
//
//  Created by Marina Lunts on 1/13/19.
//  Copyright © 2019 earine. All rights reserved.
//

import Foundation
import UIKit



func getImageFromURL(urlpath: String) -> UIImage {
    var image : UIImage
    let url = URL(string: urlpath)
    let data = try? Data(contentsOf: url!)
    let imageData = data
    image = UIImage(data: imageData!)!
    
    return image
}

func strikeOnLabel(price : Double, oldPriceLabel : UILabel){
    let currencyFormatter = NumberFormatter()
    currencyFormatter.numberStyle = .currency
    currencyFormatter.currencyCode = "USD"
    let priceInINR = currencyFormatter.string(from: price as NSNumber)
    
    let attributedString = NSMutableAttributedString(string: priceInINR!)
    attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, attributedString.length))
    oldPriceLabel.attributedText = attributedString
}


    
    

