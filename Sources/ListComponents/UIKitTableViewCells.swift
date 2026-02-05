import UIKit

// MARK: - Base Table View Cell
/// Base class for custom UIKit table view cells
open class BaseTableViewCell: UITableViewCell {
    
    // MARK: - Static Properties
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    // MARK: - Initialization
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        setupConstraints()
        configureAccessibility()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
        setupConstraints()
        configureAccessibility()
    }
    
    // MARK: - Setup
    open func setupCell() {
        backgroundColor = ThemeManager.shared.currentTheme.backgroundColor
        selectionStyle = .none
    }
    
    open func setupConstraints() {}
    
    open func configureAccessibility() {
        isAccessibilityElement = true
    }
    
    // MARK: - Highlight Animation
    open override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        let alpha: CGFloat = highlighted ? 0.95 : 1.0
        let scale: CGAffineTransform = highlighted ? CGAffineTransform(scaleX: 0.98, y: 0.98) : .identity
        
        if animated && !AccessibilityHelper.isReduceMotionEnabled {
            UIView.animate(withDuration: 0.15) {
                self.contentView.alpha = alpha
                self.contentView.transform = scale
            }
        } else {
            contentView.alpha = alpha
            contentView.transform = scale
        }
    }
}

// MARK: - Standard Cell
/// Standard cell with title, subtitle, and accessory
public final class StandardCell: BaseTableViewCell {
    
    // MARK: - UI Elements
    public let titleLabel = UILabel()
    public let subtitleLabel = UILabel()
    public let leadingImageView = UIImageView()
    public let trailingImageView = UIImageView()
    
    private let stackView = UIStackView()
    
    // MARK: - Setup
    public override func setupCell() {
        super.setupCell()
        
        let theme = ThemeManager.shared.currentTheme
        
        titleLabel.font = theme.fontMedium
        titleLabel.textColor = theme.textPrimaryColor
        titleLabel.numberOfLines = 1
        
        subtitleLabel.font = .systemFont(ofSize: 14)
        subtitleLabel.textColor = theme.textSecondaryColor
        subtitleLabel.numberOfLines = 2
        
        leadingImageView.contentMode = .scaleAspectFit
        leadingImageView.tintColor = theme.primaryColor
        leadingImageView.clipsToBounds = true
        
        trailingImageView.contentMode = .scaleAspectFit
        trailingImageView.tintColor = theme.textSecondaryColor
        trailingImageView.image = UIImage(systemName: "chevron.right")
        
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
    }
    
    public override func setupConstraints() {
        contentView.addSubview(leadingImageView)
        contentView.addSubview(stackView)
        contentView.addSubview(trailingImageView)
        
        leadingImageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        trailingImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leadingImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            leadingImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            leadingImageView.widthAnchor.constraint(equalToConstant: 40),
            leadingImageView.heightAnchor.constraint(equalToConstant: 40),
            
            stackView.leadingAnchor.constraint(equalTo: leadingImageView.trailingAnchor, constant: 12),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingImageView.leadingAnchor, constant: -12),
            
            trailingImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            trailingImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            trailingImageView.widthAnchor.constraint(equalToConstant: 20),
            trailingImageView.heightAnchor.constraint(equalToConstant: 20),
            
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 72)
        ])
    }
    
    /// Configure cell with data
    public func configure(
        title: String,
        subtitle: String? = nil,
        image: UIImage? = nil,
        showAccessory: Bool = true
    ) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        subtitleLabel.isHidden = subtitle == nil
        leadingImageView.image = image
        leadingImageView.isHidden = image == nil
        trailingImageView.isHidden = !showAccessory
        
        accessibilityLabel = title
        if let subtitle = subtitle {
            accessibilityLabel = "\(title), \(subtitle)"
        }
    }
}

// MARK: - Profile Cell
/// Cell for displaying user profile information
public final class ProfileCell: BaseTableViewCell {
    
    // MARK: - UI Elements
    public let avatarImageView = UIImageView()
    public let nameLabel = UILabel()
    public let statusLabel = UILabel()
    public let statusIndicator = UIView()
    
    private let textStackView = UIStackView()
    
    // MARK: - Setup
    public override func setupCell() {
        super.setupCell()
        
        let theme = ThemeManager.shared.currentTheme
        
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = 25
        avatarImageView.backgroundColor = theme.surfaceColor
        
        nameLabel.font = theme.fontSemibold
        nameLabel.textColor = theme.textPrimaryColor
        
        statusLabel.font = .systemFont(ofSize: 14)
        statusLabel.textColor = theme.textSecondaryColor
        
        statusIndicator.backgroundColor = theme.successColor
        statusIndicator.layer.cornerRadius = 6
        
        textStackView.axis = .vertical
        textStackView.spacing = 2
        textStackView.addArrangedSubview(nameLabel)
        textStackView.addArrangedSubview(statusLabel)
    }
    
