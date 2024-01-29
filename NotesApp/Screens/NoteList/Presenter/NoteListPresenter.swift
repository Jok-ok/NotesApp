final class NoteListPresenter: NoteListViewOutput, NoteListModuleInput {
    weak var view: NoteListViewInput?
    var router: NoteListRouterInput?
    var output: NoteListModuleOutput?
    var model: NoteListDataModel?
    private var ascendingOrder = false
    
    func viewDidLoad() {
        view?.setupInitialState(model: NoteListPresenterModel())
//        addNote(title: "SomeTitle", text: "LoremIpsumText LoremIpsumText LoremIpsumText LoremIpsumText LoremIpsumText LoremIpsumText")
        fetchNotes()
    }
    
    func fetchNotes() {
        model?.fetchAllNotes(completion: { [weak self] notes in
            self?.view?.updateNotes(with: notes ?? [])
        }, ascending: ascendingOrder)
    }
    
    func noteDidTap(_ note: Note) {
        
    }
    
    func toggleSortInAscendingOrder() {
        self.ascendingOrder.toggle()
        fetchNotes()
    }
    
    func addNote() {
        
//        model?.addNote(title: title, text: text, updatedAt: .now)
        fetchNotes()
    }
}
