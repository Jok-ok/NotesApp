import Foundation

protocol NoteListViewInput: AnyObject {
    func setupInitialState(model: NoteListPresenterModel)
    func updateNotes(with notes: [Note])
    func setCollectionViewToDeleteMode(_: Bool)
    func setTrashButtonState(with active: Bool)
}
