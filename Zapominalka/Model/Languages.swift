//
//  Languages.swift
//  Zapominalka
//
//  Created by Никита Куприянов on 21.05.2023.
//

import Foundation

enum Languages: String, CaseIterable {
    case en
    case ru
    case tr
    case fr
    
    var title: String {
        self.rawValue.uppercased()
    }
}
