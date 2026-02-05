import UIKit

// MARK: - Progress Bar
/// Customizable linear progress bar
@IBDesignable
public final class ProgressBar: UIView {
    
    // MARK: - Properties
    @IBInspectable public var progress: CGFloat = 0 {
        didSet { updateProgress(animated: true) }
    }
    
    @IBInspectable public var progressColor: UIColor = .systemBlue {
        didSet { progressLayer.backgroundColor = progressColor.cgColor }
    }
    
    @IBInspectable public var trackColor: UIColor = .systemGray5 {
        didSet { backgroundColor = trackColor }
    }
    
    @IBInspectable public var barHeight: CGFloat = 8 {
        didSet { invalidateIntrinsicContentSize() }
    }
    
    @IBInspectable public var isAnimated: Bool = true
    @IBInspectable public var showsPercentage: Bool = false {
        didSet { percentageLabel.isHidden = !showsPercentage }
    }
    
    private let progressLayer = CALayer()
    private let percentageLabel = UILabel()
    
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
        backgroundColor = trackColor
        clipsToBounds = true
        
        progressLayer.backgroundColor = progressColor.cgColor
        layer.addSublayer(progressLayer)
        
        percentageLabel.font = .systemFont(ofSize: 12, weight: .medium)
        percentageLabel.textColor = ThemeManager.shared.currentTheme.textSecondaryColor
        percentageLabel.textAlignment = .right
        percentageLabel.isHidden = !showsPercentage
        addSubview(percentageLabel)
        
        percentageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            percentageLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            percentageLabel.topAnchor.constraint(equalTo: bottomAnchor, constant: 4)
        ])
        
        isAccessibilityElement = true
        accessibilityTraits = .updatesFrequently
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
        progressLayer.cornerRadius = bounds.height / 2
        updateProgress(animated: false)
    }
    
    private func updateProgress(animated: Bool) {
        let clampedProgress = max(0, min(1, progress))
        let targetWidth = bounds.width * clampedProgress
        
        if animated && isAnimated && !AccessibilityHelper.isReduceMotionEnabled {
            CATransaction.begin()
            CATransaction.setAnimationDuration(0.3)
            CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: .easeOut))
            progressLayer.frame = CGRect(x: 0, y: 0, width: targetWidth, height: bounds.height)
            CATransaction.commit()
        } else {
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            progressLayer.frame = CGRect(x: 0, y: 0, width: targetWidth, height: bounds.height)
            CATransaction.commit()
        }
        
        percentageLabel.text = "\(Int(clampedProgress * 100))%"
        accessibilityValue = "\(Int(clampedProgress * 100)) percent"
    }
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: barHeight)
    }
    
    /// Set progress with optional animation
    public func setProgress(_ value: CGFloat, animated: Bool) {
        progress = value
        updateProgress(animated: animated)
    }
}

// MARK: - Circular Progress View
/// Circular progress indicator
@IBDesignable
public final class CircularProgressView: UIView {
    
    // MARK: - Properties
    @IBInspectable public var progress: CGFloat = 0 {
        didSet { updateProgress() }
    }
    
    @IBInspectable public var progressColor: UIColor = .systemBlue {
        didSet { progressLayer.strokeColor = progressColor.cgColor }
    }
    
    @IBInspectable public var trackColor: UIColor = .systemGray5 {
        didSet { trackLayer.strokeColor = trackColor.cgColor }
    }
    
    @IBInspectable public var lineWidth: CGFloat = 8 {
        didSet { updateLayers() }
    }
    
    @IBInspectable public var showsValue: Bool = true {
        didSet { valueLabel.isHidden = !showsValue }
    }
    
    @IBInspectable public var lineCap: String = "round" {
        didSet {
            let cap: CAShapeLayerLineCap = lineCap == "round" ? .round : .square
            progressLayer.lineCap = cap
        }
    }
    
    private let trackLayer = CAShapeLayer()
    private let progressLayer = CAShapeLayer()
    private let valueLabel = UILabel()
    
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
        layer.addSublayer(trackLayer)
        layer.addSublayer(progressLayer)
        
        trackLayer.fillColor = nil
        trackLayer.strokeColor = trackColor.cgColor
        trackLayer.lineWidth = lineWidth
        
