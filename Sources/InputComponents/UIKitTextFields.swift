import UIKit

// MARK: - Base Text Field
/// Base class for custom UIKit text fields with Interface Builder support
@IBDesignable
open class BaseTextField: UITextField {
    
    // MARK: - IBInspectable Properties
    @IBInspectable public var cornerRadius: CGFloat = 8 {
        didSet { updateAppearance() }
    }
    
    @IBInspectable public var borderWidth: CGFloat = 1 {
        didSet { updateAppearance() }
    }
    
    @IBInspectable public var normalBorderColor: UIColor = .systemGray4 {
        didSet { updateAppearance() }
    }
    
    @IBInspectable public var focusedBorderColor: UIColor = .systemBlue {
        didSet { updateAppearance() }
    }
    
    @IBInspectable public var errorBorderColor: UIColor = .systemRed {
        didSet { updateAppearance() }
    }
    
    @IBInspectable public var paddingLeft: CGFloat = 16 {
        didSet { setNeedsLayout() }
    }
    
    @IBInspectable public var paddingRight: CGFloat = 16 {
        didSet { setNeedsLayout() }
    }
    
    @IBInspectable public var placeholderColor: UIColor = .placeholderText {
        didSet { updatePlaceholder() }
    }
    
    // MARK: - Public Properties
    public var hasError: Bool = false {
        didSet { updateBorderState() }
    }
    
    public var errorMessage: String? {
        didSet { updateErrorLabel() }
    }
    
    // MARK: - Private Properties
    private let errorLabel = UILabel()
    private var heightConstraint: NSLayoutConstraint?
    
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
        setupTextField()
        setupErrorLabel()
        updateAppearance()
        configureAccessibility()
    }
    
    // MARK: - Setup
    open func setupTextField() {
        font = ThemeManager.shared.currentTheme.fontRegular
        textColor = ThemeManager.shared.currentTheme.textPrimaryColor
        backgroundColor = ThemeManager.shared.currentTheme.surfaceColor
        
        addTarget(self, action: #selector(textFieldDidBeginEditing), for: .editingDidBegin)
        addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingDidEnd)
    }
    
    private func setupErrorLabel() {
        errorLabel.font = .systemFont(ofSize: 12)
        errorLabel.textColor = ThemeManager.shared.currentTheme.errorColor
        errorLabel.numberOfLines = 0
        errorLabel.alpha = 0
    }
    
    open func updateAppearance() {
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        updateBorderState()
    }
    
    private func updateBorderState() {
        let color: UIColor
        if hasError {
            color = errorBorderColor
        } else if isFirstResponder {
            color = focusedBorderColor
        } else {
            color = normalBorderColor
        }
        
        layer.borderColor = color.cgColor
    }
    
    private func updatePlaceholder() {
        if let placeholder = placeholder {
            attributedPlaceholder = NSAttributedString(
                string: placeholder,
                attributes: [.foregroundColor: placeholderColor]
            )
        }
    }
    
    private func updateErrorLabel() {
        if let error = errorMessage {
            errorLabel.text = error
            hasError = true
            
            UIView.animate(withDuration: 0.2) {
                self.errorLabel.alpha = 1
            }
            
            AccessibilityHelper.announce(error)
        } else {
            hasError = false
            
            UIView.animate(withDuration: 0.2) {
                self.errorLabel.alpha = 0
            }
        }
    }
    
    open func configureAccessibility() {
        isAccessibilityElement = true
        accessibilityTraits = .none
    }
    
    // MARK: - Text Field Events
    @objc private func textFieldDidBeginEditing() {
        updateBorderState()
        
        UIView.animate(withDuration: 0.2) {
            self.layer.borderColor = self.hasError ? self.errorBorderColor.cgColor : self.focusedBorderColor.cgColor
        }
    }
    
    @objc private func textFieldDidEndEditing() {
        updateBorderState()
    }
    
    // MARK: - Layout
    open override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: paddingLeft, bottom: 0, right: paddingRight))
    }
    
    open override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    open override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    open override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 48)
    }
    
    // MARK: - Interface Builder
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        updateAppearance()
    }
}

// MARK: - Outlined Text Field
/// Text field with outline border style
@IBDesignable
public final class OutlinedTextField: BaseTextField {
    
    public override func setupTextField() {
        super.setupTextField()
        backgroundColor = .clear
        borderWidth = 1.5
    }
}

