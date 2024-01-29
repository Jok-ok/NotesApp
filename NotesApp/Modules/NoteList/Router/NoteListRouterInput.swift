import Foundation

protocol NoteListRouterInput {
    func showNoteDetailModule()
    func showAddNoteAlertModule(output: AddNoteAlertModuleOutput)
    func showDeleteNoteAlert()
}
