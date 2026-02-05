import UIKit

// MARK: - Base Button
/// Base class for all custom UIKit buttons with Interface Builder support
@IBDesignable
open class BaseButton: UIButton {
    
    // MARK: - IBInspectable Properties
    @IBInspectable public var cornerRadius: CGFloat = 8 {
        didSet { updateAppearance() }
    }
    
    @IBInspectable public var borderWidth: CGFloat = 0 {
        didSet { updateAppearance() }
    }
    
    @IBInspectable public var borderColor: UIColor = .clear {
        didSet { updateAppearance() }
    }
    
    @IBInspectable public var shadowRadius: CGFloat = 0 {
        didSet { updateShadow() }
    }
    
    @IBInspectable public var shadowOpacity: Float = 0 {
        didSet { updateShadow() }
    }
    
    @IBInspectable public var shadowOffset: CGSize = .zero {
        didSet { updateShadow() }
    }
    
    @IBInspectable public var shadowColor: UIColor = .black {
        didSet { updateShadow() }
    }
    
    @IBInspectable public var normalBackgroundColor: UIColor = .systemBlue {
        didSet { updateStateColors() }
    }
    
    @IBInspectable public var highlightedBackgroundColor: UIColor? {
        didSet { updateStateColors() }
    }
    
    @IBInspectable public var disabledBackgroundColor: UIColor? {
        didSet { updateStateColors() }
    }
    
    // MARK: - Public Properties
    public var hapticFeedback: UIImpactFeedbackGenerator.FeedbackStyle? = .light
    
    // MARK: - Private Properties
    private var feedbackGenerator: UIImpactFeedbackGenerator?
    
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
        setupButton()
        updateAppearance()
        configureAccessibility()
    }
    
    // MARK: - Setup
    open func setupButton() {
        adjustsImageWhenHighlighted = false
        clipsToBounds = true
    }
    
    open func updateAppearance() {
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
    }
    
    private func updateShadow() {
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = shadowOffset
        layer.shadowColor = shadowColor.cgColor
        layer.masksToBounds = shadowOpacity == 0
    }
    
    private func updateStateColors() {
        backgroundColor = normalBackgroundColor
    }
    
    open func configureAccessibility() {
        isAccessibilityElement = true
        accessibilityTraits = .button
    }
    
    // MARK: - State Handling
    open override var isHighlighted: Bool {
        didSet {
            animateStateChange(isHighlighted: isHighlighted)
        }
    }
    
    open override var isEnabled: Bool {
        didSet {
            alpha = isEnabled ? 1.0 : 0.5
            if let disabledBg = disabledBackgroundColor, !isEnabled {
                backgroundColor = disabledBg
            } else {
                backgroundColor = normalBackgroundColor
            }
        }
    }
    
    private func animateStateChange(isHighlighted: Bool) {
        let transform = isHighlighted ? CGAffineTransform(scaleX: 0.96, y: 0.96) : .identity
        let bgColor = isHighlighted ? (highlightedBackgroundColor ?? normalBackgroundColor.adjustBrightness(by: 0.9)) : normalBackgroundColor
        
        if AccessibilityHelper.isReduceMotionEnabled {
            self.transform = transform
            self.backgroundColor = bgColor
        } else {
            UIView.animate(withDuration: 0.15, delay: 0, options: [.allowUserInteraction, .curveEaseOut]) {
                self.transform = transform
                self.backgroundColor = bgColor
            }
        }
    }
    
    // MARK: - Touch Handling
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let style = hapticFeedback {
            feedbackGenerator = UIImpactFeedbackGenerator(style: style)
            feedbackGenerator?.prepare()
        }
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        feedbackGenerator?.impactOccurred()
        feedbackGenerator = nil
    }
    
    // MARK: - Interface Builder
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        updateAppearance()
    }
}

// MARK: - Primary Button
/// Primary action button with filled background
@IBDesignable
public final class PrimaryButton: BaseButton {
    
    public override func setupButton() {
        super.setupButton()
        
        let theme = ThemeManager.shared.currentTheme
        normalBackgroundColor = theme.primaryColor
        setTitleColor(.white, for: .normal)
        setTitleColor(.white.withAlphaComponent(0.7), for: .highlighted)
        titleLabel?.font = theme.fontSemibold
        cornerRadius = theme.cornerRadiusMedium
        
        contentEdgeInsets = UIEdgeInsets(top: 14, left: 24, bottom: 14, right: 24)
    }
}

// MARK: - Secondary Button
/// Secondary action button with outlined style
@IBDesignable
public final class SecondaryButton: BaseButton {
    
