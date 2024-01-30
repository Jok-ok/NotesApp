import UIKit

final class NoteCollectionViewCell: UICollectionViewCell {
    // MARK: - Private properties
    private let titleLabel = UILabel()
    private let divider = UIView()
    private let textLabel = UILabel()
    private let updatedAtLabel = UILabel()
    private let deleteNoteButton = UIButton()
    
    var deleteDelegate: NoteCollectionViewCellDeleteDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with title: String, text: String, updatedAt: Date, deleteButtonIsHidden: Bool = false) {
        titleLabel.text = title == "" ? " " : title
        textLabel.text = text
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        
        updatedAtLabel.text = formatter.string(from: updatedAt)
        
        let deleteAction = UIAction { [weak self] action in
            guard let self = self else { return }
            self.deleteDelegate?.delete(cell: self)
        }
        
        deleteNoteButton.addAction(deleteAction, for: .touchUpInside)
        deleteNoteButton.isHidden = deleteButtonIsHidden
        if !deleteButtonIsHidden {
            UIView.animate(withDuration: 0.5) { [weak self] in
                self?.deleteNoteButton.alpha = 1
            }
        }
        else if deleteNoteButton.alpha == 1 {
            UIView.animate(withDuration: 0.5) { [weak self] in
                self?.deleteNoteButton.alpha = 0
            }
        }
    }
}

// MARK: Appearance
private extension NoteCollectionViewCell {
    func configureAppearance() {
        backgroundColor = .noteBackground
        layer.cornerRadius = 10
        layer.shadowOffset = .init(width: 2, height: 4)
        layer.shadowOpacity = 0.1
        layer.shadowColor = UIColor.black.cgColor
        
        configureTitleLabelAppearance()
        configureDeleteNoteButton()
        configureDivider()
        configureShortLabelAppearance()
        configureUpdatedAtLabel()

        addSubview(titleLabel)
        addSubview(deleteNoteButton)
        addSubview(divider)
        addSubview(textLabel)
        addSubview(updatedAtLabel)
        
        constraintTitleLabel()
        constraintDeleteNoteButton()
        constraintDivider()
        constraintShortLabel()
        constraintUpdatedAtLabel()
    }
    
    func configureTitleLabelAppearance() {
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textColor = .font
        
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.numberOfLines = 1
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureDeleteNoteButton() {
        deleteNoteButton.setImage(.init(systemName: "xmark"), for: .normal)
        deleteNoteButton.tintColor = .deleteMark
        deleteNoteButton.alpha = 0
        
        deleteNoteButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureDivider() {
        divider.backgroundColor = .noteDivider
        divider.layer.cornerRadius = 2
        divider.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureShortLabelAppearance() {
        textLabel.font = .systemFont(ofSize: 14)
        textLabel.textColor = .font
        
        textLabel.numberOfLines = 3
        textLabel.lineBreakMode = .byTruncatingTail
        textLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureUpdatedAtLabel() {
        updatedAtLabel.font = .systemFont(ofSize: 12)
        updatedAtLabel.textColor = .secondaryText
        
        updatedAtLabel.numberOfLines = 1
        updatedAtLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Constraints
    func constraintTitleLabel() {
        let constraints = [
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: deleteNoteButton.leadingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func constraintDeleteNoteButton() {
        let constraints = [
            deleteNoteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            deleteNoteButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            deleteNoteButton.widthAnchor.constraint(equalTo: deleteNoteButton.heightAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func constraintDivider() {
        let constraints = [
            divider.leadingAnchor.constraint(equalTo: leadingAnchor),
            divider.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            divider.heightAnchor.constraint(equalToConstant: 1),
            divider.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func constraintShortLabel() {
        let constraints = [
            textLabel.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 5),
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func constraintUpdatedAtLabel() {
        let constraints = [
            updatedAtLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            updatedAtLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
