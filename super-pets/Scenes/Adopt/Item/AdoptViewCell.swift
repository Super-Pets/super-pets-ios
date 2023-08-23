import UIKit

final class AdoptViewCell: UICollectionViewCell, ViewConfiguration {
    private lazy var content: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var petImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = UIColor(named: Strings.Color.rouse)
        image.layer.cornerRadius = 20
        return image
    }()
    
    var animalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Akina"
        label.textColor = UIColor(named: Strings.Color.darkGray)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout()
    }
    
    required init?(coder: NSCoder) { nil }
    
    func configureViews() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func buildViewHierarchy() {
        addSubview(content)
        content.addSubview(mainStack)
        mainStack.addArrangedSubview(petImage)
        mainStack.addArrangedSubview(animalLabel)
    }
    
    func setupContraints() {
        NSLayoutConstraint.activate([
            content.topAnchor.constraint(equalTo: topAnchor),
            content.leadingAnchor.constraint(equalTo: leadingAnchor),
            content.trailingAnchor.constraint(equalTo: trailingAnchor),
            content.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            mainStack.topAnchor.constraint(equalTo: content.topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: content.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: content.trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: content.bottomAnchor),
            
            petImage.widthAnchor.constraint(equalToConstant: 162),
            petImage.heightAnchor.constraint(equalToConstant: 162)
        ])
    }
}
