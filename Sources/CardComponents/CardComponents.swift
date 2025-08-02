import SwiftUI

// MARK: - Card Components
public struct Card<Content: View>: View {
    public let content: Content
    public let style: CardStyle
    public let padding: EdgeInsets
    
    public init(
        style: CardStyle = .default,
        padding: EdgeInsets = EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16),
        @ViewBuilder content: () -> Content
    ) {
        self.style = style
        self.padding = padding
        self.content = content()
    }
    
    public var body: some View {
        content
            .padding(padding)
            .background(style.backgroundColor)
            .cornerRadius(style.cornerRadius)
            .shadow(
                color: style.shadowColor,
                radius: style.shadowRadius,
                x: style.shadowOffset.x,
                y: style.shadowOffset.y
            )
    }
}

public struct ProfileCard: View {
    public let avatar: String
    public let name: String
    public let subtitle: String?
    public let action: (() -> Void)?
    
    public init(
        avatar: String,
        name: String,
        subtitle: String? = nil,
        action: (() -> Void)? = nil
    ) {
        self.avatar = avatar
        self.name = name
        self.subtitle = subtitle
        self.action = action
    }
    
    public var body: some View {
        Card {
            HStack(spacing: 12) {
                Image(systemName: avatar)
                    .font(.system(size: 40))
                    .foregroundColor(.primary)
                    .frame(width: 50, height: 50)
                    .background(Color(.systemGray6))
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(name)
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    if let subtitle = subtitle {
                        Text(subtitle)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                
                Spacer()
                
                if let action = action {
                    Button(action: action) {
                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
    }
}

public struct InfoCard: View {
    public let icon: String
    public let title: String
    public let description: String
    public let action: (() -> Void)?
    
    public init(
        icon: String,
        title: String,
        description: String,
        action: (() -> Void)? = nil
    ) {
        self.icon = icon
        self.title = title
        self.description = description
        self.action = action
    }
    
    public var body: some View {
        Card {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: icon)
                        .font(.title2)
                        .foregroundColor(.blue)
                    
                    Spacer()
                    
                    if let action = action {
                        Button(action: action) {
                            Image(systemName: "ellipsis")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                
                Text(title)
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Text(description)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
            }
        }
    }
}

public struct ProductCard: View {
    public let imageURL: String?
    public let title: String
    public let price: String
    public let originalPrice: String?
    public let rating: Double?
    public let action: (() -> Void)?
    
    public init(
        imageURL: String?,
        title: String,
        price: String,
        originalPrice: String? = nil,
        rating: Double? = nil,
        action: (() -> Void)? = nil
    ) {
        self.imageURL = imageURL
        self.title = title
        self.price = price
        self.originalPrice = originalPrice
        self.rating = rating
        self.action = action
    }
    
    public var body: some View {
        Card {
            VStack(alignment: .leading, spacing: 12) {
                // Product Image
                if let imageURL = imageURL {
                    AsyncImage(url: URL(string: imageURL)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Rectangle()
                            .fill(Color(.systemGray5))
                    }
                    .frame(height: 120)
                    .clipped()
                    .cornerRadius(8)
                } else {
                    Rectangle()
                        .fill(Color(.systemGray5))
                        .frame(height: 120)
                        .cornerRadius(8)
                }
                
                // Product Info
                VStack(alignment: .leading, spacing: 8) {
                    Text(title)
                        .font(.headline)
                        .fontWeight(.medium)
                        .lineLimit(2)
                    
                    HStack {
                        Text(price)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                        
                        if let originalPrice = originalPrice {
                            Text(originalPrice)
                                .font(.caption)
                                .strikethrough()
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        if let rating = rating {
                            HStack(spacing: 2) {
                                Image(systemName: "star.fill")
                                    .font(.caption)
                                    .foregroundColor(.yellow)
                                Text(String(format: "%.1f", rating))
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
        }
        .onTapGesture {
            action?()
        }
    }
}

public struct PostCard: View {
    public let authorName: String
    public let authorAvatar: String?
    public let content: String
    public let imageURL: String?
    public let timestamp: Date
    public let likesCount: Int
    public let commentsCount: Int
    public let onLike: (() -> Void)?
    public let onComment: (() -> Void)?
    public let onShare: (() -> Void)?
    
    public init(
        authorName: String,
        authorAvatar: String? = nil,
        content: String,
        imageURL: String? = nil,
        timestamp: Date,
        likesCount: Int,
        commentsCount: Int,
        onLike: (() -> Void)? = nil,
        onComment: (() -> Void)? = nil,
        onShare: (() -> Void)? = nil
    ) {
        self.authorName = authorName
        self.authorAvatar = authorAvatar
        self.content = content
        self.imageURL = imageURL
        self.timestamp = timestamp
        self.likesCount = likesCount
        self.commentsCount = commentsCount
        self.onLike = onLike
        self.onComment = onComment
        self.onShare = onShare
    }
    
    public var body: some View {
        Card {
            VStack(alignment: .leading, spacing: 12) {
                // Author Info
                HStack {
                    if let avatar = authorAvatar {
                        AsyncImage(url: URL(string: avatar)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            Image(systemName: "person.circle.fill")
                                .font(.title2)
                                .foregroundColor(.primary)
                        }
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                    } else {
                        Image(systemName: "person.circle.fill")
                            .font(.title2)
                            .foregroundColor(.primary)
                            .frame(width: 40, height: 40)
                    }
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(authorName)
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        Text(timestamp, style: .relative)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image(systemName: "ellipsis")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                
                // Content
                Text(content)
                    .font(.body)
                    .lineLimit(nil)
                
                // Image
                if let imageURL = imageURL {
                    AsyncImage(url: URL(string: imageURL)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        Rectangle()
                            .fill(Color(.systemGray5))
                    }
                    .frame(maxHeight: 200)
                    .cornerRadius(8)
                }
                
                // Action Buttons
                HStack(spacing: 20) {
                    Button(action: { onLike?() }) {
                        HStack(spacing: 4) {
                            Image(systemName: "heart")
                            Text("\(likesCount)")
                        }
                        .foregroundColor(.red)
                    }
                    
                    Button(action: { onComment?() }) {
                        HStack(spacing: 4) {
                            Image(systemName: "bubble.left")
                            Text("\(commentsCount)")
                        }
                        .foregroundColor(.primary)
                    }
                    
                    Button(action: { onShare?() }) {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(.primary)
                    }
                    
                    Spacer()
                }
                .font(.subheadline)
            }
        }
    }
}

// MARK: - Card Style
public struct CardStyle {
    public let backgroundColor: Color
    public let cornerRadius: CGFloat
    public let shadowColor: Color
    public let shadowRadius: CGFloat
    public let shadowOffset: CGSize
    
    public init(
        backgroundColor: Color = .white,
        cornerRadius: CGFloat = 12,
        shadowColor: Color = .black.opacity(0.1),
        shadowRadius: CGFloat = 4,
        shadowOffset: CGSize = CGSize(width: 0, height: 2)
    ) {
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.shadowColor = shadowColor
        self.shadowRadius = shadowRadius
        self.shadowOffset = shadowOffset
    }
    
    public static let `default` = CardStyle()
    public static let elevated = CardStyle(shadowRadius: 8, shadowOffset: CGSize(width: 0, height: 4))
    public static let outlined = CardStyle(backgroundColor: .clear, shadowColor: .clear)
    public static let flat = CardStyle(shadowColor: .clear)
}

// MARK: - Card Extensions
public extension View {
    func cardStyle(_ style: CardStyle = .default) -> some View {
        self.background(style.backgroundColor)
            .cornerRadius(style.cornerRadius)
            .shadow(
                color: style.shadowColor,
                radius: style.shadowRadius,
                x: style.shadowOffset.x,
                y: style.shadowOffset.y
            )
    }
} 