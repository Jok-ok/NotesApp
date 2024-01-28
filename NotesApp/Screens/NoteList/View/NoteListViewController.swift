import UIKit

class NoteListViewController: UIViewController, NoteListViewInput {
    
    var output: NoteListViewOutput?

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
    }
    func setupInitialState(model: NoteListPresenterModel) {
        configureAppearance(model: model)
    }
}

//MARK: - Appearance
private extension NoteListViewController {
    func configureAppearance(model: NoteListPresenterModel) {
    }
}

private extension NoteListViewController {
    
}
