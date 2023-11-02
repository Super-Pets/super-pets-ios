import Foundation

struct RegisterAnimalParams: Codable {
    let id: Int
    let name: String
    let description: String
    let species: String
    let gender: String
    let age: Int
    let size: String
    let local: String
    let vaccines: String
    let castration: Bool
}
