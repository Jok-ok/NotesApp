import UIKit

final class NoteCollectionViewCell: UICollectionViewCell {
    let titleLabel = UILabel()
    let divider = UIView()
    let textLabel = UILabel()
    let updatedAtLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with title: String, text: String, updatedAt: Date) {
        titleLabel.text = title
        textLabel.text = text
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        
        updatedAtLabel.text = formatter.string(from: updatedAt)
    }
}

// MARK: Appearance
private extension NoteCollectionViewCell {
    func configureAppearance() {
        backgroundColor = .noteBackground
        layer.cornerRadius = 10
        layer.shadowOffset = .init(width: 2, height: 4)
        layer.shadowOpacity = 0.15
        layer.shadowColor = UIColor.black.cgColor
        
        configureTitleLabelAppearance()
        configureDivider()
        configureShortLabelAppearance()
        configureUpdatedAtLabel()

        addSubview(titleLabel)
        addSubview(divider)
        addSubview(textLabel)
        addSubview(updatedAtLabel)
        
        constraintTitleLabel()
        constraintDivider()
        constraintShortLabel()
        constraintUpdatedAtLabel()
    }
    
    func configureTitleLabelAppearance() {
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.textColor = .font
        
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.numberOfLines = 1
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureDivider() {
        divider.backgroundColor = .noteDivider
        divider.layer.cornerRadius = 2
        divider.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureShortLabelAppearance() {
        textLabel.font = .systemFont(ofSize: 16)
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
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
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
