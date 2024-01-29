import UIKit

final class AddNoteAlertController: UIAlertController {
    private var output: AddNoteAlertModuleOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let model = AddNoteAlertModel()
        
        addTextField()
        
        let addNoteAction = UIAlertAction(title: model.addNoteLabel,
                                      style: .default) { [weak self] action in
            guard let self = self,
                  let textfield = self.textFields?[0] else {return}
            self.output?.addNote(with: textfield.text ?? "")
        }
        let cancelAction = UIAlertAction(title: model.cancelLabel, style: .cancel)
        
        addAction(addNoteAction)
        addAction(cancelAction)
        
        title = model.addNoteTitle
        message = model.addNoteMessage
        
    }
    
    func configure(output: AddNoteAlertModuleOutput) {
        self.output = output
    }
}
