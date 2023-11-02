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
    
    private lazy var mainButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Cadastrar nenem", for: .normal)
        button.setTitleColor(UIColor(named: Strings.Color.darkGray), for: .normal)
        button.backgroundColor = UIColor(named: Strings.Color.lightPurple)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(mainButtonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
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
    
    private let viewModel: RegisterViewModelProtocol
    
    init(viewModel: RegisterViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    @objc
    private func buttonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func mainButtonAction() {
        guard let castrationValidation = viewModel.boolValue(from: castrationTextField.getCurrentText()) else {
            return
        }
        
        viewModel.registerAnimal(
            name: nameTextField.getCurrentText(),
            species: speciesTextField.getCurrentText(),
            gender: genderTextField.getCurrentText(),
            age: ageTextField.getAge(),
            size: sizeTextField.getCurrentText(),
            state: stateTextField.getCurrentText(),
            vaccines: vaccineTextField.getCurrentText(),
            castration: castrationValidation,
            description: descriptionTextField.getCurrentText()) { [weak self] in
                DispatchQueue.main.async {
                    self?.successAlert()
                }
            } onFailure: { _ in
                DispatchQueue.main.async {
                    self.errorAlert()
                }
            }
    }
    
    private func successAlert() {
        let alertController = UIAlertController(title: "Cadastro concluido",
                                                message: "Nenê cadastrado com sucesso!! Você pode visualizar ele pela opção 'Quero adotar' na tela anterior <3",
                                                preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Legal", style: .default) { [weak self] (action) in
            self?.navigationController?.popViewController(animated: true)
        }
        
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true)
    }
    
    private func errorAlert() {
        let alertController = UIAlertController(title: "Não deu certo",
                                                message: "Nos desculpe, mas tente novamente. Parece que deu ruim aqui",
                                                preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Poxa..", style: .destructive) { [weak self] (action) in
            self?.navigationController?.popViewController(animated: true)
        }
        
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true)
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
        mainStack.addArrangedSubview(mainButton)
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
            
            mainButton.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
}
