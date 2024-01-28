import UIKit

final class NoteCollectionViewCell: UICollectionViewCell {
    let titleLabel = UILabel()
    let divider = UIView()
    let textLabel = UILabel()
    
    func configure(with title: String, text: String) {
        titleLabel.text = title
        textLabel.text = text
    }
}

// MARK: Appearance
private extension NoteCollectionViewCell {
    func configureAppearance() {
        backgroundColor = .background
        layer.cornerRadius = 10
        
        configureTitleLabelAppearance()
        configureShortLabelAppearance()
        configureDivider()
        
        addSubview(titleLabel)
        addSubview(divider)
        addSubview(textLabel)
        
        constraintTitleLabel()
        constraintShortLabel()
    }
    
    func configureTitleLabelAppearance() {
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.textColor = .font
        
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.numberOfLines = 1
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureDivider() {
        divider.backgroundColor = .black
        divider.layer.cornerRadius = 2
        divider.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureShortLabelAppearance() {
        textLabel.font = .systemFont(ofSize: 16)
        textLabel.textColor = .font
        
        textLabel.numberOfLines = 2
        textLabel.lineBreakMode = .byTruncatingTail
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
    }
    // MARK: - Constraints
    func constraintTitleLabel() {
        let constraints = [
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func constraintDivider() {
        let constraints = [
            divider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            divider.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            divider.heightAnchor.constraint(equalToConstant: 3),
            divider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func constraintShortLabel() {
        let constraints = [
            textLabel.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 5),
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
