import Foundation

protocol ViewConfiguration {
    func buildViewHierarchy()
    func setupContraints()
    func configureViews()
}

extension ViewConfiguration {
    func buildLayout() {
        configureViews()
        buildViewHierarchy()
        setupContraints()
    }
}
