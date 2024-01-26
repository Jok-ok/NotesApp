import UIKit

final class NoteListConfigurator {
    func configure(with output: NoteListModuleOutput? = nil) -> UIViewController {
        let view = NoteListViewController()
        let presenter = NoteListPresenter()
        let router = NoteListRouter()
        
        presenter.view = view
        presenter.router = router
        presenter.output = output
        
        router.view = view
        view.output = presenter
        
        return view
    }
}
