protocol NoteEditViewOutput {
    func viewDidLoad()
    func noteTitleChanged(with title: String)
    func noteTextChanged(with text: String)
    func doneButtonDidTap()
    func viewDidDisapear()
}
