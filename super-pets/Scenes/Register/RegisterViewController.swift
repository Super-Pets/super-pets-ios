import UIKit

final class RegisterViewController: UIViewController, ViewConfiguration {
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var nameTextField = RegisterTextFieldComponent(placeholderText: "Nome do pet")
    
    private lazy var speciesTextField = RegisterTextFieldComponent(placeholderText: "Espécie")
    
    private lazy var genderTextField = RegisterTextFieldComponent(placeholderText: "Sexo")
    
    private lazy var ageTextField = RegisterTextFieldComponent(placeholderText: "Idade")
    
    private lazy var sizeTextField = RegisterTextFieldComponent(placeholderText: "Porte")
    
    private lazy var stateTextField = RegisterTextFieldComponent(placeholderText: "Cidade")
    
    private lazy var vaccineTextField = RegisterTextFieldComponent(placeholderText: "Vacinas")
    
    private lazy var castrationTextField = RegisterTextFieldComponent(placeholderText: "É castrado?")
    
    private lazy var descriptionTextField = RegisterTextFieldComponent(placeholderText: "Fale um pouco sobre ele")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
        title = "Cadastre um animal"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let customButton = UIButton(type: .system)
        customButton.setTitle("Voltar", for: .normal)
        customButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        let navigationButton = UIBarButtonItem(customView: customButton)
        self.navigationItem.leftBarButtonItem = navigationButton
    }
    
    @objc
    func buttonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func configureViews() {
        view.backgroundColor = UIColor(named: Strings.Color.rouse)
    }
    
    func buildViewHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(mainStack)
        mainStack.addArrangedSubview(nameTextField)
        mainStack.addArrangedSubview(speciesTextField)
        mainStack.addArrangedSubview(genderTextField)
        mainStack.addArrangedSubview(ageTextField)
        mainStack.addArrangedSubview(sizeTextField)
        mainStack.addArrangedSubview(stateTextField)
        mainStack.addArrangedSubview(vaccineTextField)
        mainStack.addArrangedSubview(castrationTextField)
        mainStack.addArrangedSubview(descriptionTextField)
    }
    
    func setupContraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.heightAnchor),
            
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
        ])
    }
}
