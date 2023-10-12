import UIKit

final class AdoptViewController: UIViewController, ViewConfiguration {
    private lazy var bgView: UIView = {
        let content = UIView()
        content.backgroundColor = UIColor(named: Strings.Color.white)
        content.layer.cornerRadius = 20
        content.translatesAutoresizingMaskIntoConstraints = false
        return content
    }()
    
    let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }()
    
    private lazy var collection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.register(AdoptViewCell.self, forCellWithReuseIdentifier: "AdoptViewCell")
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
        title = "Adotáveis"
        viewModel?.getAnimals()
        viewModel?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let customButton = UIButton(type: .system)
        customButton.setTitle("Voltar", for: .normal)
        customButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        let navigationButton = UIBarButtonItem(customView: customButton)
        self.navigationItem.leftBarButtonItem = navigationButton
    }
    
    private var viewModel: AdoptViewModelProtocol?
    private var animals: [AnimalsModel] = []
    let mockImageNames = ["jade", "juju"]
    
    init(viewModel: AdoptViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    @objc
    private func buttonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func configureViews() {
        view.backgroundColor = UIColor(named: Strings.Color.background)
    }
    
    func buildViewHierarchy() {
        view.addSubview(bgView)
        bgView.addSubview(collection)
    }
    
    func setupContraints() {
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            bgView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bgView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bgView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            collection.topAnchor.constraint(equalTo: bgView.topAnchor),
            collection.leadingAnchor.constraint(equalTo: bgView.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: bgView.trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: bgView.bottomAnchor),
        ])
    }
}

extension AdoptViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        animals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdoptViewCell", for: indexPath) as? AdoptViewCell else { return UICollectionViewCell() }
        
        let animal = animals[indexPath.row]
        let mockImageName = mockImageNames[indexPath.row % mockImageNames.count]
        cell.update(with: animal, mockImageName: mockImageName)
        
        return cell
    }
}

extension AdoptViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 162, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let totalCellWidth: CGFloat = 162.0 * 2.0
        let totalSpacingWidth = collectionView.frame.width - totalCellWidth
        let spacing = totalSpacingWidth / 3.0
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let totalCellWidth: CGFloat = 162.0 * 2.0
        let totalSpacingWidth = collectionView.frame.width - totalCellWidth
        let sideInset = totalSpacingWidth / 3.0
        return UIEdgeInsets(top: sideInset, left: sideInset, bottom: sideInset, right: sideInset)
    }
}

extension AdoptViewController: AdoptViewModelDelegate {
    func didFetchAnimals(_ animals: [AnimalsModel]) {
        self.animals = animals
        self.collection.reloadData()
    }
}
