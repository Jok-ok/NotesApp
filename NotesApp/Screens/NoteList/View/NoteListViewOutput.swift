import Foundation

protocol NoteListViewOutput {
    func viewDidLoad()
    
    func fetchNotes()
    
    func noteDidTap(_ note: Note)
    
    func toggleSortInAscendingOrder()
    
    func addNote()
}
