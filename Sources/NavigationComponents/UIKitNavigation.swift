import UIKit

// MARK: - Custom Navigation Bar
/// Custom navigation bar with enhanced features
@IBDesignable
public final class CustomNavigationBar: UIView {
    
    // MARK: - IBInspectable
    @IBInspectable public var title: String = "" {
        didSet { titleLabel.text = title }
    }
    
    @IBInspectable public var subtitle: String = "" {
        didSet { 
            subtitleLabel.text = subtitle
            subtitleLabel.isHidden = subtitle.isEmpty
        }
    }
    
    @IBInspectable public var showShadow: Bool = true {
        didSet { updateShadow() }
    }
    
    @IBInspectable public var isLargeTitle: Bool = false {
        didSet { updateTitleSize() }
    }
    
    // MARK: - UI Elements
    public let titleLabel = UILabel()
    public let subtitleLabel = UILabel()
    public let leftButton = UIButton(type: .system)
    public let rightButton = UIButton(type: .system)
    public let rightButton2 = UIButton(type: .system)
    
    private let titleStackView = UIStackView()
    private let contentStackView = UIStackView()
    
    // MARK: - Callbacks
    public var onLeftButtonTap: (() -> Void)?
    public var onRightButtonTap: (() -> Void)?
    public var onRightButton2Tap: (() -> Void)?
    
    // MARK: - Initialization
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupUI()
        setupConstraints()
        updateShadow()
    }
    
    // MARK: - Setup
    private func setupUI() {
        let theme = ThemeManager.shared.currentTheme
        
        backgroundColor = theme.backgroundColor
        
        titleLabel.font = theme.fontSemibold.withSize(17)
        titleLabel.textColor = theme.textPrimaryColor
        titleLabel.textAlignment = .center
        
        subtitleLabel.font = .systemFont(ofSize: 12)
        subtitleLabel.textColor = theme.textSecondaryColor
        subtitleLabel.textAlignment = .center
        subtitleLabel.isHidden = true
        
        titleStackView.axis = .vertical
        titleStackView.alignment = .center
        titleStackView.spacing = 2
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(subtitleLabel)
        
        leftButton.tintColor = theme.primaryColor
        leftButton.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
        leftButton.isHidden = true
        
        rightButton.tintColor = theme.primaryColor
        rightButton.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
        rightButton.isHidden = true
        
        rightButton2.tintColor = theme.primaryColor
        rightButton2.addTarget(self, action: #selector(rightButton2Tapped), for: .touchUpInside)
        rightButton2.isHidden = true
    }
    
    private func setupConstraints() {
        let rightStackView = UIStackView(arrangedSubviews: [rightButton2, rightButton])
        rightStackView.axis = .horizontal
        rightStackView.spacing = 16
        
        addSubview(leftButton)
        addSubview(titleStackView)
        addSubview(rightStackView)
        
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        rightStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leftButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            leftButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            leftButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 44),
            leftButton.heightAnchor.constraint(equalToConstant: 44),
            
            titleStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleStackView.leadingAnchor.constraint(greaterThanOrEqualTo: leftButton.trailingAnchor, constant: 8),
            titleStackView.trailingAnchor.constraint(lessThanOrEqualTo: rightStackView.leadingAnchor, constant: -8),
            
            rightStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            rightStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func updateShadow() {
        if showShadow {
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = 0.1
            layer.shadowRadius = 4
            layer.shadowOffset = CGSize(width: 0, height: 2)
        } else {
            layer.shadowOpacity = 0
        }
    }
    
    private func updateTitleSize() {
        titleLabel.font = isLargeTitle 
            ? .systemFont(ofSize: 34, weight: .bold)
            : ThemeManager.shared.currentTheme.fontSemibold.withSize(17)
    }
    
    // MARK: - Actions
    @objc private func leftButtonTapped() {
        onLeftButtonTap?()
    }
    
    @objc private func rightButtonTapped() {
        onRightButtonTap?()
    }
    
    @objc private func rightButton2Tapped() {
        onRightButton2Tap?()
    }
    
    // MARK: - Configuration
    public func setLeftButton(icon: String, action: @escaping () -> Void) {
        leftButton.setImage(UIImage(systemName: icon), for: .normal)
        leftButton.isHidden = false
        onLeftButtonTap = action
    }
    
    public func setLeftButton(title: String, action: @escaping () -> Void) {
        leftButton.setTitle(title, for: .normal)
        leftButton.isHidden = false
        onLeftButtonTap = action
    }
    
    public func setRightButton(icon: String, action: @escaping () -> Void) {
        rightButton.setImage(UIImage(systemName: icon), for: .normal)
        rightButton.isHidden = false
        onRightButtonTap = action
    }
    
    public func setRightButton(title: String, action: @escaping () -> Void) {
        rightButton.setTitle(title, for: .normal)
        rightButton.isHidden = false
        onRightButtonTap = action
    }
    
    public func setSecondRightButton(icon: String, action: @escaping () -> Void) {
        rightButton2.setImage(UIImage(systemName: icon), for: .normal)
        rightButton2.isHidden = false
        onRightButton2Tap = action
    }
    
    public func setBackButton(action: @escaping () -> Void) {
        setLeftButton(icon: "chevron.left", action: action)
    }
    
    public func setCloseButton(action: @escaping () -> Void) {
        setLeftButton(icon: "xmark", action: action)
    }
}

