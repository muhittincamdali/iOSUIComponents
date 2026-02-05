import UIKit

// MARK: - Custom Alert View
/// Customizable alert view with various styles
public final class AlertView: UIView {
    
    // MARK: - Alert Style
    public enum Style {
        case info
        case success
        case warning
        case error
        case custom(UIColor)
        
        var color: UIColor {
            switch self {
            case .info: return .systemBlue
            case .success: return .systemGreen
            case .warning: return .systemOrange
            case .error: return .systemRed
            case .custom(let color): return color
            }
        }
        
        var icon: String {
            switch self {
            case .info: return "info.circle.fill"
            case .success: return "checkmark.circle.fill"
            case .warning: return "exclamationmark.triangle.fill"
            case .error: return "xmark.circle.fill"
            case .custom: return "bell.fill"
            }
        }
    }
    
    // MARK: - Alert Action
    public struct Action {
        public let title: String
        public let style: ActionStyle
        public let handler: (() -> Void)?
        
        public enum ActionStyle {
            case `default`
            case destructive
            case cancel
        }
        
        public init(title: String, style: ActionStyle = .default, handler: (() -> Void)? = nil) {
            self.title = title
            self.style = style
            self.handler = handler
        }
    }
    
    // MARK: - UI Elements
    private let containerView = UIView()
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let messageLabel = UILabel()
    private let buttonStackView = UIStackView()
    private let dimView = UIView()
    
    // MARK: - Properties
    private var style: Style = .info
    private var actions: [Action] = []
    private var onDismiss: (() -> Void)?
    
    // MARK: - Initialization
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - Setup
    private func setupUI() {
        let theme = ThemeManager.shared.currentTheme
        
        backgroundColor = .clear
        
        dimView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        dimView.alpha = 0
        addSubview(dimView)
        
        containerView.backgroundColor = theme.backgroundColor
        containerView.layer.cornerRadius = theme.cornerRadiusLarge
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.2
        containerView.layer.shadowRadius = 16
        containerView.layer.shadowOffset = CGSize(width: 0, height: 8)
        containerView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        containerView.alpha = 0
        addSubview(containerView)
        
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = style.color
        
        titleLabel.font = theme.fontSemibold.withSize(18)
        titleLabel.textColor = theme.textPrimaryColor
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        messageLabel.font = theme.fontRegular.withSize(15)
        messageLabel.textColor = theme.textSecondaryColor
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 12
        
        containerView.addSubview(iconImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(messageLabel)
        containerView.addSubview(buttonStackView)
        
        setupConstraints()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dimViewTapped))
        dimView.addGestureRecognizer(tapGesture)
    }
    
    private func setupConstraints() {
        dimView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dimView.topAnchor.constraint(equalTo: topAnchor),
            dimView.bottomAnchor.constraint(equalTo: bottomAnchor),
            dimView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dimView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 300),
            
            iconImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 24),
            iconImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 48),
            iconImageView.heightAnchor.constraint(equalToConstant: 48),
            
            titleLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            
            buttonStackView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 24),
            buttonStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            buttonStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            buttonStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -24),
            buttonStackView.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc private func dimViewTapped() {
        dismiss()
    }
    
    // MARK: - Configuration
    public func configure(
        style: Style,
        title: String,
        message: String,
        actions: [Action]
    ) {
        self.style = style
        self.actions = actions
        
        iconImageView.image = UIImage(systemName: style.icon)
        iconImageView.tintColor = style.color
        titleLabel.text = title
        messageLabel.text = message
        
        setupButtons()
    }
    
    private func setupButtons() {
        buttonStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for action in actions {
            let button: BaseButton
            
            switch action.style {
            case .default:
                let primary = PrimaryButton()
                primary.normalBackgroundColor = style.color
                button = primary
            case .destructive:
                button = DestructiveButton()
            case .cancel:
                button = SecondaryButton()
            }
            
            button.setTitle(action.title, for: .normal)
            button.addAction(UIAction { [weak self] _ in
                action.handler?()
                self?.dismiss()
            }, for: .touchUpInside)
            
            buttonStackView.addArrangedSubview(button)
        }
    }
    
    // MARK: - Presentation
    public func show(in view: UIView, completion: (() -> Void)? = nil) {
        frame = view.bounds
        view.addSubview(self)
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0) {
            self.dimView.alpha = 1
            self.containerView.alpha = 1
            self.containerView.transform = .identity
        } completion: { _ in
            completion?()
        }
        
        AccessibilityHelper.announceScreenChange(titleLabel.text ?? "Alert")
    }
    
    public func dismiss(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.2) {
            self.dimView.alpha = 0
            self.containerView.alpha = 0
            self.containerView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        } completion: { _ in
            self.removeFromSuperview()
            self.onDismiss?()
            completion?()
        }
    }
    
    // MARK: - Convenience Methods
    public static func showInfo(
        title: String,
        message: String,
        in view: UIView,
        action: Action = Action(title: "OK")
    ) {
        let alert = AlertView()
        alert.configure(style: .info, title: title, message: message, actions: [action])
        alert.show(in: view)
    }
    
    public static func showSuccess(
        title: String,
        message: String,
        in view: UIView,
        action: Action = Action(title: "OK")
    ) {
        let alert = AlertView()
        alert.configure(style: .success, title: title, message: message, actions: [action])
        alert.show(in: view)
    }
    
    public static func showError(
        title: String,
        message: String,
        in view: UIView,
        action: Action = Action(title: "OK")
    ) {
        let alert = AlertView()
        alert.configure(style: .error, title: title, message: message, actions: [action])
        alert.show(in: view)
    }
    
    public static func showConfirm(
        title: String,
        message: String,
        in view: UIView,
        confirmTitle: String = "Confirm",
        cancelTitle: String = "Cancel",
        onConfirm: @escaping () -> Void,
        onCancel: (() -> Void)? = nil
    ) {
        let alert = AlertView()
        alert.configure(
            style: .warning,
            title: title,
            message: message,
            actions: [
                Action(title: cancelTitle, style: .cancel, handler: onCancel),
                Action(title: confirmTitle, style: .default, handler: onConfirm)
            ]
        )
        alert.show(in: view)
    }
}

