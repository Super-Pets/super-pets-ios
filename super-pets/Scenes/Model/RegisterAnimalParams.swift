import Foundation

struct RegisteranimalParams: Codable {
    let name: String
    let specie: String
    let animalDescription: String
    let gender: String
    let age: String
    let size: String
    let state: String
    let vaccine: String
    let castration: Bool
    let image: String
}
