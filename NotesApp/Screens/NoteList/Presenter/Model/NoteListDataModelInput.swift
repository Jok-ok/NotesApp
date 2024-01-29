import Foundation

protocol NoteListDataModelInput {
    func fetchAllNotes(completion: @escaping ([Note]?) -> (), ascending: Bool)
    func addNote(title: String, text: String, updatedAt: Date)
}
