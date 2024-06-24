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

@Model
final class LocalCategory {
    var id: Int
    var name: String
    let parent: Int?
    var colorCategory: String
    
    init(id: Int, name: String, parent: Int?, colorCategory: String) {
        self.id = id
        self.name = name
        self.parent = parent
        self.colorCategory = colorCategory
    }
}

@Model
final class LocalProduct {
    var id: Int
    var name: String
    var permalink: String
    var desc: String
    var shortDescription: String
    var status: String
    var price: String
    var categories: [Category]
    var images: [ProductImage]
    var metaData : [MetaData]
    var count: Int = 0
    
    init(id: Int, name: String, permalink: String, desc: String, shortDescription: String, status: String, price: String, categories: [Category], images: [ProductImage], metaData: [MetaData], count: Int) {
        self.id = id
        self.name = name
        self.permalink = permalink
        self.desc = desc
        self.shortDescription = shortDescription
        self.status = status
        self.price = price
        self.categories = categories
        self.images = images
        self.metaData = metaData
        self.count = count
    }
}
