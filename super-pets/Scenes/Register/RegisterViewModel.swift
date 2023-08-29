import Foundation

protocol RegisterViewModelProtocol {
    func registerAnimal(name: String, species: String, gender: String, age: String, size: String, state: String, vaccines: String, castration: Bool, description: String, onSuccess: @escaping () -> Void, onFailure: @escaping (String) -> Void)
    func boolValue(from string: String?) -> Bool? 
}

final class RegisterViewModel: RegisterViewModelProtocol {
    private let apiService: ApiServiceProtocol
    
    init(apiService: ApiServiceProtocol) {
        self.apiService = apiService
    }
    
    func registerAnimal(name: String, species: String, gender: String, age: String, size: String, state: String, vaccines: String, castration: Bool, description: String, onSuccess: @escaping () -> Void, onFailure: @escaping (String) -> Void) {
        let animal = RegisterAnimalParams(
            name: name,
            specie: species,
            animalDescription: description,
            gender: gender,
            age: age,
            size: size,
            state: state,
            vaccine: vaccines,
            castration: castration,
            image: ""
        )
        
        apiService.registerAnimal(animal: animal) { result in
            switch result {
            case .success(_):
                onSuccess()
            case .failure(let error):
                onFailure(error.localizedDescription)
            }
        }
    }
    
    func boolValue(from string: String?) -> Bool? {
        guard let string = string?.lowercased() else { return nil }
        
        if string == "sim" || string == "verdadeiro" || string == "yes" || string == "true" {
            return true
        } else if string == "não" || string == "falso" || string == "no" || string == "false" {
            return false
        } else {
            return nil
        }
    }
}
