import UIKit

final class RegisterViewController: UIViewController, ViewConfiguration {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
        title = "Divulgue um animal"
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
        
    }
    
    func setupContraints() {
        
    }
}
