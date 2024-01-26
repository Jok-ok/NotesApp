final class NoteListPresenter: NoteListViewOutput, NoteListModuleInput {
    weak var view: NoteListViewInput?
    var router: NoteListRouterInput?
    var output: NoteListModuleOutput?
    
    func viewDidLoad() {
        view?.setupInitialState(model: NoteListPresenterModel())
    }
    
    func noteDidTap() {
        
    }
}