// MARK: - Filled Text Field
/// Text field with filled background
@IBDesignable
public final class FilledTextField: BaseTextField {
    
    public override func setupTextField() {
        super.setupTextField()
        backgroundColor = ThemeManager.shared.currentTheme.surfaceColor
        borderWidth = 0
        cornerRadius = ThemeManager.shared.currentTheme.cornerRadiusMedium
        
        // Bottom border only
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: frame.height - 2, width: frame.width, height: 2)
        bottomLine.backgroundColor = normalBorderColor.cgColor
        layer.addSublayer(bottomLine)
    }
}

// MARK: - Underlined Text Field
/// Text field with underline style
@IBDesignable
public final class UnderlinedTextField: BaseTextField {
    
    private let bottomLine = CALayer()
    
    public override func setupTextField() {
        super.setupTextField()
        backgroundColor = .clear
        borderWidth = 0
        borderStyle = .none
        
        bottomLine.backgroundColor = normalBorderColor.cgColor
        layer.addSublayer(bottomLine)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        bottomLine.frame = CGRect(x: 0, y: bounds.height - 1, width: bounds.width, height: 1)
    }
    
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    }
}

// MARK: - Floating Label Text Field
/// Text field with animated floating label
@IBDesignable
public final class FloatingLabelTextField: BaseTextField {
    
    // MARK: - IBInspectable
    @IBInspectable public var floatingLabelText: String = "" {
        didSet { floatingLabel.text = floatingLabelText }
    }
    
    @IBInspectable public var floatingLabelColor: UIColor = .secondaryLabel {
        didSet { floatingLabel.textColor = floatingLabelColor }
    }
    
    @IBInspectable public var activeFloatingLabelColor: UIColor = .systemBlue
    
    // MARK: - Private Properties
    private let floatingLabel = UILabel()
    private var isFloating = false
    
    // MARK: - Setup
    public override func setupTextField() {
        super.setupTextField()
        
        floatingLabel.font = .systemFont(ofSize: 12, weight: .medium)
        floatingLabel.textColor = floatingLabelColor
        floatingLabel.alpha = 0
        addSubview(floatingLabel)
        
        addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        floatingLabel.frame = CGRect(
            x: paddingLeft,
            y: isFloating ? 4 : (bounds.height - 20) / 2,
            width: bounds.width - paddingLeft - paddingRight,
            height: 16
        )
    }
    
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: isFloating ? 12 : 0, left: paddingLeft, bottom: 0, right: paddingRight))
    }
    
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    @objc private func handleTextChange() {
        updateFloatingLabel()
    }
    
    private func updateFloatingLabel() {
        let shouldFloat = isFirstResponder || !(text?.isEmpty ?? true)
        
        guard shouldFloat != isFloating else { return }
        isFloating = shouldFloat
        
        let transform: CGAffineTransform = shouldFloat ? CGAffineTransform(translationX: 0, y: -12) : .identity
        let alpha: CGFloat = shouldFloat ? 1 : 0
        let color = shouldFloat && isFirstResponder ? activeFloatingLabelColor : floatingLabelColor
        
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut]) {
            self.floatingLabel.transform = transform
            self.floatingLabel.alpha = alpha
            self.floatingLabel.textColor = color
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 56)
    }
}

// MARK: - Search Text Field
/// Search-style text field with icon
@IBDesignable
public final class SearchTextField: BaseTextField {
    
    // MARK: - IBInspectable
    @IBInspectable public var searchIconColor: UIColor = .secondaryLabel {
        didSet { searchIcon.tintColor = searchIconColor }
    }
    
    @IBInspectable public var showClearButton: Bool = true {
        didSet { clearButtonMode = showClearButton ? .whileEditing : .never }
    }
    
    // MARK: - Private Properties
    private let searchIcon = UIImageView()
    private let searchIconSize: CGFloat = 20
    
    // MARK: - Setup
    public override func setupTextField() {
        super.setupTextField()
        
        backgroundColor = ThemeManager.shared.currentTheme.surfaceColor
        cornerRadius = ThemeManager.shared.currentTheme.cornerRadiusLarge
        borderWidth = 0
        
        searchIcon.image = UIImage(systemName: "magnifyingglass")
        searchIcon.tintColor = searchIconColor
        searchIcon.contentMode = .scaleAspectFit
        
        let leftViewContainer = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        searchIcon.frame = CGRect(x: 12, y: 12, width: searchIconSize, height: searchIconSize)
        leftViewContainer.addSubview(searchIcon)
        
        leftView = leftViewContainer
        leftViewMode = .always
        clearButtonMode = showClearButton ? .whileEditing : .never
        
        placeholder = "Search..."
        returnKeyType = .search
    }
    
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 44, bottom: 0, right: 12))
    }
    
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
}

