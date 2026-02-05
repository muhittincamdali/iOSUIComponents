import UIKit

// MARK: - Skeleton Loading View
/// Animated skeleton loading placeholder
@IBDesignable
public final class SkeletonView: UIView {
    
    // MARK: - Properties
    @IBInspectable public var skeletonColor: UIColor = .systemGray5 {
        didSet { gradientLayer.colors = [skeletonColor.cgColor, shimmerColor.cgColor, skeletonColor.cgColor] }
    }
    
    @IBInspectable public var shimmerColor: UIColor = .systemGray4 {
        didSet { gradientLayer.colors = [skeletonColor.cgColor, shimmerColor.cgColor, skeletonColor.cgColor] }
    }
    
    @IBInspectable public var cornerRadius: CGFloat = 4 {
        didSet { layer.cornerRadius = cornerRadius }
    }
    
    private let gradientLayer = CAGradientLayer()
    private var isAnimating = false
    
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
        backgroundColor = skeletonColor
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
        
        gradientLayer.colors = [
            skeletonColor.cgColor,
            shimmerColor.cgColor,
            skeletonColor.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.locations = [0, 0.5, 1]
        layer.addSublayer(gradientLayer)
        
        isAccessibilityElement = true
        accessibilityLabel = "Loading"
        accessibilityTraits = .updatesFrequently
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = CGRect(x: -bounds.width, y: 0, width: bounds.width * 3, height: bounds.height)
        
        if isAnimating {
            startAnimating()
        }
    }
    
    // MARK: - Animation
    public func startAnimating() {
        guard !AccessibilityHelper.isReduceMotionEnabled else { return }
        
        isAnimating = true
        
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.fromValue = 0
        animation.toValue = bounds.width * 2
        animation.duration = 1.5
        animation.repeatCount = .infinity
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        gradientLayer.add(animation, forKey: "shimmer")
    }
    
    public func stopAnimating() {
        isAnimating = false
        gradientLayer.removeAllAnimations()
    }
}

// MARK: - Skeleton Container
/// Container for skeleton loading with preset layouts
public final class SkeletonContainer: UIView {
    
    // MARK: - Layout Types
    public enum Layout {
        case card
        case list
        case profile
        case article
        case custom([SkeletonElement])
    }
    
    public struct SkeletonElement {
        public let frame: CGRect
        public let cornerRadius: CGFloat
        
        public init(frame: CGRect, cornerRadius: CGFloat = 4) {
            self.frame = frame
            self.cornerRadius = cornerRadius
        }
    }
    
    // MARK: - Properties
    private var skeletonViews: [SkeletonView] = []
    
    // MARK: - Configuration
    public func configure(layout: Layout) {
        skeletonViews.forEach { $0.removeFromSuperview() }
        skeletonViews.removeAll()
        
        let elements: [SkeletonElement]
        
        switch layout {
        case .card:
            elements = [
                SkeletonElement(frame: CGRect(x: 0, y: 0, width: bounds.width, height: 160), cornerRadius: 8),
                SkeletonElement(frame: CGRect(x: 16, y: 176, width: bounds.width - 32, height: 20), cornerRadius: 4),
                SkeletonElement(frame: CGRect(x: 16, y: 204, width: bounds.width - 80, height: 16), cornerRadius: 4),
                SkeletonElement(frame: CGRect(x: 16, y: 228, width: bounds.width - 120, height: 16), cornerRadius: 4)
            ]
        case .list:
            elements = (0..<5).map { i in
                let y = CGFloat(i) * 72
                return [
                    SkeletonElement(frame: CGRect(x: 16, y: y + 16, width: 40, height: 40), cornerRadius: 20),
                    SkeletonElement(frame: CGRect(x: 72, y: y + 16, width: bounds.width - 104, height: 16), cornerRadius: 4),
                    SkeletonElement(frame: CGRect(x: 72, y: y + 38, width: bounds.width - 160, height: 14), cornerRadius: 4)
                ]
            }.flatMap { $0 }
        case .profile:
            elements = [
                SkeletonElement(frame: CGRect(x: bounds.width / 2 - 40, y: 16, width: 80, height: 80), cornerRadius: 40),
                SkeletonElement(frame: CGRect(x: bounds.width / 2 - 60, y: 112, width: 120, height: 20), cornerRadius: 4),
                SkeletonElement(frame: CGRect(x: bounds.width / 2 - 80, y: 140, width: 160, height: 14), cornerRadius: 4),
                SkeletonElement(frame: CGRect(x: 16, y: 180, width: bounds.width - 32, height: 44), cornerRadius: 8),
                SkeletonElement(frame: CGRect(x: 16, y: 240, width: bounds.width - 32, height: 100), cornerRadius: 8)
            ]
        case .article:
            elements = [
                SkeletonElement(frame: CGRect(x: 16, y: 16, width: bounds.width - 32, height: 28), cornerRadius: 4),
                SkeletonElement(frame: CGRect(x: 16, y: 52, width: bounds.width - 80, height: 14), cornerRadius: 4),
                SkeletonElement(frame: CGRect(x: 16, y: 82, width: bounds.width - 32, height: 200), cornerRadius: 8),
                SkeletonElement(frame: CGRect(x: 16, y: 298, width: bounds.width - 32, height: 14), cornerRadius: 4),
                SkeletonElement(frame: CGRect(x: 16, y: 318, width: bounds.width - 32, height: 14), cornerRadius: 4),
                SkeletonElement(frame: CGRect(x: 16, y: 338, width: bounds.width - 100, height: 14), cornerRadius: 4)
            ]
        case .custom(let customElements):
            elements = customElements
        }
        
        for element in elements {
            let skeleton = SkeletonView()
            skeleton.frame = element.frame
            skeleton.cornerRadius = element.cornerRadius
            addSubview(skeleton)
            skeletonViews.append(skeleton)
        }
    }
    
