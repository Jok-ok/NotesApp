import Foundation

protocol NoteListViewInput: AnyObject {
    func setupInitialState(model: NoteListPresenterModel)
}