    public override func setupConstraints() {
        contentView.addSubview(avatarImageView)
        contentView.addSubview(textStackView)
        contentView.addSubview(statusIndicator)
        
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        textStackView.translatesAutoresizingMaskIntoConstraints = false
        statusIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            avatarImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 50),
            avatarImageView.heightAnchor.constraint(equalToConstant: 50),
            
            statusIndicator.trailingAnchor.constraint(equalTo: avatarImageView.trailingAnchor),
            statusIndicator.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            statusIndicator.widthAnchor.constraint(equalToConstant: 12),
            statusIndicator.heightAnchor.constraint(equalToConstant: 12),
            
            textStackView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 12),
            textStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            textStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 72)
        ])
    }
    
    /// Configure cell with profile data
    public func configure(
        name: String,
        status: String?,
        avatar: UIImage?,
        isOnline: Bool = false
    ) {
        nameLabel.text = name
        statusLabel.text = status
        statusLabel.isHidden = status == nil
        avatarImageView.image = avatar ?? UIImage(systemName: "person.circle.fill")
        statusIndicator.isHidden = !isOnline
        
        let onlineStatus = isOnline ? "online" : "offline"
        accessibilityLabel = "\(name), \(onlineStatus)"
        if let status = status {
            accessibilityLabel = "\(name), \(status), \(onlineStatus)"
        }
    }
}

// MARK: - Settings Cell
/// Cell for settings screen with toggle support
public final class SettingsCell: BaseTableViewCell {
    
    // MARK: - UI Elements
    public let iconImageView = UIImageView()
    public let titleLabel = UILabel()
    public let valueLabel = UILabel()
    public let toggle = UISwitch()
    public let accessoryImageView = UIImageView()
    
    private let iconContainer = UIView()
    
    public var onToggleChange: ((Bool) -> Void)?
    
    // MARK: - Setup
    public override func setupCell() {
        super.setupCell()
        
        let theme = ThemeManager.shared.currentTheme
        
        iconContainer.layer.cornerRadius = 6
        iconContainer.backgroundColor = theme.primaryColor
        
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .white
        
        titleLabel.font = theme.fontRegular
        titleLabel.textColor = theme.textPrimaryColor
        
        valueLabel.font = .systemFont(ofSize: 15)
        valueLabel.textColor = theme.textSecondaryColor
        valueLabel.textAlignment = .right
        
        toggle.onTintColor = theme.primaryColor
        toggle.addTarget(self, action: #selector(toggleChanged), for: .valueChanged)
        toggle.isHidden = true
        
        accessoryImageView.image = UIImage(systemName: "chevron.right")
        accessoryImageView.tintColor = theme.textSecondaryColor
        accessoryImageView.contentMode = .scaleAspectFit
    }
    
    public override func setupConstraints() {
        iconContainer.addSubview(iconImageView)
        contentView.addSubview(iconContainer)
        contentView.addSubview(titleLabel)
        contentView.addSubview(valueLabel)
        contentView.addSubview(toggle)
        contentView.addSubview(accessoryImageView)
        
        iconContainer.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        toggle.translatesAutoresizingMaskIntoConstraints = false
        accessoryImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            iconContainer.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconContainer.widthAnchor.constraint(equalToConstant: 32),
            iconContainer.heightAnchor.constraint(equalToConstant: 32),
            
            iconImageView.centerXAnchor.constraint(equalTo: iconContainer.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 18),
            iconImageView.heightAnchor.constraint(equalToConstant: 18),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconContainer.trailingAnchor, constant: 12),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            toggle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            toggle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            valueLabel.trailingAnchor.constraint(equalTo: accessoryImageView.leadingAnchor, constant: -8),
            valueLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            valueLabel.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor, constant: 8),
            
            accessoryImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            accessoryImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            accessoryImageView.widthAnchor.constraint(equalToConstant: 12),
            accessoryImageView.heightAnchor.constraint(equalToConstant: 18),
            
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 52)
        ])
    }
    
    @objc private func toggleChanged() {
        onToggleChange?(toggle.isOn)
    }
    
    /// Configure as navigation cell
    public func configureNavigation(
        icon: UIImage?,
        iconColor: UIColor,
        title: String,
        value: String? = nil
    ) {
        iconContainer.backgroundColor = iconColor
        iconImageView.image = icon
        titleLabel.text = title
        valueLabel.text = value
        valueLabel.isHidden = value == nil
        toggle.isHidden = true
        accessoryImageView.isHidden = false
        
        accessibilityLabel = title
        if let value = value {
            accessibilityValue = value
        }
        accessibilityTraits = .button
    }
    
    /// Configure as toggle cell
    public func configureToggle(
        icon: UIImage?,
        iconColor: UIColor,
        title: String,
        isOn: Bool
    ) {
        iconContainer.backgroundColor = iconColor
        iconImageView.image = icon
        titleLabel.text = title
        toggle.isOn = isOn
        toggle.isHidden = false
        valueLabel.isHidden = true
        accessoryImageView.isHidden = true
        
        accessibilityLabel = title
        accessibilityValue = isOn ? "On" : "Off"
        accessibilityTraits = .none
    }
}

