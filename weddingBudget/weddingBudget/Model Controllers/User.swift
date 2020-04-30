//
//  User.swift
//  weddingBudget
//
//  Created by Elizabeth Wingate on 4/30/20.
//  Copyright © 2020 Keri Levesque. All rights reserved.
//

import UIKit

class User: NSObject {

    var name: String?
    var image: UIImage?
    
    init(name: String?, image: UIImage?) {
        self.name = name
        self.image = image
    }
}
