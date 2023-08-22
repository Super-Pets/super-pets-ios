import UIKit

final class HomeViewController: UIViewController, ViewConfiguration {
    private lazy var bgView: UIView = {
        let content = UIView()
        content.backgroundColor = UIColor(named: Strings.Color.white)
        content.layer.cornerRadius = 20
        content.translatesAutoresizingMaskIntoConstraints = false
        return content
    }()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var appLabel: UILabel = {
        let label = UILabel()
        label.text = "SuperPets"
        label.textColor = UIColor(named: Strings.Color.rouse)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Adoção é um ato de amor e responsabilidade"
        label.textColor = UIColor(named: Strings.Color.darkGray)
        label.font = UIFont.italicSystemFont(ofSize: 26)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var bgImage: UIImageView = {
        let image = UIImageView()
        image.image = .init(named: Strings.Images.Ilustrations.familyPets)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var buttonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var adoptButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Quero adotar", for: .normal)
        button.setTitleColor(UIColor(named: Strings.Color.darkGray), for: .normal)
        button.backgroundColor = UIColor(named: Strings.Color.orange)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Quero divulgar um animal", for: .normal)
        button.setTitleColor(UIColor(named: Strings.Color.darkGray), for: .normal)
        button.backgroundColor = UIColor(named: Strings.Color.purple)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(registerAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
    }
    
    @objc
    private func registerAction() {
        self.navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
    func configureViews() {
        view.backgroundColor = UIColor(named: Strings.Color.background)
    }
    
    func buildViewHierarchy() {
        view.addSubview(bgView)
        view.addSubview(mainStack)
        mainStack.addArrangedSubview(appLabel)
        mainStack.addArrangedSubview(titleLabel)
        mainStack.addArrangedSubview(bgImage)
        view.addSubview(buttonStack)
        buttonStack.addArrangedSubview(adoptButton)
        buttonStack.addArrangedSubview(registerButton)
    }
    
    func setupContraints() {
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -60),
            bgView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bgView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bgView.heightAnchor.constraint(equalToConstant: 500),
            
            mainStack.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 20),
            mainStack.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 20),
            mainStack.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -20),
            mainStack.bottomAnchor.constraint(equalTo: bgView.bottomAnchor),
            
            bgImage.heightAnchor.constraint(equalToConstant: 200),
            bgImage.widthAnchor.constraint(equalToConstant: 100),
            
            buttonStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            buttonStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            buttonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            adoptButton.heightAnchor.constraint(equalToConstant: 70),
            
            registerButton.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
}
