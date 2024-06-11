import Foundation

// Define your Article struct including the embedded media.
struct Article: Codable, Identifiable {
    let id: Int
    let title: Rendered
    let content: Rendered

    struct Rendered: Codable {
        let rendered: String
    }
}
struct Product: Codable, Identifiable, Equatable {
    var id: Int?
    var name: String?
    var permalink: String?
    var desc: String?
    var shortDescription: String?
    var status: String?
    var price: String?
    var categories: [Category]?
    var images: [ProductImage]?
    var metaData: [MetaData]?
    var count: Int? = 0

    enum CodingKeys: String, CodingKey {
        case id, name, permalink, status, price, categories, images
        case shortDescription = "short_description"
        case metaData = "meta_data"
        case desc = "description"
    }
 
    static func == (lhs: Product, rhs: Product) -> Bool {
        lhs.id == rhs.id
    }
}

struct Playlist : Codable, Identifiable {
    var id: Int
    var name: String
    var description: String
    var image: ProductImage
    var count : Int

    enum CodingKeys: String, CodingKey {
        case id, name, description, image,count
    }
}

// Define a structure for categories, assuming each category has an id and a name

// Define a structure for product images, assuming each image has a URL
struct ProductImage: Codable {
    var src: String  // URL to the image
    var name: String
    var alt: String
}


struct MetaData : Codable {
    var id : Int
    var key : String
    var value : String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.key = try container.decode(String.self, forKey: .key)
        do {
            self.value = try container.decode(String.self, forKey: .value)
        } catch {
            self.value = ""
        }
    }
}
struct LocalProduct {
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
    var count : Int = 0
}
