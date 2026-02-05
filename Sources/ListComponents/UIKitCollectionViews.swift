import UIKit

// MARK: - Custom Flow Layouts

/// Waterfall/Pinterest style layout
public final class WaterfallLayout: UICollectionViewLayout {
    
    // MARK: - Properties
    public var numberOfColumns: Int = 2
    public var cellPadding: CGFloat = 8
    public var delegate: WaterfallLayoutDelegate?
    
    private var cache: [UICollectionViewLayoutAttributes] = []
    private var contentHeight: CGFloat = 0
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    // MARK: - Layout
    public override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    public override func prepare() {
        guard cache.isEmpty, let collectionView = collectionView else { return }
        
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset: [CGFloat] = []
        var yOffset: [CGFloat] = Array(repeating: 0, count: numberOfColumns)
        
        for column in 0..<numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        
        var column = 0
        
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            
            let itemHeight = delegate?.collectionView(collectionView, heightForItemAt: indexPath) ?? 180
            let height = cellPadding * 2 + itemHeight
            
            let frame = CGRect(
                x: xOffset[column],
                y: yOffset[column],
                width: columnWidth,
                height: height
            )
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + height
            
            // Move to shortest column
            column = yOffset.firstIndex(of: yOffset.min()!) ?? 0
        }
    }
    
    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cache.filter { $0.frame.intersects(rect) }
    }
    
    public override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
    
    public override func invalidateLayout() {
        super.invalidateLayout()
        cache.removeAll()
        contentHeight = 0
    }
}

public protocol WaterfallLayoutDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView, heightForItemAt indexPath: IndexPath) -> CGFloat
}

// MARK: - Carousel Layout
/// Horizontal carousel with centered items
public final class CarouselLayout: UICollectionViewFlowLayout {
    
    // MARK: - Properties
    public var itemScale: CGFloat = 0.85
    public var itemAlpha: CGFloat = 0.6
    
    // MARK: - Initialization
    public override init() {
        super.init()
        scrollDirection = .horizontal
        minimumLineSpacing = 20
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Layout
    public override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        
        let inset = (collectionView.bounds.width - itemSize.width) / 2
        collectionView.contentInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        collectionView.decelerationRate = .fast
    }
    
    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect),
              let collectionView = collectionView else { return nil }
        
        let centerX = collectionView.contentOffset.x + collectionView.bounds.width / 2
        
        return attributes.map { attribute in
            let copy = attribute.copy() as! UICollectionViewLayoutAttributes
            let distance = abs(copy.center.x - centerX)
            let scale = max(itemScale, 1 - distance / collectionView.bounds.width * (1 - itemScale))
            let alpha = max(itemAlpha, 1 - distance / collectionView.bounds.width * (1 - itemAlpha))
            
            copy.transform = CGAffineTransform(scaleX: scale, y: scale)
            copy.alpha = alpha
            copy.zIndex = Int(scale * 100)
            
            return copy
        }
    }
    
    public override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    public override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return proposedContentOffset }
        
        let targetRect = CGRect(
            x: proposedContentOffset.x,
            y: 0,
            width: collectionView.bounds.width,
            height: collectionView.bounds.height
        )
        
        guard let attributes = layoutAttributesForElements(in: targetRect) else { return proposedContentOffset }
        
        let centerX = proposedContentOffset.x + collectionView.bounds.width / 2
        var closestAttribute: UICollectionViewLayoutAttributes?
        var closestDistance: CGFloat = .greatestFiniteMagnitude
        
        for attribute in attributes {
            let distance = abs(attribute.center.x - centerX)
            if distance < closestDistance {
                closestDistance = distance
                closestAttribute = attribute
            }
        }
        
        guard let closest = closestAttribute else { return proposedContentOffset }
        
        return CGPoint(
            x: closest.center.x - collectionView.bounds.width / 2,
            y: proposedContentOffset.y
        )
    }
}

