//
//  categoriesData.swift
//  Checklist-171024
//
//  Created by Joachim Vetter on 24.10.17.
//  Copyright © 2017 Joachim Vetter. All rights reserved.
//

import UIKit

class CategoriesData: NSObject, Codable {
    var categoryNames = ""
    var checkers = false
    var items = [ItemsData]()
}
