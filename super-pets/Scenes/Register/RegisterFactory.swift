import UIKit

enum RegisterFactory {
    static func build() -> UIViewController {
        let service = ApiService()
        let viewModel = RegisterViewModel(apiService: service)
        return RegisterViewController(viewModel: viewModel)
    }
}
