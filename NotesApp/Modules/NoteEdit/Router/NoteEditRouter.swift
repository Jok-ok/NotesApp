import UIKit

final class NoteEditRouter: NoteEditRouterInput {
    var view: UIViewController?
    
    func closeModule() {
        view?.navigationController?.popViewController(animated: true)
    }
}
