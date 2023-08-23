import Foundation

protocol ViewConfiguration {
    func configureViews()
    func buildViewHierarchy()
    func setupContraints()
}

extension ViewConfiguration {
    func buildLayout() {
        configureViews()
        buildViewHierarchy()
        setupContraints()
    }
}
