//
//  LocalStorage.swift
//  Outread
//
//  Created by Jaspreet Singh on 07/06/24.
//

import Foundation
import SwiftData

@Model
final class LocalStorage {
    var name : Product
    
    init(name: Product) {
        self.name = name
    }
}

@Model
final class LocalBookmarks {
    var productName : String
    
    init(productName: String) {
        self.productName = productName
    }
}

@Model
final class LocalDataStorage {
    var id: Int
    var name: String
    var shortDescription: String
    var categories: [Category]
    var images: [ProductImage]
    var metaData : [MetaData]
    var descData : String
    
    init(id: Int, name: String, shortDescription: String, categories: [Category], images: [ProductImage], metaData: [MetaData],descData:String) {
        self.id = id
        self.name = name
        self.shortDescription = shortDescription
        self.categories = categories
        self.images = images
        self.metaData = metaData
        self.descData = descData
    }
}

@Model
final class LocalStorageData {
    var productdata : Product
    
    init(productdata: Product) {
        self.productdata = productdata
    }
}