// MARK: - Action Sheet
/// Custom action sheet with iOS-style appearance
public final class ActionSheet: UIView {
    
    // MARK: - Action
    public struct Action {
        public let title: String
        public let icon: String?
        public let style: Style
        public let handler: (() -> Void)?
        
        public enum Style {
            case `default`
            case destructive
            case cancel
        }
        
        public init(title: String, icon: String? = nil, style: Style = .default, handler: (() -> Void)? = nil) {
            self.title = title
            self.icon = icon
            self.style = style
            self.handler = handler
        }
    }
    
    // MARK: - UI Elements
    private let dimView = UIView()
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let messageLabel = UILabel()
    private let actionsStackView = UIStackView()
    private let cancelButton = UIButton(type: .system)
    
    // MARK: - Properties
    private var actions: [Action] = []
    private var cancelAction: Action?
    
    // MARK: - Initialization
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - Setup
    private func setupUI() {
        let theme = ThemeManager.shared.currentTheme
        
        backgroundColor = .clear
        
        dimView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        dimView.alpha = 0
        addSubview(dimView)
        
        containerView.backgroundColor = theme.surfaceColor
        containerView.layer.cornerRadius = 16
        containerView.clipsToBounds = true
        addSubview(containerView)
        
        titleLabel.font = theme.fontSemibold.withSize(14)
        titleLabel.textColor = theme.textSecondaryColor
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        messageLabel.font = theme.fontRegular.withSize(13)
        messageLabel.textColor = theme.textSecondaryColor
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        
        actionsStackView.axis = .vertical
        actionsStackView.spacing = 0
        
        cancelButton.backgroundColor = theme.backgroundColor
        cancelButton.setTitleColor(theme.primaryColor, for: .normal)
        cancelButton.titleLabel?.font = theme.fontSemibold.withSize(17)
        cancelButton.layer.cornerRadius = 16
        cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        addSubview(cancelButton)
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(messageLabel)
        containerView.addSubview(actionsStackView)
        
        setupConstraints()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cancelTapped))
        dimView.addGestureRecognizer(tapGesture)
    }
    
    private func setupConstraints() {
        dimView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        actionsStackView.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dimView.topAnchor.constraint(equalTo: topAnchor),
            dimView.bottomAnchor.constraint(equalTo: bottomAnchor),
            dimView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dimView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            cancelButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8),
            cancelButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            cancelButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            cancelButton.heightAnchor.constraint(equalToConstant: 56),
            
            containerView.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -8),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            actionsStackView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16),
            actionsStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            actionsStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            actionsStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    @objc private func cancelTapped() {
        cancelAction?.handler?()
        dismiss()
    }
    
    // MARK: - Configuration
    public func configure(
        title: String?,
        message: String?,
        actions: [Action]
    ) {
        titleLabel.text = title
        titleLabel.isHidden = title == nil
        
        messageLabel.text = message
        messageLabel.isHidden = message == nil
        
        actionsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for action in actions {
            if action.style == .cancel {
                cancelAction = action
                cancelButton.setTitle(action.title, for: .normal)
            } else {
                addActionButton(action)
            }
        }
    }
    
    private func addActionButton(_ action: Action) {
        let theme = ThemeManager.shared.currentTheme
        
        let button = UIButton(type: .system)
        button.setTitle(action.title, for: .normal)
        button.titleLabel?.font = theme.fontRegular.withSize(17)
        button.contentHorizontalAlignment = .center
        
        if action.style == .destructive {
            button.setTitleColor(theme.errorColor, for: .normal)
        } else {
            button.setTitleColor(theme.primaryColor, for: .normal)
        }
        
        if let iconName = action.icon {
            let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)
            button.setImage(UIImage(systemName: iconName, withConfiguration: config), for: .normal)
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        }
        
        button.addAction(UIAction { [weak self] _ in
            action.handler?()
            self?.dismiss()
        }, for: .touchUpInside)
        
        let separator = UIView()
        separator.backgroundColor = theme.borderColor
        separator.translatesAutoresizingMaskIntoConstraints = false
        
        actionsStackView.addArrangedSubview(separator)
        actionsStackView.addArrangedSubview(button)
        
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 0.5),
            button.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    // MARK: - Presentation
    public func show(in view: UIView) {
        frame = view.bounds
        view.addSubview(self)
        
        containerView.transform = CGAffineTransform(translationX: 0, y: 300)
        cancelButton.transform = CGAffineTransform(translationX: 0, y: 300)
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.85, initialSpringVelocity: 0) {
            self.dimView.alpha = 1
            self.containerView.transform = .identity
            self.cancelButton.transform = .identity
        }
    }
    
    public func dismiss() {
        UIView.animate(withDuration: 0.25) {
            self.dimView.alpha = 0
            self.containerView.transform = CGAffineTransform(translationX: 0, y: 300)
            self.cancelButton.transform = CGAffineTransform(translationX: 0, y: 300)
        } completion: { _ in
            self.removeFromSuperview()
        }
    }
}