        progressLayer.fillColor = nil
        progressLayer.strokeColor = progressColor.cgColor
        progressLayer.lineWidth = lineWidth
        progressLayer.lineCap = .round
        progressLayer.strokeEnd = 0
        
        valueLabel.font = .systemFont(ofSize: 24, weight: .bold)
        valueLabel.textColor = ThemeManager.shared.currentTheme.textPrimaryColor
        valueLabel.textAlignment = .center
        addSubview(valueLabel)
        
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            valueLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            valueLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        isAccessibilityElement = true
        accessibilityTraits = .updatesFrequently
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        updateLayers()
    }
    
    private func updateLayers() {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.width, bounds.height) / 2 - lineWidth / 2
        
        let path = UIBezierPath(
            arcCenter: center,
            radius: radius,
            startAngle: -CGFloat.pi / 2,
            endAngle: CGFloat.pi * 1.5,
            clockwise: true
        )
        
        trackLayer.path = path.cgPath
        trackLayer.lineWidth = lineWidth
        
        progressLayer.path = path.cgPath
        progressLayer.lineWidth = lineWidth
    }
    
    private func updateProgress() {
        let clampedProgress = max(0, min(1, progress))
        
        if !AccessibilityHelper.isReduceMotionEnabled {
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = progressLayer.strokeEnd
            animation.toValue = clampedProgress
            animation.duration = 0.3
            animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
            progressLayer.add(animation, forKey: "progress")
        }
        
        progressLayer.strokeEnd = clampedProgress
        valueLabel.text = "\(Int(clampedProgress * 100))%"
        
        accessibilityValue = "\(Int(clampedProgress * 100)) percent"
    }
    
    /// Set progress with animation
    public func setProgress(_ value: CGFloat, animated: Bool = true) {
        progress = value
    }
}

// MARK: - Step Progress View
/// Progress indicator with discrete steps
@IBDesignable
public final class StepProgressView: UIView {
    
    // MARK: - Properties
    @IBInspectable public var numberOfSteps: Int = 4 {
        didSet { setupSteps() }
    }
    
    @IBInspectable public var currentStep: Int = 0 {
        didSet { updateSteps() }
    }
    
    @IBInspectable public var completedColor: UIColor = .systemBlue
    @IBInspectable public var pendingColor: UIColor = .systemGray5
    @IBInspectable public var stepSize: CGFloat = 24
    
    public var stepTitles: [String] = [] {
        didSet { setupSteps() }
    }
    