// MARK: - Password Text Field
/// Secure text field with visibility toggle
@IBDesignable
public final class PasswordTextField: BaseTextField {
    
    // MARK: - IBInspectable
    @IBInspectable public var toggleIconColor: UIColor = .secondaryLabel {
        didSet { toggleButton.tintColor = toggleIconColor }
    }
    
    // MARK: - Private Properties
    private let toggleButton = UIButton(type: .system)
    
    // MARK: - Setup
    public override func setupTextField() {
        super.setupTextField()
        
        isSecureTextEntry = true
        textContentType = .password
        
        toggleButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        toggleButton.tintColor = toggleIconColor
        toggleButton.addTarget(self, action: #selector(toggleVisibility), for: .touchUpInside)
        
        let rightViewContainer = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        toggleButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        rightViewContainer.addSubview(toggleButton)
        
        rightView = rightViewContainer
        rightViewMode = .always
    }
    
    @objc private func toggleVisibility() {
        isSecureTextEntry.toggle()
        
        let iconName = isSecureTextEntry ? "eye.slash" : "eye"
        toggleButton.setImage(UIImage(systemName: iconName), for: .normal)
        
        // Maintain cursor position
        if let existingText = text, isFirstResponder {
            deleteBackward()
            insertText(existingText)
        }
        
        accessibilityValue = isSecureTextEntry ? "Password hidden" : "Password visible"
    }
    
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: paddingLeft, bottom: 0, right: 48))
    }
    
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
}

// MARK: - OTP Text Field
/// One-Time Password input with individual digit boxes
public final class OTPTextField: UIView, UITextFieldDelegate {
    
    // MARK: - Properties
    public var numberOfDigits: Int = 6 {
        didSet { setupDigitFields() }
    }
    
    public var onComplete: ((String) -> Void)?
    
    @IBInspectable public var boxSize: CGFloat = 48
    @IBInspectable public var spacing: CGFloat = 8
    @IBInspectable public var boxBackgroundColor: UIColor = .secondarySystemBackground
    @IBInspectable public var boxBorderColor: UIColor = .systemGray4
    @IBInspectable public var focusedBorderColor: UIColor = .systemBlue
    @IBInspectable public var textColor: UIColor = .label
    
    private var digitFields: [UITextField] = []
    private let stackView = UIStackView()
    private let hiddenTextField = UITextField()
    
    public var code: String {
        return digitFields.compactMap { $0.text }.joined()
    }
    
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
        setupHiddenTextField()
        setupStackView()
        setupDigitFields()
    }
    
    private func setupHiddenTextField() {
        hiddenTextField.keyboardType = .numberPad
        hiddenTextField.textContentType = .oneTimeCode
        hiddenTextField.delegate = self
        hiddenTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        addSubview(hiddenTextField)
        hiddenTextField.frame = CGRect(x: -1000, y: 0, width: 1, height: 1)
    }
    
    private func setupStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = spacing
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tapGesture)
    }
    
    private func setupDigitFields() {
        digitFields.forEach { $0.removeFromSuperview() }
        digitFields.removeAll()
        
        for _ in 0..<numberOfDigits {
            let field = createDigitField()
            digitFields.append(field)
            stackView.addArrangedSubview(field)
        }
    }
    
    private func createDigitField() -> UITextField {
        let field = UITextField()
        field.textAlignment = .center
        field.font = .systemFont(ofSize: 24, weight: .semibold)
        field.textColor = textColor
        field.backgroundColor = boxBackgroundColor
        field.layer.cornerRadius = 8
        field.layer.borderWidth = 1
        field.layer.borderColor = boxBorderColor.cgColor
        field.isUserInteractionEnabled = false
        
        NSLayoutConstraint.activate([
            field.widthAnchor.constraint(equalToConstant: boxSize),
            field.heightAnchor.constraint(equalToConstant: boxSize)
        ])
        
        return field
    }
    
    @objc private func handleTap() {
        hiddenTextField.becomeFirstResponder()
    }
    
    @objc private func textDidChange() {
        let text = hiddenTextField.text ?? ""
        
        for (index, field) in digitFields.enumerated() {
            if index < text.count {
                let charIndex = text.index(text.startIndex, offsetBy: index)
                field.text = String(text[charIndex])
                field.layer.borderColor = focusedBorderColor.cgColor
            } else {
                field.text = ""
                field.layer.borderColor = boxBorderColor.cgColor
            }
        }
        
        // Highlight current field
        if text.count < numberOfDigits {
            digitFields[text.count].layer.borderColor = focusedBorderColor.cgColor
        }
        
        // Trigger completion
        if text.count == numberOfDigits {
            onComplete?(text)
        }
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let newLength = currentText.count + string.count - range.length
        return newLength <= numberOfDigits
    }
    
    /// Clear all digits
    public func clear() {
        hiddenTextField.text = ""
        textDidChange()
    }
    
    /// Focus the OTP field
    public func focus() {
        hiddenTextField.becomeFirstResponder()
    }
    
    public override var intrinsicContentSize: CGSize {
        let width = CGFloat(numberOfDigits) * boxSize + CGFloat(numberOfDigits - 1) * spacing
        return CGSize(width: width, height: boxSize)
    }
}

