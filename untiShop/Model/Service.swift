//
//  Service.swift
//  untiShop
//
//  Created by Marina Lunts on 1/14/19.
//  Copyright © 2019 earine. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Service {
    
    func fetchProduct(product : Product, i : Int, json : JSON) {
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
    }
    
    
    
    
}