    private var stepViews: [UIView] = []
    private var lineViews: [UIView] = []
    private var titleLabels: [UILabel] = []
    private let stackView = UIStackView()
    
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
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: stepSize / 2),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -stepSize / 2),
            stackView.heightAnchor.constraint(equalToConstant: stepSize)
        ])
        
        setupSteps()
    }
    
    private func setupSteps() {
        stepViews.forEach { $0.removeFromSuperview() }
        lineViews.forEach { $0.removeFromSuperview() }
        titleLabels.forEach { $0.removeFromSuperview() }
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        stepViews.removeAll()
        lineViews.removeAll()
        titleLabels.removeAll()
        
        for i in 0..<numberOfSteps {
            // Add line before step (except first)
            if i > 0 {
                let line = UIView()
                line.backgroundColor = pendingColor
                lineViews.append(line)
                
                let container = UIView()
                container.addSubview(line)
                line.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    line.centerYAnchor.constraint(equalTo: container.centerYAnchor),
                    line.leadingAnchor.constraint(equalTo: container.leadingAnchor),
                    line.trailingAnchor.constraint(equalTo: container.trailingAnchor),
                    line.heightAnchor.constraint(equalToConstant: 2),
                    container.widthAnchor.constraint(equalToConstant: 40)
                ])
                
                stackView.addArrangedSubview(container)
            }
            
            // Add step circle
            let stepContainer = UIView()
            let stepView = UIView()
            stepView.backgroundColor = pendingColor
            stepView.layer.cornerRadius = stepSize / 2
            stepViews.append(stepView)
            
            let numberLabel = UILabel()
            numberLabel.text = "\(i + 1)"
            numberLabel.font = .systemFont(ofSize: 12, weight: .bold)
            numberLabel.textColor = .white
            numberLabel.textAlignment = .center
            
            stepContainer.addSubview(stepView)
            stepView.addSubview(numberLabel)
            
            stepView.translatesAutoresizingMaskIntoConstraints = false
            numberLabel.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                stepView.centerXAnchor.constraint(equalTo: stepContainer.centerXAnchor),
                stepView.centerYAnchor.constraint(equalTo: stepContainer.centerYAnchor),
                stepView.widthAnchor.constraint(equalToConstant: stepSize),
                stepView.heightAnchor.constraint(equalToConstant: stepSize),
                stepContainer.widthAnchor.constraint(equalToConstant: stepSize),
                
                numberLabel.centerXAnchor.constraint(equalTo: stepView.centerXAnchor),
                numberLabel.centerYAnchor.constraint(equalTo: stepView.centerYAnchor)
            ])
            
            stackView.addArrangedSubview(stepContainer)
            
            // Add title label if available
            if i < stepTitles.count {
                let titleLabel = UILabel()
                titleLabel.text = stepTitles[i]
                titleLabel.font = .systemFont(ofSize: 11)
                titleLabel.textColor = ThemeManager.shared.currentTheme.textSecondaryColor
                titleLabel.textAlignment = .center
                titleLabels.append(titleLabel)
                
                addSubview(titleLabel)
                titleLabel.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    titleLabel.centerXAnchor.constraint(equalTo: stepView.centerXAnchor),
                    titleLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 8)
                ])
            }
        }
        
        updateSteps()
    }
    
    private func updateSteps() {
        for (index, stepView) in stepViews.enumerated() {
            let isCompleted = index < currentStep
            let isCurrent = index == currentStep
            
            UIView.animate(withDuration: 0.3) {
                stepView.backgroundColor = (isCompleted || isCurrent) ? self.completedColor : self.pendingColor
                stepView.transform = isCurrent ? CGAffineTransform(scaleX: 1.1, y: 1.1) : .identity
            }
        }
        
        for (index, line) in lineViews.enumerated() {
            let isCompleted = index < currentStep
            
            UIView.animate(withDuration: 0.3) {
                line.backgroundColor = isCompleted ? self.completedColor : self.pendingColor
            }
        }
        
        accessibilityValue = "Step \(currentStep + 1) of \(numberOfSteps)"
    }
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: stepTitles.isEmpty ? stepSize : stepSize + 24)
    }
}

// MARK: - Custom Slider
/// Customizable slider with value display
@IBDesignable
public final class CustomSlider: UIControl {
    
    // MARK: - Properties
    @IBInspectable public var value: CGFloat = 0.5 {
        didSet { updateThumbPosition() }
    }
    
    @IBInspectable public var minimumValue: CGFloat = 0
    @IBInspectable public var maximumValue: CGFloat = 1
    
    @IBInspectable public var minimumTrackColor: UIColor = .systemBlue {
        didSet { minimumTrackView.backgroundColor = minimumTrackColor }
    }
    
    @IBInspectable public var maximumTrackColor: UIColor = .systemGray5 {
        didSet { maximumTrackView.backgroundColor = maximumTrackColor }
    }
    
    @IBInspectable public var thumbColor: UIColor = .white {
        didSet { thumbView.backgroundColor = thumbColor }
    }
    
    @IBInspectable public var trackHeight: CGFloat = 4
    @IBInspectable public var thumbSize: CGFloat = 24
    @IBInspectable public var showsValue: Bool = false {
        didSet { valueLabel.isHidden = !showsValue }
    }
    
    public var valueFormatter: ((CGFloat) -> String)?
    
    private let maximumTrackView = UIView()
    private let minimumTrackView = UIView()
    private let thumbView = UIView()
    private let valueLabel = UILabel()
    private var thumbCenterXConstraint: NSLayoutConstraint?
    
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
        maximumTrackView.backgroundColor = maximumTrackColor
        maximumTrackView.layer.cornerRadius = trackHeight / 2
        addSubview(maximumTrackView)
        
        minimumTrackView.backgroundColor = minimumTrackColor
        minimumTrackView.layer.cornerRadius = trackHeight / 2
        addSubview(minimumTrackView)
        
        thumbView.backgroundColor = thumbColor
        thumbView.layer.cornerRadius = thumbSize / 2
        thumbView.layer.shadowColor = UIColor.black.cgColor
        thumbView.layer.shadowOpacity = 0.2
        thumbView.layer.shadowRadius = 4
        thumbView.layer.shadowOffset = CGSize(width: 0, height: 2)
        addSubview(thumbView)
        