// MARK: - Sticky Header Layout
/// Layout with sticky section headers
public final class StickyHeaderLayout: UICollectionViewFlowLayout {
    
    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect),
              let collectionView = collectionView else { return nil }
        
        var result = [UICollectionViewLayoutAttributes]()
        var missingSections = Set<Int>()
        
        for attribute in attributes {
            let copy = attribute.copy() as! UICollectionViewLayoutAttributes
            
            if copy.representedElementKind == UICollectionView.elementKindSectionHeader {
                missingSections.remove(copy.indexPath.section)
            } else {
                missingSections.insert(copy.indexPath.section)
            }
            
            result.append(copy)
        }
        
        for section in missingSections {
            let indexPath = IndexPath(item: 0, section: section)
            if let header = layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: indexPath) {
                result.append(header)
            }
        }
        
        for attribute in result {
            if attribute.representedElementKind == UICollectionView.elementKindSectionHeader {
                let section = attribute.indexPath.section
                let numberOfItems = collectionView.numberOfItems(inSection: section)
                
                guard numberOfItems > 0 else { continue }
                
                let firstIndexPath = IndexPath(item: 0, section: section)
                let lastIndexPath = IndexPath(item: numberOfItems - 1, section: section)
                
                let firstItem = layoutAttributesForItem(at: firstIndexPath)
                let lastItem = layoutAttributesForItem(at: lastIndexPath)
                
                let minY = (firstItem?.frame.minY ?? 0) - attribute.frame.height - sectionInset.top
                let maxY = (lastItem?.frame.maxY ?? 0) - attribute.frame.height + sectionInset.bottom
                
                let offsetY = min(max(collectionView.contentOffset.y + collectionView.safeAreaInsets.top, minY), maxY)
                
                attribute.frame.origin.y = offsetY
                attribute.zIndex = 1024
            }
        }
        
        return result
    }
    
    public override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}

// MARK: - Grid Layout
/// Simple grid layout with equal-sized cells
public final class GridLayout: UICollectionViewFlowLayout {
    
    // MARK: - Properties
    public var columns: Int = 3 {
        didSet { invalidateLayout() }
    }
    
    public var cellSpacing: CGFloat = 4 {
        didSet {
            minimumInteritemSpacing = cellSpacing
            minimumLineSpacing = cellSpacing
            invalidateLayout()
        }
    }
    
    // MARK: - Initialization
    public override init() {
        super.init()
        minimumInteritemSpacing = cellSpacing
        minimumLineSpacing = cellSpacing
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Layout
    public override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        
        let totalSpacing = cellSpacing * CGFloat(columns - 1)
        let width = (collectionView.bounds.width - totalSpacing - sectionInset.left - sectionInset.right) / CGFloat(columns)
        
        itemSize = CGSize(width: width, height: width)
    }
}

// MARK: - Base Collection View Cell
/// Base class for custom collection view cells
open class BaseCollectionViewCell: UICollectionViewCell {
    
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        setupConstraints()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
        setupConstraints()
    }
    
    open func setupCell() {
        contentView.backgroundColor = ThemeManager.shared.currentTheme.surfaceColor
        contentView.layer.cornerRadius = ThemeManager.shared.currentTheme.cornerRadiusMedium
        contentView.clipsToBounds = true
    }
    
    open func setupConstraints() {}
    
    // MARK: - Highlight
    open override var isHighlighted: Bool {
        didSet {
            let scale: CGAffineTransform = isHighlighted ? CGAffineTransform(scaleX: 0.95, y: 0.95) : .identity
            
            if !AccessibilityHelper.isReduceMotionEnabled {
                UIView.animate(withDuration: 0.15, delay: 0, options: [.curveEaseOut]) {
                    self.transform = scale
                }
            } else {
                transform = scale
            }
        }
    }
}

// MARK: - Image Cell
/// Cell for displaying images in grid
public final class ImageCell: BaseCollectionViewCell {
    
    public let imageView = UIImageView()
    public let overlayView = UIView()
    public let titleLabel = UILabel()
    
    public override func setupCell() {
        super.setupCell()
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        overlayView.isHidden = true
        
        titleLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
    }
    
    public override func setupConstraints() {
        contentView.addSubview(imageView)
        contentView.addSubview(overlayView)
        contentView.addSubview(titleLabel)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            overlayView.topAnchor.constraint(equalTo: contentView.topAnchor),
            overlayView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            overlayView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    public func configure(image: UIImage?, title: String? = nil) {
        imageView.image = image
        
        if let title = title {
            titleLabel.text = title
            overlayView.isHidden = false
            titleLabel.isHidden = false
        } else {
            overlayView.isHidden = true
            titleLabel.isHidden = true
        }
    }
}

// MARK: - Product Cell
/// Cell for e-commerce product display
public final class ProductCell: BaseCollectionViewCell {
    
