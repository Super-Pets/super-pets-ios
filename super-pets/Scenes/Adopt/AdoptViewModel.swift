import Foundation

protocol AdoptViewModelDelegate: AnyObject {
    func didFetchAnimals(_ animals: [AnimalsModel])
    func didDeleteAnimal(at index: Int)
}

protocol AdoptViewModelProtocol {
    func getAnimals()
    func deleteAnimal(withId id: String, at index: Int)
    var delegate: AdoptViewModelDelegate? { get set }
}

final class AdoptViewModel: AdoptViewModelProtocol {
    
    private let apiService: ApiServiceProtocol
    
    weak var delegate: AdoptViewModelDelegate?
    
    init(apiService: ApiServiceProtocol) {
        self.apiService = apiService
    }
    
    private var response: [AnimalsModel]?
    
    func getAnimals() {
        apiService.fetchAdoptables { [weak self] result in
            switch result {
            case .success(let response):
                self?.response = response
                self?.delegate?.didFetchAnimals(response)
            case .failure(_):
                break
            }
        }
    }
    
    func deleteAnimal(withId id: String, at index: Int) {
        apiService.deleteAnimal(byId: id) { [weak self] result in
            switch result {
            case .success():
                self?.response?.remove(at: index)
                self?.delegate?.didDeleteAnimal(at: index)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
