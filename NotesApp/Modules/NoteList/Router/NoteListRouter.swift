import UIKit

final class NoteListRouter: NoteListRouterInput {
    weak var view: UIViewController?
    
    func showNoteDetailModule(with note: Note, output: NoteEditModuleOutput) {
        let nextModuleView = NoteEditModuleConfigurator().configure(with: note, output: output)
        view?.navigationController?.pushViewController(nextModuleView, animated: true)
    }
    
    func showAddNoteAlertModule(output: AddNoteAlertModuleOutput) {
        let alertController = AddNoteAlertController(title: nil, message: nil, preferredStyle: .alert)
        alertController.configure(output: output)
        view?.present(alertController, animated: true)
    }
    
    func showDeleteNoteAlert() {
        //
    }
}
