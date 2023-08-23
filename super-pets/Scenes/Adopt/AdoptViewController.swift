import UIKit

final class AdoptViewController: UIViewController, ViewConfiguration {
    private lazy var bgView: UIView = {
        let content = UIView()
        content.backgroundColor = UIColor(named: Strings.Color.white)
        content.layer.cornerRadius = 20
        content.translatesAutoresizingMaskIntoConstraints = false
        return content
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
        title = "Adotáveis"
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
    private func buttonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func configureViews() {
        view.backgroundColor = UIColor(named: Strings.Color.background)
    }
    
    func buildViewHierarchy() {
        view.addSubview(bgView)
    }
    
    func setupContraints() {
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            bgView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bgView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bgView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
