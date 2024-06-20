//
//  Category.swift
//  Outread
//
//  Created by AKASH BOGHANI on 20/06/24.
//

import Foundation

struct Category: Identifiable, Codable, Equatable {
    var id: Int?
    var name: String?
    var parent: Int?
    var colorCategory : String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case parent
        case colorCategory = "color_category"
    }
}
