import UIKit

final class NoteCollectionViewAdapter: NSObject {
    // MARK: - Properties
    
    private let output: NoteCollectionViewAdapterOutput
    private var items: [Note]
    private var deleteMode = false
    
    private var collectionView: UICollectionView
    
    // MARK: - Init
    
    init(output: NoteCollectionViewAdapterOutput, collectionView: UICollectionView) {
        self.output = output
        items = []
        self.collectionView = collectionView
        super.init()
        
        setupCollection()
    }
    
    func configure(with items: [Note], deleteMode: Bool = false) {
        self.items = items
        self.deleteMode = deleteMode
        collectionView.reloadData()
    }
    
    func setDeleteMode(_ deleteMode: Bool) {
        self.deleteMode = deleteMode
        collectionView.reloadData()
    }
    
    // MARK: - Private methods
    private func setupCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(
            NoteCollectionViewCell.self,
            forCellWithReuseIdentifier: .init(describing: NoteCollectionViewCell.self))
    
    }
}

// MARK: - UICollectionViewDataSource
extension NoteCollectionViewAdapter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: .init(describing: NoteCollectionViewCell.self),
            for: indexPath) as? NoteCollectionViewCell else { return UICollectionViewCell()}
        
        cell.configure(with: items[indexPath.item].title ?? "",
                       text: items[indexPath.item].text ?? "",
                       updatedAt: items[indexPath.item].updatedAt ?? .now, deleteButtonIsHidden: !deleteMode)
        cell.deleteDelegate = self
        
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate
extension NoteCollectionViewAdapter: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        output.didSelectNoteView(items[indexPath.item])
    }
}

extension NoteCollectionViewAdapter: NoteCollectionViewCellDeleteDelegate {
    func delete(cell: NoteCollectionViewCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        
        output.didDeleteNote(items[indexPath.item])
        
        items.remove(at: indexPath.item)
        
        collectionView.deleteItems(at: [indexPath])
    }
    
}