// MARK: - Swipeable Cell
/// Cell with swipe actions
public final class SwipeableCell: BaseTableViewCell {
    
    // MARK: - UI Elements
    public let titleLabel = UILabel()
    public let subtitleLabel = UILabel()
    
    private let containerView = UIView()
    private var deleteAction: (() -> Void)?
    private var editAction: (() -> Void)?
    
    // MARK: - Setup
    public override func setupCell() {
        super.setupCell()
        
        let theme = ThemeManager.shared.currentTheme
        
        containerView.backgroundColor = theme.backgroundColor
        
        titleLabel.font = theme.fontMedium
        titleLabel.textColor = theme.textPrimaryColor
        
        subtitleLabel.font = .systemFont(ofSize: 14)
        subtitleLabel.textColor = theme.textSecondaryColor
    }
    
    public override func setupConstraints() {
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(subtitleLabel)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            subtitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            subtitleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12)
        ])
    }
    
    /// Configure cell
    public func configure(
        title: String,
        subtitle: String?,
        onDelete: (() -> Void)? = nil,
        onEdit: (() -> Void)? = nil
    ) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        subtitleLabel.isHidden = subtitle == nil
        deleteAction = onDelete
        editAction = onEdit
        
        accessibilityLabel = title
        if let subtitle = subtitle {
            accessibilityLabel = "\(title), \(subtitle)"
        }
    }
}

// MARK: - Card Cell
/// Cell with card-style appearance
public final class CardCell: BaseTableViewCell {
    
    // MARK: - UI Elements
    public let cardView = UIView()
    public let imageView = UIImageView()
    public let titleLabel = UILabel()
    public let descriptionLabel = UILabel()
    public let actionButton = PrimaryButton()
    
    // MARK: - Setup
    public override func setupCell() {
        super.setupCell()
        backgroundColor = .clear
        
        let theme = ThemeManager.shared.currentTheme
        
        cardView.backgroundColor = theme.surfaceColor
        cardView.layer.cornerRadius = theme.cornerRadiusLarge
        cardView.layer.shadowColor = theme.shadowColor.cgColor
        cardView.layer.shadowOpacity = 0.1
        cardView.layer.shadowRadius = 8
        cardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = theme.cornerRadiusLarge
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        titleLabel.font = theme.fontSemibold.withSize(18)
        titleLabel.textColor = theme.textPrimaryColor
        titleLabel.numberOfLines = 2
        
        descriptionLabel.font = theme.fontRegular.withSize(14)
        descriptionLabel.textColor = theme.textSecondaryColor
        descriptionLabel.numberOfLines = 3
    }
    
    public override func setupConstraints() {
        contentView.addSubview(cardView)
        cardView.addSubview(imageView)
        cardView.addSubview(titleLabel)
        cardView.addSubview(descriptionLabel)
        cardView.addSubview(actionButton)
        
        cardView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            imageView.topAnchor.constraint(equalTo: cardView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 160),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            
            actionButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            actionButton.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            actionButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            actionButton.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -16),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    /// Configure card cell
    public func configure(
        image: UIImage?,
        title: String,
        description: String,
        buttonTitle: String,
        action: @escaping () -> Void
    ) {
        imageView.image = image
        imageView.isHidden = image == nil
        titleLabel.text = title
        descriptionLabel.text = description
        actionButton.setTitle(buttonTitle, for: .normal)
        actionButton.addAction(UIAction { _ in action() }, for: .touchUpInside)
        
        accessibilityLabel = "\(title). \(description)"
    }
}

// MARK: - Separator Header View
/// Section header with title
public final class SectionHeaderView: UITableViewHeaderFooterView {
    
    public static let reuseIdentifier = "SectionHeaderView"
    
    public let titleLabel = UILabel()
    public let actionButton = UIButton(type: .system)
    
    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        let theme = ThemeManager.shared.currentTheme
        
        titleLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        titleLabel.textColor = theme.textSecondaryColor
        
        actionButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        actionButton.setTitleColor(theme.primaryColor, for: .normal)
        actionButton.isHidden = true
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(actionButton)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            actionButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            actionButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor)
        ])
    }
    
    public func configure(title: String, actionTitle: String? = nil, action: (() -> Void)? = nil) {
        titleLabel.text = title.uppercased()
        
        if let actionTitle = actionTitle {
            actionButton.setTitle(actionTitle, for: .normal)
            actionButton.isHidden = false
            
            if let action = action {
                actionButton.addAction(UIAction { _ in action() }, for: .touchUpInside)
            }
        } else {
            actionButton.isHidden = true
        }
    }
}
