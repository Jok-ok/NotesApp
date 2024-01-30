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
    
    func setCollectionViewToDeleteMode(_ deleteMode: Bool) {
        collectionViewAdapter?.setDeleteMode(deleteMode)
    }
    
    func setTrashButtonState(with active: Bool) {
        if active {
            navigationItem.rightBarButtonItems?[1].tintColor = .red
        } else
        {
            navigationItem.rightBarButtonItems?[1].tintColor = .accent
        }
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

        let addNoteButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(addNoteButtonDidTap))
        let deleteNotesButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteNotesButtonDidTap))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: sortButtonTitle, style: .plain, target: self, action: #selector(reverseNotesSortButtonDidTap))
        
        navigationItem.rightBarButtonItems = [addNoteButtonItem, deleteNotesButtonItem]
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
    @objc func addNoteButtonDidTap() {
        output?.addNoteButtonDidTap()
    }
    
    @objc func reverseNotesSortButtonDidTap() {
        output?.toggleSortInAscendingOrder()
    }
    
    @objc func deleteNotesButtonDidTap() {
        output?.deleteNotesButtonDidTap()
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
        item.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        
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
    func collectionViewItemsBecomeEmpty() {
        output?.collectionViewItemsBecomeEmpty()
    }
    
    func didDeleteNote(_ note: Note) {
        output?.deleteNoteButtonTap(note)
    }
    
    func didSelectNoteView(_ note: Note) {
        output?.noteDidTap(note)
    }
}
