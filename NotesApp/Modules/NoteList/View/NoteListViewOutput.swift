import Foundation

protocol NoteListViewOutput {
    func viewDidLoad()
    
    func fetchNotes()
    
    func noteDidTap(_ note: Note)
    
    func toggleSortInAscendingOrder()
    
    func addNoteButtonDidTap()
    
    func deleteNoteButtonTap(_ note: Note)
    
    func deleteNotesButtonDidTap()
    
    func collectionViewItemsBecomeEmpty()
}