// MARK: - Custom Tab Bar
/// Custom tab bar with badge support and animations
@IBDesignable
public final class CustomTabBar: UIView {
    
    // MARK: - Properties
    public var items: [TabBarItem] = [] {
        didSet { setupTabs() }
    }
    
    public var selectedIndex: Int = 0 {
        didSet { updateSelection() }
    }
    
    public var onTabSelected: ((Int) -> Void)?
    
    @IBInspectable public var selectedColor: UIColor = .systemBlue
    @IBInspectable public var unselectedColor: UIColor = .systemGray
    @IBInspectable public var badgeColor: UIColor = .systemRed
    
    // MARK: - Private Properties
    private let stackView = UIStackView()
    private var tabButtons: [TabBarButton] = []
    private let selectionIndicator = UIView()
    
    // MARK: - Initialization
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        let theme = ThemeManager.shared.currentTheme
        
        backgroundColor = theme.backgroundColor
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 8
        layer.shadowOffset = CGSize(width: 0, height: -2)
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        addSubview(stackView)
        
        selectionIndicator.backgroundColor = selectedColor
        selectionIndicator.layer.cornerRadius = 2
        addSubview(selectionIndicator)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        selectionIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            selectionIndicator.topAnchor.constraint(equalTo: topAnchor),
            selectionIndicator.heightAnchor.constraint(equalToConstant: 4)
        ])
    }
    
    private func setupTabs() {
        tabButtons.forEach { $0.removeFromSuperview() }
        tabButtons.removeAll()
        
        for (index, item) in items.enumerated() {
            let button = TabBarButton()
            button.configure(with: item, isSelected: index == selectedIndex)
            button.selectedColor = selectedColor
            button.unselectedColor = unselectedColor
            button.badgeColor = badgeColor
            button.tag = index
            button.addTarget(self, action: #selector(tabTapped(_:)), for: .touchUpInside)
            
            tabButtons.append(button)
            stackView.addArrangedSubview(button)
        }
        
        updateSelection()
    }
    
    @objc private func tabTapped(_ sender: UIButton) {
        let newIndex = sender.tag
        guard newIndex != selectedIndex else { return }
        
        selectedIndex = newIndex
        onTabSelected?(newIndex)
        
        // Haptic feedback
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    private func updateSelection() {
        for (index, button) in tabButtons.enumerated() {
            button.isSelected = index == selectedIndex
        }
        
        layoutIfNeeded()
        updateIndicatorPosition()
    }
    
    private func updateIndicatorPosition() {
        guard !tabButtons.isEmpty, selectedIndex < tabButtons.count else { return }
        
        let selectedButton = tabButtons[selectedIndex]
        let indicatorWidth = selectedButton.bounds.width * 0.4
        
        let targetFrame = CGRect(
            x: selectedButton.frame.midX - indicatorWidth / 2,
            y: 0,
            width: indicatorWidth,
            height: 4
        )
        
        if !AccessibilityHelper.isReduceMotionEnabled {
            UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0) {
                self.selectionIndicator.frame = targetFrame
            }
        } else {
            selectionIndicator.frame = targetFrame
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        updateIndicatorPosition()
    }
    
    /// Set badge for tab
    public func setBadge(_ value: String?, at index: Int) {
        guard index < tabButtons.count else { return }
        tabButtons[index].badgeValue = value
    }
    
    /// Set badge count for tab
    public func setBadgeCount(_ count: Int, at index: Int) {
        setBadge(count > 0 ? (count > 99 ? "99+" : "\(count)") : nil, at: index)
    }
}

// MARK: - Tab Bar Item
public struct TabBarItem {
    public let icon: String
    public let selectedIcon: String?
    public let title: String
    
    public init(icon: String, selectedIcon: String? = nil, title: String) {
        self.icon = icon
        self.selectedIcon = selectedIcon
        self.title = title
    }
}

// MARK: - Tab Bar Button
private class TabBarButton: UIControl {
    
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let badgeLabel = UILabel()
    private let stackView = UIStackView()
    
    var selectedColor: UIColor = .systemBlue
    var unselectedColor: UIColor = .systemGray
    var badgeColor: UIColor = .systemRed
    
    private var item: TabBarItem?
    
    var badgeValue: String? {
        didSet { updateBadge() }
    }
    
    override var isSelected: Bool {
        didSet { updateAppearance() }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = unselectedColor
        
        titleLabel.font = .systemFont(ofSize: 10, weight: .medium)
        titleLabel.textColor = unselectedColor
        titleLabel.textAlignment = .center
        
        badgeLabel.font = .systemFont(ofSize: 10, weight: .bold)
        badgeLabel.textColor = .white
        badgeLabel.backgroundColor = badgeColor
        badgeLabel.textAlignment = .center
        badgeLabel.layer.cornerRadius = 8
        badgeLabel.clipsToBounds = true
        badgeLabel.isHidden = true
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 2
        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.isUserInteractionEnabled = false
        
        addSubview(stackView)
        addSubview(badgeLabel)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        badgeLabel.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),
            
            badgeLabel.topAnchor.constraint(equalTo: iconImageView.topAnchor, constant: -4),
            badgeLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: -8),
            badgeLabel.heightAnchor.constraint(equalToConstant: 16),
            badgeLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 16)
        ])
    }
    
    func configure(with item: TabBarItem, isSelected: Bool) {
        self.item = item
        self.isSelected = isSelected
        
        titleLabel.text = item.title
        updateAppearance()
        
        isAccessibilityElement = true
        accessibilityLabel = item.title
        accessibilityTraits = isSelected ? [.button, .selected] : .button
    }
    
    private func updateAppearance() {
        let color = isSelected ? selectedColor : unselectedColor
        let iconName: String
        
        if isSelected, let selectedIcon = item?.selectedIcon {
            iconName = selectedIcon
        } else {
            iconName = item?.icon ?? ""
        }
        
        iconImageView.image = UIImage(systemName: iconName)
        iconImageView.tintColor = color
        titleLabel.textColor = color
        
        let scale: CGFloat = isSelected ? 1.1 : 1.0
        
        if !AccessibilityHelper.isReduceMotionEnabled {
            UIView.animate(withDuration: 0.2) {
                self.iconImageView.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        } else {
            iconImageView.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
    }
    
    private func updateBadge() {
        if let value = badgeValue, !value.isEmpty {
            badgeLabel.text = " \(value) "
            badgeLabel.backgroundColor = badgeColor
            badgeLabel.isHidden = false
            
            accessibilityValue = "\(value) notifications"
        } else {
            badgeLabel.isHidden = true
            accessibilityValue = nil
        }
    }
}

// MARK: - Breadcrumb Navigation
/// Horizontal breadcrumb navigation
public final class BreadcrumbView: UIView {
    
    public struct Crumb {
        public let title: String
        public let action: (() -> Void)?
        
        public init(title: String, action: (() -> Void)? = nil) {
            self.title = title
            self.action = action
        }
    }
    
    public var crumbs: [Crumb] = [] {
        didSet { updateCrumbs() }
    }
    
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        scrollView.showsHorizontalScrollIndicator = false
        addSubview(scrollView)
        
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        scrollView.addSubview(stackView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
    }
    
    private func updateCrumbs() {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let theme = ThemeManager.shared.currentTheme
        
        for (index, crumb) in crumbs.enumerated() {
            let isLast = index == crumbs.count - 1
            
            let button = UIButton(type: .system)
            button.setTitle(crumb.title, for: .normal)
            button.titleLabel?.font = isLast ? theme.fontSemibold.withSize(14) : theme.fontRegular.withSize(14)
            button.setTitleColor(isLast ? theme.textPrimaryColor : theme.primaryColor, for: .normal)
            button.tag = index
            
            if !isLast, let action = crumb.action {
                button.addAction(UIAction { _ in action() }, for: .touchUpInside)
            }
            
            stackView.addArrangedSubview(button)
            
            if !isLast {
                let separator = UIImageView(image: UIImage(systemName: "chevron.right"))
                separator.tintColor = theme.textSecondaryColor
                separator.contentMode = .scaleAspectFit
                NSLayoutConstraint.activate([
                    separator.widthAnchor.constraint(equalToConstant: 12),
                    separator.heightAnchor.constraint(equalToConstant: 12)
                ])
                stackView.addArrangedSubview(separator)
            }
        }
    }
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 44)
    }
}