// MARK: - Toast View
/// Toast notification view
public final class ToastView: UIView {
    
    // MARK: - Style
    public enum Style {
        case info
        case success
        case warning
        case error
        
        var color: UIColor {
            switch self {
            case .info: return .systemBlue
            case .success: return .systemGreen
            case .warning: return .systemOrange
            case .error: return .systemRed
            }
        }
        
        var icon: String {
            switch self {
            case .info: return "info.circle.fill"
            case .success: return "checkmark.circle.fill"
            case .warning: return "exclamationmark.triangle.fill"
            case .error: return "xmark.circle.fill"
            }
        }
    }
    
    // MARK: - Position
    public enum Position {
        case top
        case bottom
    }
    
    // MARK: - UI Elements
    private let containerView = UIView()
    private let iconImageView = UIImageView()
    private let messageLabel = UILabel()
    private let closeButton = UIButton(type: .system)
    
    // MARK: - Properties
    private var style: Style = .info
    private var displayDuration: TimeInterval = 3.0
    private var dismissTimer: Timer?
    
    // MARK: - Initialization
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - Setup
    private func setupUI() {
        let theme = ThemeManager.shared.currentTheme
        
        containerView.backgroundColor = theme.textPrimaryColor
        containerView.layer.cornerRadius = 12
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.15
        containerView.layer.shadowRadius = 8
        containerView.layer.shadowOffset = CGSize(width: 0, height: 4)
        addSubview(containerView)
        
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .white
        
        messageLabel.font = theme.fontMedium.withSize(14)
        messageLabel.textColor = .white
        messageLabel.numberOfLines = 2
        
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .white.withAlphaComponent(0.7)
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        
        containerView.addSubview(iconImageView)
        containerView.addSubview(messageLabel)
        containerView.addSubview(closeButton)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            iconImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            iconImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),
            
            messageLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12),
            messageLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            messageLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
            messageLabel.trailingAnchor.constraint(equalTo: closeButton.leadingAnchor, constant: -8),
            
            closeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            closeButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            closeButton.widthAnchor.constraint(equalToConstant: 24),
            closeButton.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeGesture.direction = [.up, .down]
        addGestureRecognizer(swipeGesture)
    }
    
    @objc private func closeTapped() {
        dismiss()
    }
    
    @objc private func handleSwipe() {
        dismiss()
    }
    
    // MARK: - Configuration
    public func configure(style: Style, message: String, duration: TimeInterval = 3.0) {
        self.style = style
        self.displayDuration = duration
        
        iconImageView.image = UIImage(systemName: style.icon)
        messageLabel.text = message
        
        // Update container color based on style
        containerView.backgroundColor = style.color
    }
    
    // MARK: - Presentation
    public func show(in view: UIView, position: Position = .top) {
        view.addSubview(self)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        let topConstraint: NSLayoutConstraint
        let bottomConstraint: NSLayoutConstraint
        
        if position == .top {
            topConstraint = topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8)
            bottomConstraint = topConstraint
            transform = CGAffineTransform(translationX: 0, y: -100)
        } else {
            topConstraint = bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
            bottomConstraint = topConstraint
            transform = CGAffineTransform(translationX: 0, y: 100)
        }
        
        NSLayoutConstraint.activate([
            topConstraint,
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            heightAnchor.constraint(greaterThanOrEqualToConstant: 48)
        ])
        
        view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0) {
            self.transform = .identity
        }
        
        dismissTimer = Timer.scheduledTimer(withTimeInterval: displayDuration, repeats: false) { [weak self] _ in
            self?.dismiss()
        }
        
        AccessibilityHelper.announce(messageLabel.text ?? "")
    }
    
    public func dismiss() {
        dismissTimer?.invalidate()
        dismissTimer = nil
        
        UIView.animate(withDuration: 0.2) {
            self.alpha = 0
            self.transform = CGAffineTransform(translationX: 0, y: -20)
        } completion: { _ in
            self.removeFromSuperview()
        }
    }
    
    // MARK: - Convenience Methods
    public static func show(
        style: Style,
        message: String,
        in view: UIView,
        position: Position = .top,
        duration: TimeInterval = 3.0
    ) {
        let toast = ToastView()
        toast.configure(style: style, message: message, duration: duration)
        toast.show(in: view, position: position)
    }
}

// MARK: - Badge View
/// Badge indicator for counts and notifications
@IBDesignable
public final class BadgeView: UIView {
    
    // MARK: - Properties
    @IBInspectable public var value: Int = 0 {
        didSet { updateBadge() }
    }
    
    @IBInspectable public var maxValue: Int = 99
    @IBInspectable public var badgeColor: UIColor = .systemRed {
        didSet { backgroundColor = badgeColor }
    }
    @IBInspectable public var textColor: UIColor = .white {
        didSet { label.textColor = textColor }
    }
    
    private let label = UILabel()
    
    // MARK: - Initialization
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = badgeColor
        clipsToBounds = true
        
        label.font = .systemFont(ofSize: 11, weight: .bold)
        label.textColor = textColor
        label.textAlignment = .center
        addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6)
        ])
        
        updateBadge()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }
    
    private func updateBadge() {
        if value <= 0 {
            isHidden = true
            label.text = nil
        } else {
            isHidden = false
            label.text = value > maxValue ? "\(maxValue)+" : "\(value)"
            
            // Animate on value change
            if !AccessibilityHelper.isReduceMotionEnabled {
                transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0) {
                    self.transform = .identity
                }
            }
        }
    }
    
    public override var intrinsicContentSize: CGSize {
        let labelSize = label.intrinsicContentSize
        let width = max(labelSize.width + 12, 18)
        return CGSize(width: width, height: 18)
    }
}
