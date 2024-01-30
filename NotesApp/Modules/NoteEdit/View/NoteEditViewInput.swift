protocol NoteEditViewInput: AnyObject {
    func setupInitialState(model: NoteEditPresenterModel)
    func setNoteTitleTextFieldText(_ text: String)
    func setNoteTextTextViewText(_ text: String)
}
