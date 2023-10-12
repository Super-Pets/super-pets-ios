import UIKit

enum AdoptFactory {
    static func build() -> UIViewController {
        let service = ApiService()
        var viewModel = AdoptViewModel(apiService: service)
        return AdoptViewController(viewModel: viewModel)
    }
}