    public let imageView = UIImageView()
    public let titleLabel = UILabel()
    public let priceLabel = UILabel()
    public let originalPriceLabel = UILabel()
    public let ratingView = UIStackView()
    public let favoriteButton = UIButton(type: .system)
    
    public var onFavorite: (() -> Void)?
    
    public override func setupCell() {
        super.setupCell()
        
        let theme = ThemeManager.shared.currentTheme
        
        contentView.backgroundColor = theme.backgroundColor
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = theme.borderColor.cgColor
        
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        titleLabel.font = theme.fontMedium.withSize(14)
        titleLabel.textColor = theme.textPrimaryColor
        titleLabel.numberOfLines = 2
        
        priceLabel.font = theme.fontBold.withSize(16)
        priceLabel.textColor = theme.textPrimaryColor
        
        originalPriceLabel.font = .systemFont(ofSize: 12)
        originalPriceLabel.textColor = theme.textSecondaryColor
        
        ratingView.axis = .horizontal
        ratingView.spacing = 2
        
        favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        favoriteButton.tintColor = theme.errorColor
        favoriteButton.addTarget(self, action: #selector(favoriteTapped), for: .touchUpInside)
    }
    
    public override func setupConstraints() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(originalPriceLabel)
        contentView.addSubview(ratingView)
        contentView.addSubview(favoriteButton)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        originalPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            imageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8),
            
            favoriteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            favoriteButton.widthAnchor.constraint(equalToConstant: 32),
            favoriteButton.heightAnchor.constraint(equalToConstant: 32),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            ratingView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            ratingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            
            priceLabel.topAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: 4),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            priceLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8),
            
            originalPriceLabel.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor),
            originalPriceLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 8)
        ])
    }
    
    @objc private func favoriteTapped() {
        favoriteButton.isSelected.toggle()
        onFavorite?()
    }
    
    public func configure(
        image: UIImage?,
        title: String,
        price: String,
        originalPrice: String? = nil,
        rating: Double = 0,
        isFavorite: Bool = false
    ) {
        imageView.image = image
        titleLabel.text = title
        priceLabel.text = price
        favoriteButton.isSelected = isFavorite
        
        if let original = originalPrice {
            let attributedText = NSAttributedString(
                string: original,
                attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
            )
            originalPriceLabel.attributedText = attributedText
            originalPriceLabel.isHidden = false
        } else {
            originalPriceLabel.isHidden = true
        }
        
        // Setup rating stars
        ratingView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for i in 1...5 {
            let starImage = UIImageView()
            starImage.contentMode = .scaleAspectFit
            starImage.tintColor = .systemYellow
            
            if Double(i) <= rating {
                starImage.image = UIImage(systemName: "star.fill")
            } else if Double(i) - 0.5 <= rating {
                starImage.image = UIImage(systemName: "star.leadinghalf.filled")
            } else {
                starImage.image = UIImage(systemName: "star")
            }
            
            NSLayoutConstraint.activate([
                starImage.widthAnchor.constraint(equalToConstant: 12),
                starImage.heightAnchor.constraint(equalToConstant: 12)
            ])
            
            ratingView.addArrangedSubview(starImage)
        }
    }
}

// MARK: - Tag Cell
/// Cell for displaying tags/chips
public final class TagCell: BaseCollectionViewCell {
    
    public let titleLabel = UILabel()
    
    public override func setupCell() {
        super.setupCell()
        
        let theme = ThemeManager.shared.currentTheme
        
        contentView.backgroundColor = theme.primaryColor.withAlphaComponent(0.1)
        contentView.layer.cornerRadius = 16
        
        titleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        titleLabel.textColor = theme.primaryColor
        titleLabel.textAlignment = .center
    }
    
    public override func setupConstraints() {
        contentView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    public func configure(title: String, isSelected: Bool = false) {
        let theme = ThemeManager.shared.currentTheme
        
        titleLabel.text = title
        
        if isSelected {
            contentView.backgroundColor = theme.primaryColor
            titleLabel.textColor = .white
        } else {
            contentView.backgroundColor = theme.primaryColor.withAlphaComponent(0.1)
            titleLabel.textColor = theme.primaryColor
        }
    }
}