// MARK: - Phone Number Text Field
/// Text field for phone number with formatting
@IBDesignable
public final class PhoneNumberTextField: BaseTextField {
    
    // MARK: - Properties
    public var format: String = "(###) ###-####"
    public var countryCode: String = "+1" {
        didSet { updateCountryCodeLabel() }
    }
    
    private let countryCodeLabel = UILabel()
    
    // MARK: - Setup
    public override func setupTextField() {
        super.setupTextField()
        
        keyboardType = .phonePad
        textContentType = .telephoneNumber
        
        countryCodeLabel.font = font
        countryCodeLabel.textColor = .secondaryLabel
        countryCodeLabel.text = countryCode
        countryCodeLabel.sizeToFit()
        
        let leftViewContainer = UIView(frame: CGRect(x: 0, y: 0, width: countryCodeLabel.bounds.width + 24, height: 44))
        countryCodeLabel.center = CGPoint(x: leftViewContainer.bounds.midX, y: leftViewContainer.bounds.midY)
        leftViewContainer.addSubview(countryCodeLabel)
        
        leftView = leftViewContainer
        leftViewMode = .always
        
        addTarget(self, action: #selector(formatPhoneNumber), for: .editingChanged)
    }
    
    private func updateCountryCodeLabel() {
        countryCodeLabel.text = countryCode
        countryCodeLabel.sizeToFit()
    }
    
    @objc private func formatPhoneNumber() {
        guard let text = text else { return }
        
        let digits = text.filter { $0.isNumber }
        var result = ""
        var digitIndex = 0
        
        for char in format {
            guard digitIndex < digits.count else { break }
            
            if char == "#" {
                let index = digits.index(digits.startIndex, offsetBy: digitIndex)
                result.append(digits[index])
                digitIndex += 1
            } else {
                result.append(char)
            }
        }
        
        self.text = result
    }
    
    /// Get raw phone number without formatting
    public var rawPhoneNumber: String {
        return (text ?? "").filter { $0.isNumber }
    }
}

// MARK: - Amount Text Field
/// Text field for currency amount input
@IBDesignable
public final class AmountTextField: BaseTextField {
    
    // MARK: - Properties
    @IBInspectable public var currencySymbol: String = "$" {
        didSet { updateCurrencyLabel() }
    }
    
    @IBInspectable public var maxDigits: Int = 10
    @IBInspectable public var allowDecimals: Bool = true
    
    private let currencyLabel = UILabel()
    private let numberFormatter = NumberFormatter()
    
    public var amount: Decimal? {
        guard let text = text else { return nil }
        let cleanText = text.replacingOccurrences(of: currencySymbol, with: "")
            .replacingOccurrences(of: ",", with: "")
            .trimmingCharacters(in: .whitespaces)
        return Decimal(string: cleanText)
    }
    
