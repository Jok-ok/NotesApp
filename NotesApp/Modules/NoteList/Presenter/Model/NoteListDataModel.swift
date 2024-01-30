import Foundation
import CoreData

final class NoteListDataModel: NoteListDataModelInput {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func fetchAllNotes(completion: @escaping ([Note]?) -> () , ascending: Bool = true) {
        let request = NSFetchRequest<Note>(entityName: "Note")
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Note.updatedAt, ascending: ascending)
        ]
        
        if let notes = try? context.fetch(request) {
            completion(notes)
        } else {
            completion(nil)
        }
    }
    
    func addNote(title: String, text: String, updatedAt: Date) {
        guard let note = NSEntityDescription.insertNewObject(
            forEntityName: "Note",
            into: context) as? Note else { return }
        note.text = text
        note.title = title
        note.updatedAt = updatedAt
        
        if context.hasChanges {
            do {
                try context.save()
            } catch let error as NSError {
                print("Core Data error: \(error)")
            }
        }
    }
    
    func deleteNote(_ note: Note) {
        context.delete(note)
        if context.hasChanges {
            do {
                try context.save()
            } catch let error as NSError {
                print("Core Data error: \(error)")
            }
        }
    }
    
    func saveChanges() {
        if context.hasChanges {
            do {
                try context.save()
            } catch let error as NSError {
                print("Core Data error: \(error)")
            }
        }
    }
}
