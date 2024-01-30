final class NoteEditPresenter: NoteEditModuleInput, NoteEditViewOutput {
    
    // MARK: - Properties
    weak var view: NoteEditViewInput?
    var router: NoteEditRouterInput?
    var output: NoteEditModuleOutput?
    
    private var note: Note?
    
    // MARK: - NoteEditViewOutput
    func viewDidLoad() {
        view?.setupInitialState(model: NoteEditPresenterModel())
    }
    
    func noteTitleChanged(with title: String) {
        note?.title = title
        note?.updatedAt = .now
        output?.noteEdited()
    }
    
    func noteTextChanged(with text: String) {
        note?.text = text
        note?.updatedAt = .now
        output?.noteEdited()
    }
    
    func viewDidDisapear() {
        output?.noteEditingEnded()
    }
    
    func doneButtonDidTap() {
        router?.closeModule()
    }
    
    // MARK: - NoteEditModuleInput
    func configureModule(with note: Note) {
        self.note = note
        view?.setNoteTitleTextFieldText(note.title ?? "")
        view?.setNoteTextTextViewText(note.text ?? "")
    }
}