    public override func setupButton() {
        super.setupButton()
        
        let theme = ThemeManager.shared.currentTheme
        normalBackgroundColor = .clear
        borderWidth = 2
        borderColor = theme.primaryColor
        setTitleColor(theme.primaryColor, for: .normal)
        setTitleColor(theme.primaryColor.withAlphaComponent(0.7), for: .highlighted)
        titleLabel?.font = theme.fontSemibold
        cornerRadius = theme.cornerRadiusMedium
        
        contentEdgeInsets = UIEdgeInsets(top: 14, left: 24, bottom: 14, right: 24)
    }
    
    public override var isHighlighted: Bool {
        didSet {
            let theme = ThemeManager.shared.currentTheme
            backgroundColor = isHighlighted ? theme.primaryColor.withAlphaComponent(0.1) : .clear
        }
    }
}

// MARK: - Tertiary Button
/// Text-only button for less prominent actions
@IBDesignable
public final class TertiaryButton: BaseButton {
    
    public override func setupButton() {
        super.setupButton()
        
        let theme = ThemeManager.shared.currentTheme
        normalBackgroundColor = .clear
        setTitleColor(theme.primaryColor, for: .normal)
        setTitleColor(theme.primaryColor.withAlphaComponent(0.5), for: .highlighted)
        titleLabel?.font = theme.fontMedium
        
        contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    }
}

// MARK: - Destructive Button
/// Button for destructive actions
@IBDesignable
public final class DestructiveButton: BaseButton {
    
    public override func setupButton() {
        super.setupButton()
        
        let theme = ThemeManager.shared.currentTheme
        normalBackgroundColor = theme.errorColor
        setTitleColor(.white, for: .normal)
        titleLabel?.font = theme.fontSemibold
        cornerRadius = theme.cornerRadiusMedium
        
        contentEdgeInsets = UIEdgeInsets(top: 14, left: 24, bottom: 14, right: 24)
    }
}

// MARK: - Success Button
/// Button for success/confirmation actions
@IBDesignable
public final class SuccessButton: BaseButton {
    
    public override func setupButton() {
        super.setupButton()
        
        let theme = ThemeManager.shared.currentTheme
        normalBackgroundColor = theme.successColor
        setTitleColor(.white, for: .normal)
        titleLabel?.font = theme.fontSemibold
        cornerRadius = theme.cornerRadiusMedium
        
        contentEdgeInsets = UIEdgeInsets(top: 14, left: 24, bottom: 14, right: 24)
    }
}

// MARK: - Warning Button
/// Button for warning actions
@IBDesignable
public final class WarningButton: BaseButton {
    
    public override func setupButton() {
        super.setupButton()
        
        let theme = ThemeManager.shared.currentTheme
        normalBackgroundColor = theme.warningColor
        setTitleColor(.white, for: .normal)
        titleLabel?.font = theme.fontSemibold
        cornerRadius = theme.cornerRadiusMedium
        
        contentEdgeInsets = UIEdgeInsets(top: 14, left: 24, bottom: 14, right: 24)
    }
}

// MARK: - Gradient Button
/// Button with gradient background
@IBDesignable
public final class GradientButton: BaseButton {
    
    // MARK: - IBInspectable
    @IBInspectable public var startColor: UIColor = .systemBlue {
        didSet { updateGradient() }
    }
    
    @IBInspectable public var endColor: UIColor = .systemPurple {
        didSet { updateGradient() }
    }
    
    @IBInspectable public var isHorizontal: Bool = true {
        didSet { updateGradient() }
    }
    
    // MARK: - Private Properties
    private let gradientLayer = CAGradientLayer()
    
    // MARK: - Setup
    public override func setupButton() {
        super.setupButton()
        
        setTitleColor(.white, for: .normal)
        titleLabel?.font = ThemeManager.shared.currentTheme.fontSemibold
        cornerRadius = ThemeManager.shared.currentTheme.cornerRadiusMedium
        
        contentEdgeInsets = UIEdgeInsets(top: 14, left: 24, bottom: 14, right: 24)
        
        layer.insertSublayer(gradientLayer, at: 0)
        updateGradient()
    }
    
    private func updateGradient() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: isHorizontal ? 0.5 : 1)
        gradientLayer.cornerRadius = cornerRadius
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = cornerRadius
    }
    
    public override var isHighlighted: Bool {
        didSet {
            gradientLayer.opacity = isHighlighted ? 0.8 : 1.0
        }
    }
}

// MARK: - Icon Button
/// Circular button with icon
@IBDesignable
public final class IconButton: BaseButton {
    
    // MARK: - IBInspectable
    @IBInspectable public var iconSize: CGFloat = 24 {
        didSet { updateIcon() }
    }
    