        valueLabel.font = .systemFont(ofSize: 12, weight: .medium)
        valueLabel.textColor = ThemeManager.shared.currentTheme.textPrimaryColor
        valueLabel.textAlignment = .center
        valueLabel.isHidden = !showsValue
        addSubview(valueLabel)
        
        setupConstraints()
        setupGestures()
        
        isAccessibilityElement = true
        accessibilityTraits = .adjustable
    }
    
    private func setupConstraints() {
        maximumTrackView.translatesAutoresizingMaskIntoConstraints = false
        minimumTrackView.translatesAutoresizingMaskIntoConstraints = false
        thumbView.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        thumbCenterXConstraint = thumbView.centerXAnchor.constraint(equalTo: leadingAnchor, constant: thumbSize / 2)
        
        NSLayoutConstraint.activate([
            maximumTrackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: thumbSize / 2),
            maximumTrackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -thumbSize / 2),
            maximumTrackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            maximumTrackView.heightAnchor.constraint(equalToConstant: trackHeight),
            
            minimumTrackView.leadingAnchor.constraint(equalTo: maximumTrackView.leadingAnchor),
            minimumTrackView.trailingAnchor.constraint(equalTo: thumbView.centerXAnchor),
            minimumTrackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            minimumTrackView.heightAnchor.constraint(equalToConstant: trackHeight),
            
            thumbView.centerYAnchor.constraint(equalTo: centerYAnchor),
            thumbView.widthAnchor.constraint(equalToConstant: thumbSize),
            thumbView.heightAnchor.constraint(equalToConstant: thumbSize),
            thumbCenterXConstraint!,
            
            valueLabel.centerXAnchor.constraint(equalTo: thumbView.centerXAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: thumbView.topAnchor, constant: -4)
        ])
    }
    
    private func setupGestures() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        thumbView.addGestureRecognizer(panGesture)
        thumbView.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: self)
        updateValueFromLocation(location.x)
        
        switch gesture.state {
        case .began:
            UIView.animate(withDuration: 0.15) {
                self.thumbView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            }
        case .ended, .cancelled:
            UIView.animate(withDuration: 0.15) {
                self.thumbView.transform = .identity
            }
        default:
            break
        }
        
        sendActions(for: .valueChanged)
    }
    
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: self)
        updateValueFromLocation(location.x)
        sendActions(for: .valueChanged)
    }
    
    private func updateValueFromLocation(_ x: CGFloat) {
        let trackWidth = bounds.width - thumbSize
        let percentage = max(0, min(1, (x - thumbSize / 2) / trackWidth))
        value = minimumValue + percentage * (maximumValue - minimumValue)
    }
    
    private func updateThumbPosition() {
        let trackWidth = bounds.width - thumbSize
        let percentage = (value - minimumValue) / (maximumValue - minimumValue)
        let thumbX = thumbSize / 2 + trackWidth * percentage
        
        thumbCenterXConstraint?.constant = thumbX
        
        if let formatter = valueFormatter {
            valueLabel.text = formatter(value)
        } else {
            valueLabel.text = String(format: "%.1f", value)
        }
        
        accessibilityValue = valueLabel.text
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        updateThumbPosition()
    }
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: thumbSize)
    }
    
    // MARK: - Accessibility
    public override func accessibilityIncrement() {
        let step = (maximumValue - minimumValue) / 10
        value = min(maximumValue, value + step)
        sendActions(for: .valueChanged)
    }
    
    public override func accessibilityDecrement() {
        let step = (maximumValue - minimumValue) / 10
        value = max(minimumValue, value - step)
        sendActions(for: .valueChanged)
    }
}

// MARK: - Range Slider
/// Dual-thumb slider for selecting a range
@IBDesignable
public final class RangeSlider: UIControl {
    
    // MARK: - Properties
    @IBInspectable public var lowerValue: CGFloat = 0.25 {
        didSet { updateThumbs() }
    }
    
    @IBInspectable public var upperValue: CGFloat = 0.75 {
        didSet { updateThumbs() }
    }
    
