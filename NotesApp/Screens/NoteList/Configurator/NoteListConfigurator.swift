import UIKit
import CoreData.NSManagedObjectContext

final class NoteListConfigurator {
    func configure(with output: NoteListModuleOutput? = nil, context: NSManagedObjectContext) -> UIViewController {
        let view = NoteListViewController()
        let presenter = NoteListPresenter()
        let router = NoteListRouter()
        let model = NoteListDataModel(context: context)
        
        presenter.model = model
        presenter.view = view
        presenter.router = router
        presenter.output = output
        
        router.view = view
        view.output = presenter
        
        return view
    }
}
