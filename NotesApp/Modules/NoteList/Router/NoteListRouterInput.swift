import Foundation

protocol NoteListRouterInput {
    func showNoteDetailModule(with note: Note, output: NoteEditModuleOutput)
    func showAddNoteAlertModule(output: AddNoteAlertModuleOutput)
    func showDeleteNoteAlert()
}