    public func startAnimating() {
        skeletonViews.forEach { $0.startAnimating() }
    }
    
    public func stopAnimating() {
        skeletonViews.forEach { $0.stopAnimating() }
    }
}

// MARK: - Empty State View
/// View for displaying empty states
@IBDesignable
public final class EmptyStateView: UIView {
    
    // MARK: - UI Elements
    private let containerView = UIStackView()
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let messageLabel = UILabel()
    private let actionButton = PrimaryButton()
    
    // MARK: - Properties
    public var onAction: (() -> Void)?
    
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
        let theme = ThemeManager.shared.currentTheme
        
        containerView.axis = .vertical
        containerView.alignment = .center
        containerView.spacing = 16
        addSubview(containerView)
        
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = theme.textSecondaryColor
        
        titleLabel.font = theme.fontSemibold.withSize(20)
        titleLabel.textColor = theme.textPrimaryColor
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        messageLabel.font = theme.fontRegular.withSize(15)
        messageLabel.textColor = theme.textSecondaryColor
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        
        actionButton.addTarget(self, action: #selector(actionTapped), for: .touchUpInside)
        actionButton.isHidden = true
        
        containerView.addArrangedSubview(imageView)
        containerView.addArrangedSubview(titleLabel)
        containerView.addArrangedSubview(messageLabel)
        containerView.addArrangedSubview(actionButton)
        
        containerView.setCustomSpacing(24, after: imageView)
        containerView.setCustomSpacing(24, after: messageLabel)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 32),
            containerView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -32),
            
            imageView.widthAnchor.constraint(equalToConstant: 120),
            imageView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    @objc private func actionTapped() {
        onAction?()
    }
    
    // MARK: - Configuration
    public func configure(
        image: UIImage?,
        title: String,
        message: String,
        actionTitle: String? = nil,
        action: (() -> Void)? = nil
    ) {
        imageView.image = image
        imageView.isHidden = image == nil
        titleLabel.text = title
        messageLabel.text = message
        
        if let actionTitle = actionTitle {
            actionButton.setTitle(actionTitle, for: .normal)
            actionButton.isHidden = false
            onAction = action
        } else {
            actionButton.isHidden = true
        }
        
        accessibilityLabel = "\(title). \(message)"
    }
    
    // MARK: - Preset Configurations
    public static func noData(in view: UIView, action: (() -> Void)? = nil) -> EmptyStateView {
        let emptyView = EmptyStateView()
        emptyView.configure(
            image: UIImage(systemName: "tray"),
            title: "No Data",
            message: "There's nothing here yet.",
            actionTitle: action != nil ? "Refresh" : nil,
            action: action
        )
        return emptyView
    }
    
    public static func noResults(in view: UIView, query: String) -> EmptyStateView {
        let emptyView = EmptyStateView()
        emptyView.configure(
            image: UIImage(systemName: "magnifyingglass"),
            title: "No Results",
            message: "We couldn't find anything for \"\(query)\". Try a different search."
        )
        return emptyView
    }
    
    public static func noConnection(in view: UIView, retry: @escaping () -> Void) -> EmptyStateView {
        let emptyView = EmptyStateView()
        emptyView.configure(
            image: UIImage(systemName: "wifi.slash"),
            title: "No Connection",
            message: "Please check your internet connection and try again.",
            actionTitle: "Retry",
            action: retry
        )
        return emptyView
    }
}