    @IBInspectable public var iconColor: UIColor = .white {
        didSet { updateIcon() }
    }
    
    @IBInspectable public var buttonSize: CGFloat = 44 {
        didSet { invalidateIntrinsicContentSize() }
    }
    
    // MARK: - Setup
    public override func setupButton() {
        super.setupButton()
        
        let theme = ThemeManager.shared.currentTheme
        normalBackgroundColor = theme.primaryColor
        tintColor = .white
        
        contentEdgeInsets = .zero
        imageEdgeInsets = .zero
    }
    
    private func updateIcon() {
        let config = UIImage.SymbolConfiguration(pointSize: iconSize, weight: .medium)
        setPreferredSymbolConfiguration(config, forImageIn: .normal)
        tintColor = iconColor
    }
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: buttonSize, height: buttonSize)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }
}

// MARK: - Pill Button
/// Pill-shaped button
@IBDesignable
public final class PillButton: BaseButton {
    
    public override func setupButton() {
        super.setupButton()
        
        let theme = ThemeManager.shared.currentTheme
        normalBackgroundColor = theme.primaryColor
        setTitleColor(.white, for: .normal)
        titleLabel?.font = theme.fontMedium
        
        contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }
}

// MARK: - Floating Action Button
/// Material Design style FAB
@IBDesignable
public final class FloatingActionButton: BaseButton {
    
    // MARK: - IBInspectable
    @IBInspectable public var fabSize: CGFloat = 56 {
        didSet { invalidateIntrinsicContentSize() }
    }
    
    @IBInspectable public var mini: Bool = false {
        didSet {
            fabSize = mini ? 40 : 56
        }
    }
    
    // MARK: - Setup
    public override func setupButton() {
        super.setupButton()
        
        let theme = ThemeManager.shared.currentTheme
        normalBackgroundColor = theme.primaryColor
        tintColor = .white
        
        shadowRadius = 8
        shadowOpacity = 0.3
        shadowOffset = CGSize(width: 0, height: 4)
        shadowColor = .black
        
        contentEdgeInsets = .zero
    }
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: fabSize, height: fabSize)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }
}

// MARK: - Social Button
/// Social media login button
@IBDesignable
public final class SocialButton: BaseButton {
    
    // MARK: - Social Types
    public enum SocialType {
        case apple
        case google
        case facebook
        case twitter
        case github
        
        var backgroundColor: UIColor {
            switch self {
            case .apple: return .black
            case .google: return .white
            case .facebook: return UIColor(hex: "1877F2")
            case .twitter: return UIColor(hex: "1DA1F2")
            case .github: return UIColor(hex: "24292E")
            }
        }
        
        var textColor: UIColor {
            switch self {
            case .google: return .black
            default: return .white
            }
        }
        
        var iconName: String {
            switch self {
            case .apple: return "applelogo"
            case .google: return "g.circle.fill"
            case .facebook: return "f.circle.fill"
            case .twitter: return "bird"
            case .github: return "chevron.left.forwardslash.chevron.right"
            }
        }
    }
    
    // MARK: - Properties
    public var socialType: SocialType = .apple {
        didSet { updateSocialStyle() }
    }
    
    // MARK: - Setup
    public override func setupButton() {
        super.setupButton()
        
        cornerRadius = ThemeManager.shared.currentTheme.cornerRadiusMedium
        contentEdgeInsets = UIEdgeInsets(top: 12, left: 20, bottom: 12, right: 20)
        imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        
        titleLabel?.font = ThemeManager.shared.currentTheme.fontSemibold
        
        updateSocialStyle()
    }
    
    private func updateSocialStyle() {
        normalBackgroundColor = socialType.backgroundColor
        setTitleColor(socialType.textColor, for: .normal)
        tintColor = socialType.textColor
        
        let config = UIImage.SymbolConfiguration(pointSize: 18, weight: .medium)
        let icon = UIImage(systemName: socialType.iconName, withConfiguration: config)
        setImage(icon, for: .normal)
        
        if socialType == .google {
            borderWidth = 1
            borderColor = UIColor(white: 0.85, alpha: 1)
        } else {
            borderWidth = 0
        }
    }
    
    /// Configure button for specific social platform
    public func configure(for type: SocialType, title: String) {
        self.socialType = type
        setTitle(title, for: .normal)
    }
}

// MARK: - Loading Button
/// Button with loading indicator
@IBDesignable
public final class LoadingButton: BaseButton {
    
    // MARK: - Properties
    @IBInspectable public var loadingIndicatorColor: UIColor = .white {
        didSet { activityIndicator.color = loadingIndicatorColor }
    }
    
