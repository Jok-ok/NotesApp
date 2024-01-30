import UIKit

final class NoteEditViewController: UIViewController, NoteEditViewInput {
    // MARK: - Private properties
    private let noteTitleTextfield = UITextField()
    private let noteTextTextView = UITextView()
    
    var output: NoteEditViewOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
    }
    
    // MARK: - NoteEditViewInput
    
    func setupInitialState(model: NoteEditPresenterModel) {
        configureAppearance(with: model)
    }
    
    func setNoteTitleTextFieldText(_ text: String) {
        noteTitleTextfield.text = text
    }
    
    func setNoteTextTextViewText(_ text: String) {
        noteTextTextView.text = text
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        output?.viewDidDisapear()
    }
    
}
// MARK: - Appearance
private extension NoteEditViewController {
    func configureAppearance(with model: NoteEditPresenterModel) {
        view.backgroundColor = .background
        
        configureNavigationController(with: model.navigationTitle)
        
        configureNoteTitleTextfield(with: model.noteTitleTextFieldPlaceholder)
        configureNoteTextTextView()
        
        view.addSubview(noteTitleTextfield)
        view.addSubview(noteTextTextView)
        
        constraintNoteTitleTextfield()
        constraintNoteTextTextView()
    }
    
    func configureNavigationController(with title: String) {
        self.title = title
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                            target: self,
                                                            action: #selector(doneButtonDidTap))
    }
    
    func configureNoteTitleTextfield(with placeholder: String) {
        noteTitleTextfield.placeholder = placeholder
        noteTitleTextfield.textColor = .noteEditFont
        noteTitleTextfield.font = .boldSystemFont(ofSize: 24)
        
        noteTitleTextfield.addTarget(self, action: #selector(noteTitleTextFieldDidEdit), for: .editingChanged)
        
        noteTitleTextfield.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureNoteTextTextView() {
        noteTextTextView.textColor = .noteEditFont
        noteTextTextView.font = .systemFont(ofSize: 16)
        noteTextTextView.delegate = self
        
        noteTextTextView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func constraintNoteTitleTextfield() {
        let constraints = [
            noteTitleTextfield.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            noteTitleTextfield.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            noteTitleTextfield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func constraintNoteTextTextView() {
        let constraints = [
            noteTextTextView.topAnchor.constraint(equalTo: noteTitleTextfield.bottomAnchor, constant: 10),
            noteTextTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            noteTextTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            noteTextTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

// MARK: - Actions
private extension NoteEditViewController {
    @objc func noteTitleTextFieldDidEdit(_ textField: UITextField) {
        guard let text = textField.text else { return }
        output?.noteTitleChanged(with: text)
    }
    
     @objc func doneButtonDidTap() {
        output?.doneButtonDidTap()
    }
}

extension NoteEditViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        guard let text = textView.text else { return }
        output?.noteTextChanged(with: text)
    }
}
