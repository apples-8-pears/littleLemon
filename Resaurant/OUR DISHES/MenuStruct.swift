import Foundation

struct JSONMenu: Codable {
    let items: [MenuItem]
    
    enum CodingKeys: String, CodingKey {
        case items = "menu"
    }
}


struct MenuItem: Codable, Hashable, Identifiable {
    let id = UUID()
    let title: String
    let price: String
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case price = "price"
    }
}