// MARK: - Error State View
/// View for displaying error states
@IBDesignable
public final class ErrorStateView: UIView {
    
    // MARK: - Error Type
    public enum ErrorType {
        case generic
        case network
        case server
        case notFound
        case permission
        case custom(icon: String, color: UIColor)
        
        var icon: String {
            switch self {
            case .generic: return "exclamationmark.triangle.fill"
            case .network: return "wifi.slash"
            case .server: return "server.rack"
            case .notFound: return "questionmark.folder.fill"
            case .permission: return "lock.fill"
            case .custom(let icon, _): return icon
            }
        }
        
        var color: UIColor {
            switch self {
            case .generic, .server: return .systemRed
            case .network: return .systemOrange
            case .notFound: return .systemGray
            case .permission: return .systemYellow
            case .custom(_, let color): return color
            }
        }
    }
    
    // MARK: - UI Elements
    private let containerView = UIStackView()
    private let iconContainer = UIView()
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let messageLabel = UILabel()
    private let primaryButton = PrimaryButton()
    private let secondaryButton = SecondaryButton()
    
    // MARK: - Properties
    public var onPrimaryAction: (() -> Void)?
    public var onSecondaryAction: (() -> Void)?
    
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
        let theme = ThemeManager.shared.currentTheme
        
        containerView.axis = .vertical
        containerView.alignment = .center
        containerView.spacing = 16
        addSubview(containerView)
        
        iconContainer.layer.cornerRadius = 40
        iconContainer.backgroundColor = theme.errorColor.withAlphaComponent(0.1)
        
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = theme.errorColor
        iconContainer.addSubview(iconImageView)
        
        titleLabel.font = theme.fontSemibold.withSize(20)
        titleLabel.textColor = theme.textPrimaryColor
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        messageLabel.font = theme.fontRegular.withSize(15)
        messageLabel.textColor = theme.textSecondaryColor
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        
        primaryButton.addTarget(self, action: #selector(primaryTapped), for: .touchUpInside)
        primaryButton.isHidden = true
        
        secondaryButton.addTarget(self, action: #selector(secondaryTapped), for: .touchUpInside)
        secondaryButton.isHidden = true
        
        let buttonStack = UIStackView(arrangedSubviews: [primaryButton, secondaryButton])
        buttonStack.axis = .vertical
        buttonStack.spacing = 12
        buttonStack.alignment = .fill
        
        containerView.addArrangedSubview(iconContainer)
        containerView.addArrangedSubview(titleLabel)
        containerView.addArrangedSubview(messageLabel)
        containerView.addArrangedSubview(buttonStack)
        
        containerView.setCustomSpacing(24, after: iconContainer)
        containerView.setCustomSpacing(24, after: messageLabel)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 32),
            containerView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -32),
            
            iconContainer.widthAnchor.constraint(equalToConstant: 80),
            iconContainer.heightAnchor.constraint(equalToConstant: 80),
            
            iconImageView.centerXAnchor.constraint(equalTo: iconContainer.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 40),
            iconImageView.heightAnchor.constraint(equalToConstant: 40),
            
            buttonStack.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    @objc private func primaryTapped() {
        onPrimaryAction?()
    }
    
    @objc private func secondaryTapped() {
        onSecondaryAction?()
    }
    