// MARK: - Page Control
/// Custom page control with customizable indicators
@IBDesignable
public final class CustomPageControl: UIView {
    
    // MARK: - Properties
    @IBInspectable public var numberOfPages: Int = 0 {
        didSet { updateIndicators() }
    }
    
    @IBInspectable public var currentPage: Int = 0 {
        didSet { updateSelection() }
    }
    
    @IBInspectable public var indicatorColor: UIColor = .systemGray4
    @IBInspectable public var currentIndicatorColor: UIColor = .systemBlue
    @IBInspectable public var indicatorSize: CGFloat = 8
    @IBInspectable public var indicatorSpacing: CGFloat = 8
    
    public var onPageChange: ((Int) -> Void)?
    
    private let stackView = UIStackView()
    private var indicators: [UIView] = []
    
    // MARK: - Initialization
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = indicatorSpacing
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        addGestureRecognizer(tapGesture)
    }
    
    private func updateIndicators() {
        indicators.forEach { $0.removeFromSuperview() }
        indicators.removeAll()
        
        for i in 0..<numberOfPages {
            let indicator = UIView()
            indicator.backgroundColor = i == currentPage ? currentIndicatorColor : indicatorColor
            indicator.layer.cornerRadius = indicatorSize / 2
            indicator.tag = i
            
            NSLayoutConstraint.activate([
                indicator.widthAnchor.constraint(equalToConstant: indicatorSize),
                indicator.heightAnchor.constraint(equalToConstant: indicatorSize)
            ])
            
            indicators.append(indicator)
            stackView.addArrangedSubview(indicator)
        }
    }
    
    private func updateSelection() {
        for (index, indicator) in indicators.enumerated() {
            let isCurrent = index == currentPage
            let width = isCurrent ? indicatorSize * 2.5 : indicatorSize
            
            if !AccessibilityHelper.isReduceMotionEnabled {
                UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0) {
                    indicator.backgroundColor = isCurrent ? self.currentIndicatorColor : self.indicatorColor
                    indicator.constraints.first { $0.firstAttribute == .width }?.constant = width
                    indicator.layer.cornerRadius = isCurrent ? self.indicatorSize / 2 : self.indicatorSize / 2
                    self.stackView.layoutIfNeeded()
                }
            } else {
                indicator.backgroundColor = isCurrent ? currentIndicatorColor : indicatorColor
            }
        }
    }
    
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: stackView)
        
        for (index, indicator) in indicators.enumerated() {
            if indicator.frame.contains(location) {
                currentPage = index
                onPageChange?(index)
                break
            }
        }
    }
    
    public override var intrinsicContentSize: CGSize {
        let width = CGFloat(numberOfPages) * indicatorSize + CGFloat(numberOfPages - 1) * indicatorSpacing
        return CGSize(width: width, height: indicatorSize)
    }
}