    // MARK: - Setup
    public override func setupTextField() {
        super.setupTextField()
        
        keyboardType = allowDecimals ? .decimalPad : .numberPad
        textAlignment = .right
        font = .systemFont(ofSize: 32, weight: .bold)
        
        numberFormatter.numberStyle = .currency
        numberFormatter.currencySymbol = currencySymbol
        
        currencyLabel.font = .systemFont(ofSize: 24, weight: .medium)
        currencyLabel.textColor = .secondaryLabel
        currencyLabel.text = currencySymbol
        currencyLabel.sizeToFit()
        
        let leftViewContainer = UIView(frame: CGRect(x: 0, y: 0, width: currencyLabel.bounds.width + 20, height: 44))
        currencyLabel.center = CGPoint(x: leftViewContainer.bounds.midX, y: leftViewContainer.bounds.midY)
        leftViewContainer.addSubview(currencyLabel)
        
        leftView = leftViewContainer
        leftViewMode = .always
        
        addTarget(self, action: #selector(formatAmount), for: .editingChanged)
    }
    
    private func updateCurrencyLabel() {
        currencyLabel.text = currencySymbol
        currencyLabel.sizeToFit()
        numberFormatter.currencySymbol = currencySymbol
    }
    
    @objc private func formatAmount() {
        guard let text = text else { return }
        
        var digits = text.filter { $0.isNumber || $0 == "." }
        
        // Handle decimal point
        let decimalParts = digits.components(separatedBy: ".")
        if decimalParts.count > 2 {
            digits = decimalParts[0] + "." + decimalParts[1]
        }
        
        // Limit decimal places
        if decimalParts.count == 2 && decimalParts[1].count > 2 {
            digits = decimalParts[0] + "." + String(decimalParts[1].prefix(2))
        }
        
        // Format with commas
        if let number = Double(digits) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = allowDecimals ? 2 : 0
            self.text = formatter.string(from: NSNumber(value: number))
        } else {
            self.text = digits
        }
    }
    
    /// Set amount programmatically
    public func setAmount(_ value: Decimal) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = allowDecimals ? 2 : 0
        self.text = formatter.string(from: value as NSDecimalNumber)
    }
}

// MARK: - Text View
/// Multi-line text input with placeholder support
@IBDesignable
public final class PlaceholderTextView: UITextView {
    
    // MARK: - IBInspectable
    @IBInspectable public var placeholder: String = "" {
        didSet { placeholderLabel.text = placeholder }
    }
    
    @IBInspectable public var placeholderColor: UIColor = .placeholderText {
        didSet { placeholderLabel.textColor = placeholderColor }
    }
    
    @IBInspectable public var cornerRadius: CGFloat = 8 {
        didSet { layer.cornerRadius = cornerRadius }
    }
    
    @IBInspectable public var borderWidth: CGFloat = 1 {
        didSet { layer.borderWidth = borderWidth }
    }
    
    @IBInspectable public var borderColor: UIColor = .systemGray4 {
        didSet { layer.borderColor = borderColor.cgColor }
    }
    
    @IBInspectable public var maxCharacters: Int = 0
    
    // MARK: - Properties
    public var onTextChange: ((String) -> Void)?
    public var characterCountLabel: UILabel?
    
    private let placeholderLabel = UILabel()
    
    // MARK: - Initialization
    public override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        delegate = self
        
        let theme = ThemeManager.shared.currentTheme
        font = theme.fontRegular
        textColor = theme.textPrimaryColor
        backgroundColor = theme.surfaceColor
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        
        textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        
        placeholderLabel.font = font
        placeholderLabel.textColor = placeholderColor
        placeholderLabel.numberOfLines = 0
        addSubview(placeholderLabel)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(textDidChange),
            name: UITextView.textDidChangeNotification,
            object: self
        )
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        placeholderLabel.frame = CGRect(
            x: textContainerInset.left + 5,
            y: textContainerInset.top,
            width: bounds.width - textContainerInset.left - textContainerInset.right - 10,
            height: bounds.height - textContainerInset.top - textContainerInset.bottom
        )
    }
    
    @objc private func textDidChange() {
        placeholderLabel.isHidden = !text.isEmpty
        updateCharacterCount()
        onTextChange?(text)
    }
    
    private func updateCharacterCount() {
        guard maxCharacters > 0 else { return }
        
        characterCountLabel?.text = "\(text.count)/\(maxCharacters)"
        characterCountLabel?.textColor = text.count > maxCharacters ? .systemRed : .secondaryLabel
    }
}

extension PlaceholderTextView: UITextViewDelegate {
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard maxCharacters > 0 else { return true }
        
        let currentText = textView.text ?? ""
        let newLength = currentText.count + text.count - range.length
        return newLength <= maxCharacters
    }
}
