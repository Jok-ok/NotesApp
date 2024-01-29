import UIKit

final class NoteListRouter: NoteListRouterInput {
    
    weak var view: UIViewController?
    
    func showNoteDetailModule() {
        
    }
    
    func showAddNoteAlertModule(output: AddNoteAlertModuleOutput) {
        let alertController = AddNoteAlertController(title: nil, message: nil, preferredStyle: .alert)
        alertController.configure(output: output)
        view?.present(alertController, animated: true)
    }
}