    private(set) public var isLoading: Bool = false
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    private var originalTitle: String?
    private var originalImage: UIImage?
    
    // MARK: - Setup
    public override func setupButton() {
        super.setupButton()
        
        let theme = ThemeManager.shared.currentTheme
        normalBackgroundColor = theme.primaryColor
        setTitleColor(.white, for: .normal)
        titleLabel?.font = theme.fontSemibold
        cornerRadius = theme.cornerRadiusMedium
        
        contentEdgeInsets = UIEdgeInsets(top: 14, left: 24, bottom: 14, right: 24)
        
        activityIndicator.color = loadingIndicatorColor
        activityIndicator.hidesWhenStopped = true
        addSubview(activityIndicator)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        activityIndicator.center = CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    // MARK: - Loading State
    public func startLoading() {
        guard !isLoading else { return }
        isLoading = true
        
        originalTitle = title(for: .normal)
        originalImage = image(for: .normal)
        
        setTitle(nil, for: .normal)
        setImage(nil, for: .normal)
        
        activityIndicator.startAnimating()
        isUserInteractionEnabled = false
        
        accessibilityValue = "Loading"
    }
    
    public func stopLoading() {
        guard isLoading else { return }
        isLoading = false
        
        activityIndicator.stopAnimating()
        
        setTitle(originalTitle, for: .normal)
        setImage(originalImage, for: .normal)
        
        isUserInteractionEnabled = true
        
        accessibilityValue = nil
    }
}

// MARK: - Chip Button
/// Chip/Tag style button
@IBDesignable
public final class ChipButton: BaseButton {
    
    // MARK: - Properties
    @IBInspectable public var isSelected: Bool = false {
        didSet { updateSelectionState() }
    }
    
    @IBInspectable public var selectedBackgroundColor: UIColor = .systemBlue
    @IBInspectable public var unselectedBackgroundColor: UIColor = .systemGray6
    @IBInspectable public var selectedTextColor: UIColor = .white
    @IBInspectable public var unselectedTextColor: UIColor = .label
    
    // MARK: - Setup
    public override func setupButton() {
        super.setupButton()
        
        titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        
        updateSelectionState()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }
    
    private func updateSelectionState() {
        backgroundColor = isSelected ? selectedBackgroundColor : unselectedBackgroundColor
        setTitleColor(isSelected ? selectedTextColor : unselectedTextColor, for: .normal)
        
        accessibilityTraits = isSelected ? [.button, .selected] : .button
    }
    
    /// Toggle selection state
    public func toggleSelection() {
        isSelected.toggle()
    }
}

// MARK: - Segmented Button
/// iOS-style segmented control button
@IBDesignable
public final class SegmentedButton: UIView {
    
    // MARK: - Properties
    @IBInspectable public var selectedIndex: Int = 0 {
        didSet { updateSelection() }
    }
    
    public var segments: [String] = [] {
        didSet { setupSegments() }
    }
    
    public var onSelectionChange: ((Int) -> Void)?
    
    private let stackView = UIStackView()
    private var buttons: [UIButton] = []
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
        backgroundColor = .systemGray6
        layer.cornerRadius = 8
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        addSubview(stackView)
        
        selectionIndicator.backgroundColor = .white
        selectionIndicator.layer.cornerRadius = 6
        selectionIndicator.layer.shadowColor = UIColor.black.cgColor
        selectionIndicator.layer.shadowOpacity = 0.1
        selectionIndicator.layer.shadowRadius = 2
        selectionIndicator.layer.shadowOffset = CGSize(width: 0, height: 1)
        insertSubview(selectionIndicator, belowSubview: stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2)
        ])
    }
    
    private func setupSegments() {
        buttons.forEach { $0.removeFromSuperview() }
        buttons.removeAll()
        
        for (index, title) in segments.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
            button.tag = index
            button.addTarget(self, action: #selector(segmentTapped(_:)), for: .touchUpInside)
            buttons.append(button)
            stackView.addArrangedSubview(button)
        }
        
        updateSelection()
    }
    
    @objc private func segmentTapped(_ sender: UIButton) {
        selectedIndex = sender.tag
        onSelectionChange?(selectedIndex)
    }
    
    private func updateSelection() {
        for (index, button) in buttons.enumerated() {
            let isSelected = index == selectedIndex
            button.setTitleColor(isSelected ? .label : .secondaryLabel, for: .normal)
        }
        
        setNeedsLayout()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        guard !buttons.isEmpty else { return }
        
        let segmentWidth = (bounds.width - 4) / CGFloat(buttons.count)
        let indicatorFrame = CGRect(
            x: 2 + CGFloat(selectedIndex) * segmentWidth,
            y: 2,
            width: segmentWidth,
            height: bounds.height - 4
        )
        
        if !AccessibilityHelper.isReduceMotionEnabled {
            UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0) {
                self.selectionIndicator.frame = indicatorFrame
            }
        } else {
            selectionIndicator.frame = indicatorFrame
        }
    }
}

