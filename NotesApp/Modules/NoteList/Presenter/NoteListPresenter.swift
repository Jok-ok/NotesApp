final class NoteListPresenter: NoteListViewOutput, NoteListModuleInput {
    
    // MARK: - Public properties
    weak var view: NoteListViewInput?
    var router: NoteListRouterInput?
    var output: NoteListModuleOutput?
    var model: NoteListDataModel?
    
    // MARK: - Private properties
    private var noteDeletingMode = false
    private var ascendingOrder = false
    
    // MARK: - NoteListViewOutput
    func viewDidLoad() {
        view?.setupInitialState(model: NoteListPresenterModel())
        fetchNotes()
    }
    
    func fetchNotes() {
        model?.fetchAllNotes(completion: { [weak self] notes in
            self?.view?.updateNotes(with: notes ?? [])
        }, ascending: ascendingOrder)
    }
    
    func noteDidTap(_ note: Note) {
        router?.showNoteDetailModule(with: note, output: self)
    }
    
    func toggleSortInAscendingOrder() {
        self.ascendingOrder.toggle()
        fetchNotes()
    }
    
    func addNoteButtonDidTap() {
        router?.showAddNoteAlertModule(output: self)
        fetchNotes()
    }
    
    func deleteNoteButtonTap(_ note: Note) {
        model?.deleteNote(note)
    }
    
    func deleteNotesButtonDidTap() {
        noteDeletingMode.toggle()
        view?.setCollectionViewToDeleteMode(noteDeletingMode)
    }
    
    func collectionViewItemsBecomeEmpty() {
        noteDeletingMode = false
        view?.setCollectionViewToDeleteMode(noteDeletingMode)
    }
}

// MARK: - AddNoteModelOutput
extension NoteListPresenter: AddNoteAlertModuleOutput {
    func addNote(with title: String) {
        model?.addNote(title: title, text: "", updatedAt: .now)
        fetchNotes()
    }
}

// MARK: - 
extension NoteListPresenter: NoteEditModuleOutput {
    func noteEdited() {
        model?.saveChanges()
    }
    func noteEditingEnded() {
        fetchNotes()
    }
}
