import UIKit

class NoteListViewController: UIViewController, NoteListViewInput {
    
    var output: NoteListViewOutput?
    
    // MARK: - Private parameters
    private var collectionViewAdapter: NoteCollectionViewAdapter?
    private var collectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
    }
    
    // MARK: - NoteListViewInput
    func setupInitialState(model: NoteListPresenterModel) {
        setupCollectionView()
        configureAppearance(model: model)
    }
    
    func updateNotes(with notes: [Note]) {
        collectionViewAdapter?.configure(with: notes)
    }
}

// MARK: - Appearance
private extension NoteListViewController {
    func configureAppearance(model: NoteListPresenterModel) {
        view.backgroundColor = .background
        
        guard let collectionView = collectionView else { return }
        
        configureNavigationController(with: model.titleLabel, sortButtonTitle: model.sortLabel)
        
        view.addSubview(collectionView)
        
        constraintCollectionView()
    }
    
    func configureNavigationController(with navigationBarTitle: String, sortButtonTitle: String) {
        title = navigationBarTitle

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(addNote))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: sortButtonTitle, style: .plain, target: self, action: #selector(reverseNotesSort))
        navigationItem.rightBarButtonItem?.tintColor = .systemBlue
        navigationItem.leftBarButtonItem?.tintColor = .systemBlue
    }
    
    func constraintCollectionView() {
        guard let collectionView = collectionView else { return }
        let constraints = [
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

//MARK: - Actions
private extension NoteListViewController {
    @objc func addNote() {
        output?.addNoteButtonDidTap()
    }
    
    @objc func reverseNotesSort() {
        output?.toggleSortInAscendingOrder()
    }
}

// MARK: - CollectionView
private extension NoteListViewController {
    func setupCollectionView() {
        let layout  = configureCollectionViewLayout()
        collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        guard let collectionView = collectionView else { return }
        collectionViewAdapter = NoteCollectionViewAdapter(output: self,
                                                          collectionView: collectionView)
    }
    
    func configureCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1)))
        item.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(150)),
            subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}
// MARK: CollectionViewAdapterOutput
extension NoteListViewController: NoteCollectionViewAdapterOutput {
    func didSelectNoteView(_ note: Note) {
        output?.noteDidTap(note)
    }
}
