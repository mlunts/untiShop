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
