import UIKit

final class HomeViewController: UIViewController {
    
    private lazy var appLabel: UILabel = {
        let label = UILabel()
        label.text = "SuperPets"
        label.textColor = UIColor(named: Strings.Color.rouse)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Adoção é um ato de  amor e responsabilidade"
        label.textColor = UIColor(named: Strings.Color.lightGray)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cellImage: UIImageView = {
        let image = UIImageView()
        image.image = .init(named: Strings.Images.Ilustrations.familyPets)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .cyan
    }
}