    @IBInspectable public var minimumValue: CGFloat = 0
    @IBInspectable public var maximumValue: CGFloat = 1
    @IBInspectable public var minimumRange: CGFloat = 0.1
    
    @IBInspectable public var trackColor: UIColor = .systemGray5
    @IBInspectable public var rangeColor: UIColor = .systemBlue
    @IBInspectable public var thumbColor: UIColor = .white
    
    private let trackView = UIView()
    private let rangeView = UIView()
    private let lowerThumb = UIView()
    private let upperThumb = UIView()
    
    private var lowerThumbCenterX: NSLayoutConstraint?
    private var upperThumbCenterX: NSLayoutConstraint?
    private var activeThumb: UIView?
    
    private let thumbSize: CGFloat = 24
    private let trackHeight: CGFloat = 4
    
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
        trackView.backgroundColor = trackColor
        trackView.layer.cornerRadius = trackHeight / 2
        addSubview(trackView)
        
        rangeView.backgroundColor = rangeColor
        rangeView.layer.cornerRadius = trackHeight / 2
        addSubview(rangeView)
        
        for thumb in [lowerThumb, upperThumb] {
            thumb.backgroundColor = thumbColor
            thumb.layer.cornerRadius = thumbSize / 2
            thumb.layer.shadowColor = UIColor.black.cgColor
            thumb.layer.shadowOpacity = 0.2
            thumb.layer.shadowRadius = 4
            thumb.layer.shadowOffset = CGSize(width: 0, height: 2)
            addSubview(thumb)
            
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
            thumb.addGestureRecognizer(panGesture)
            thumb.isUserInteractionEnabled = true
        }
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        trackView.translatesAutoresizingMaskIntoConstraints = false
        rangeView.translatesAutoresizingMaskIntoConstraints = false
        lowerThumb.translatesAutoresizingMaskIntoConstraints = false
        upperThumb.translatesAutoresizingMaskIntoConstraints = false
        
        lowerThumbCenterX = lowerThumb.centerXAnchor.constraint(equalTo: leadingAnchor)
        upperThumbCenterX = upperThumb.centerXAnchor.constraint(equalTo: leadingAnchor)
        
        NSLayoutConstraint.activate([
            trackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: thumbSize / 2),
            trackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -thumbSize / 2),
            trackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            trackView.heightAnchor.constraint(equalToConstant: trackHeight),
            
            rangeView.leadingAnchor.constraint(equalTo: lowerThumb.centerXAnchor),
            rangeView.trailingAnchor.constraint(equalTo: upperThumb.centerXAnchor),
            rangeView.centerYAnchor.constraint(equalTo: centerYAnchor),
            rangeView.heightAnchor.constraint(equalToConstant: trackHeight),
            
            lowerThumb.centerYAnchor.constraint(equalTo: centerYAnchor),
            lowerThumb.widthAnchor.constraint(equalToConstant: thumbSize),
            lowerThumb.heightAnchor.constraint(equalToConstant: thumbSize),
            lowerThumbCenterX!,
            
            upperThumb.centerYAnchor.constraint(equalTo: centerYAnchor),
            upperThumb.widthAnchor.constraint(equalToConstant: thumbSize),
            upperThumb.heightAnchor.constraint(equalToConstant: thumbSize),
            upperThumbCenterX!
        ])
    }
    
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: self)
        let thumb = gesture.view!
        
        let trackWidth = bounds.width - thumbSize
        let percentage = max(0, min(1, (location.x - thumbSize / 2) / trackWidth))
        let newValue = minimumValue + percentage * (maximumValue - minimumValue)
        
        if thumb === lowerThumb {
            lowerValue = min(newValue, upperValue - minimumRange)
        } else {
            upperValue = max(newValue, lowerValue + minimumRange)
        }
        
        sendActions(for: .valueChanged)
    }
    
    private func updateThumbs() {
        let trackWidth = bounds.width - thumbSize
        
        let lowerPercentage = (lowerValue - minimumValue) / (maximumValue - minimumValue)
        let upperPercentage = (upperValue - minimumValue) / (maximumValue - minimumValue)
        
        lowerThumbCenterX?.constant = thumbSize / 2 + trackWidth * lowerPercentage
        upperThumbCenterX?.constant = thumbSize / 2 + trackWidth * upperPercentage
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        updateThumbs()
    }
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: thumbSize)
    }
}
