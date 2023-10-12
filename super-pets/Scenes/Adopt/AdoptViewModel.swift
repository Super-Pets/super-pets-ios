import Foundation

protocol AdoptViewModelDelegate: AnyObject {
    func didFetchAnimals(_ animals: [AnimalsModel])
}

protocol AdoptViewModelProtocol {
    func getAnimals()
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
}