// MARK: - Toggle Button
/// Button that toggles between two states
@IBDesignable
public final class ToggleButton: BaseButton {
    
    // MARK: - Properties
    @IBInspectable public var isOn: Bool = false {
        didSet { updateToggleState() }
    }
    
    @IBInspectable public var onBackgroundColor: UIColor = .systemBlue
    @IBInspectable public var offBackgroundColor: UIColor = .systemGray5
    @IBInspectable public var onIcon: UIImage?
    @IBInspectable public var offIcon: UIImage?
    
    public var onToggle: ((Bool) -> Void)?
    
    // MARK: - Setup
    public override func setupButton() {
        super.setupButton()
        
        cornerRadius = ThemeManager.shared.currentTheme.cornerRadiusMedium
        contentEdgeInsets = UIEdgeInsets(top: 12, left: 20, bottom: 12, right: 20)
        
        addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        
        updateToggleState()
    }
    
    @objc private func handleTap() {
        isOn.toggle()
        onToggle?(isOn)
    }
    
    private func updateToggleState() {
        let bgColor = isOn ? onBackgroundColor : offBackgroundColor
        let textColor: UIColor = isOn ? .white : .label
        
        if !AccessibilityHelper.isReduceMotionEnabled {
            UIView.animate(withDuration: 0.2) {
                self.backgroundColor = bgColor
            }
        } else {
            backgroundColor = bgColor
        }
        
        setTitleColor(textColor, for: .normal)
        tintColor = textColor
        
        if let onImg = onIcon, let offImg = offIcon {
            setImage(isOn ? onImg : offImg, for: .normal)
        }
        
        accessibilityTraits = isOn ? [.button, .selected] : .button
        accessibilityValue = isOn ? "On" : "Off"
    }
}

// MARK: - Expandable Button
/// Button that expands to show more options
@IBDesignable
public final class ExpandableButton: UIView {
    
    // MARK: - Properties
    public var mainButton: FloatingActionButton!
    public var optionButtons: [IconButton] = []
    
    public private(set) var isExpanded: Bool = false
    public var onOptionSelected: ((Int) -> Void)?
    
    private var optionConstraints: [[NSLayoutConstraint]] = []
    
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
        mainButton = FloatingActionButton()
        mainButton.setImage(UIImage(systemName: "plus"), for: .normal)
        mainButton.addTarget(self, action: #selector(toggleExpand), for: .touchUpInside)
        addSubview(mainButton)
        
        mainButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainButton.widthAnchor.constraint(equalToConstant: 56),
            mainButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    /// Add option button
    public func addOption(icon: String, color: UIColor? = nil) {
        let button = IconButton()
        button.setImage(UIImage(systemName: icon), for: .normal)
        button.buttonSize = 44
        button.alpha = 0
        button.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        if let color = color {
            button.normalBackgroundColor = color
        }
        
        let index = optionButtons.count
        button.tag = index
        button.addTarget(self, action: #selector(optionTapped(_:)), for: .touchUpInside)
        
        insertSubview(button, belowSubview: mainButton)
        optionButtons.append(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            button.centerXAnchor.constraint(equalTo: mainButton.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: mainButton.topAnchor, constant: -CGFloat(16 + index * 52)),
            button.widthAnchor.constraint(equalToConstant: 44),
            button.heightAnchor.constraint(equalToConstant: 44)
        ]
        optionConstraints.append(constraints)
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc private func toggleExpand() {
        isExpanded.toggle()
        
        let rotation = isExpanded ? CGFloat.pi / 4 : 0
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0) {
            self.mainButton.transform = CGAffineTransform(rotationAngle: rotation)
            
            for (index, button) in self.optionButtons.enumerated() {
                if self.isExpanded {
                    button.alpha = 1
                    button.transform = .identity
                } else {
                    button.alpha = 0
                    button.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                }
            }
        }
    }
    
    @objc private func optionTapped(_ sender: UIButton) {
        onOptionSelected?(sender.tag)
        toggleExpand()
    }
    
    public override var intrinsicContentSize: CGSize {
        let height = 56 + CGFloat(optionButtons.count * 52 + optionButtons.count * 16)
        return CGSize(width: 56, height: height)
    }
}