    // MARK: - Configuration
    public func configure(
        type: ErrorType,
        title: String,
        message: String,
        primaryActionTitle: String? = nil,
        primaryAction: (() -> Void)? = nil,
        secondaryActionTitle: String? = nil,
        secondaryAction: (() -> Void)? = nil
    ) {
        iconImageView.image = UIImage(systemName: type.icon)
        iconImageView.tintColor = type.color
        iconContainer.backgroundColor = type.color.withAlphaComponent(0.1)
        
        titleLabel.text = title
        messageLabel.text = message
        
        if let title = primaryActionTitle {
            primaryButton.setTitle(title, for: .normal)
            primaryButton.isHidden = false
            onPrimaryAction = primaryAction
        } else {
            primaryButton.isHidden = true
        }
        
        if let title = secondaryActionTitle {
            secondaryButton.setTitle(title, for: .normal)
            secondaryButton.isHidden = false
            onSecondaryAction = secondaryAction
        } else {
            secondaryButton.isHidden = true
        }
        
        accessibilityLabel = "Error: \(title). \(message)"
    }
}

// MARK: - Pull to Refresh
/// Custom pull-to-refresh control
public final class PullToRefreshControl: UIRefreshControl {
    
    private let activityView = UIActivityIndicatorView(style: .medium)
    private let messageLabel = UILabel()
    
    public var refreshingMessage: String = "Updating..."
    public var pullingMessage: String = "Pull to refresh"
    public var readyMessage: String = "Release to refresh"
    
    public override init() {
        super.init()
        setupUI()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        tintColor = .clear
        
        let container = UIView()
        
        activityView.hidesWhenStopped = false
        container.addSubview(activityView)
        
        messageLabel.font = .systemFont(ofSize: 12, weight: .medium)
        messageLabel.textColor = ThemeManager.shared.currentTheme.textSecondaryColor
        messageLabel.text = pullingMessage
        container.addSubview(messageLabel)
        
        activityView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            activityView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            
            messageLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: activityView.trailingAnchor, constant: 8)
        ])
        
        addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            container.centerXAnchor.constraint(equalTo: centerXAnchor),
            container.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    public override func beginRefreshing() {
        super.beginRefreshing()
        activityView.startAnimating()
        messageLabel.text = refreshingMessage
    }
    
    public override func endRefreshing() {
        super.endRefreshing()
        activityView.stopAnimating()
        messageLabel.text = pullingMessage
    }
}

// MARK: - Infinite Scroll
/// Helper for implementing infinite scroll in table/collection views
public final class InfiniteScrollController {
    
    public var onLoadMore: (() -> Void)?
    public var isLoading: Bool = false
    public var hasMoreData: Bool = true
    
    private let threshold: CGFloat
    private weak var scrollView: UIScrollView?
    private var footerView: InfiniteScrollFooterView?
    
    public init(scrollView: UIScrollView, threshold: CGFloat = 200) {
        self.scrollView = scrollView
        self.threshold = threshold
    }
    
    public func checkForLoadMore() {
        guard let scrollView = scrollView,
              !isLoading,
              hasMoreData else { return }
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.height
        
        if offsetY > contentHeight - frameHeight - threshold {
            loadMore()
        }
    }
    
    private func loadMore() {
        isLoading = true
        footerView?.startAnimating()
        onLoadMore?()
    }
    
    public func finishLoading(hasMore: Bool = true) {
        isLoading = false
        hasMoreData = hasMore
        footerView?.stopAnimating()
        
        if !hasMore {
            footerView?.showNoMoreData()
        }
    }
    
    public func createFooterView(width: CGFloat) -> UIView {
        let footer = InfiniteScrollFooterView(frame: CGRect(x: 0, y: 0, width: width, height: 60))
        footerView = footer
        return footer
    }
}

// MARK: - Infinite Scroll Footer View
private final class InfiniteScrollFooterView: UIView {
    
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    private let messageLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        activityIndicator.hidesWhenStopped = true
        addSubview(activityIndicator)
        
        messageLabel.font = .systemFont(ofSize: 13)
        messageLabel.textColor = ThemeManager.shared.currentTheme.textSecondaryColor
        messageLabel.textAlignment = .center
        messageLabel.isHidden = true
        addSubview(messageLabel)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func startAnimating() {
        activityIndicator.startAnimating()
        messageLabel.isHidden = true
    }
    
    func stopAnimating() {
        activityIndicator.stopAnimating()
    }
    
    func showNoMoreData() {
        activityIndicator.stopAnimating()
        messageLabel.text = "No more data"
        messageLabel.isHidden = false
    }
}
