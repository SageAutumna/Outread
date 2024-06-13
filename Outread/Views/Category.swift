//
//  Category.swift
//  Outread
//
//  Created by Dhruv Sirohi on 2/4/2024.
//

import SwiftUI

struct CategoryView: View {
    //MARK: - Properties
    let category: Category
    var isViewAll = false
    var didTap: (() -> Void)
    
    //MARK: - Body
    var body: some View {
        Text(category.name ?? "")
            .frame(width: category.name?.lowercased() == "playlist" ? 0 : isViewAll ? (UIScreen.main.bounds.size.width - 120)/2 : 100 , height: 70)
            .foregroundColor(.white)
            .padding(.horizontal, category.name?.lowercased() == "playlist" ? 0 : 20)
            .background(Color(hex: category.colorCategory ?? ""))
            .clipShape(
                RoundedRectangle(cornerRadius: 13, style: .continuous)
            )
            .onTapGesture {
                didTap()
            }
    }
    
    //MARK: - Functions
}

struct CategoriesScrollView: View {
    //MARK: - Properties
    let categories: [Category]
    var products : [Product]
    var isNeedFilter = true
    var didTap: ((Int) -> Void)
    
    //MARK: - Body
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(categories, id: \.id) { category in
                    if isNeedFilter {
                        if filterList(products, categoryName: category.name ?? "").count > 2 {
                            CategoryView(category: category) {
                                didTap(category.id ?? 0)
                            }
                        }
                    } else {
                        CategoryView(category: category) {
                            didTap(category.id ?? 0)
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
    
    //MARK: - Functions
    func filterList(_ list: [Product], categoryName: String) -> [Product] {
        return list
            .filter { $0.categories?.count ?? 0 > 0 }
            .filter{ $0.categories?.contains { cat in cat.name?.lowercased() == categoryName.lowercased() } ?? false }
    }
}

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
    
    /*init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            self.id = try container.decode(Int.self, forKey: .id)
        } catch {
            self.id = 0
        }
        do {
            self.name = try container.decode(String.self, forKey: .name)
        } catch {
            self.name = ""
        }
        do {
            self.parent = try container.decodeIfPresent(Int.self, forKey: .parent)
        } catch {
            self.parent = 0
        }
        do {
            self.colorCategory = try container.decodeIfPresent(String.self, forKey: .colorCategory) ?? ""
        } catch {
            self.colorCategory = ""
        }
    }*/
    
    // A custom initializer isn't strictly necessary unless you are doing additional setup.
    // The synthesized initializer by conforming to Decodable should be sufficient.
}

// Extension to add a method to generate random gradients.

// Extension to add the random color generation to the Color struct.
extension Color {
    static var random: Color {
        Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
    init(hex: String) {
        var cleanHexCode = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanHexCode = cleanHexCode.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        
        Scanner(string: cleanHexCode).scanHexInt64(&rgb)
        
        let redValue = Double((rgb >> 16) & 0xFF) / 255.0
        let greenValue = Double((rgb >> 8) & 0xFF) / 255.0
        let blueValue = Double(rgb & 0xFF) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue)
    }
}
