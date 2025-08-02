import SwiftUI

// MARK: - List Components
public struct CustomList<Content: View>: View {
    public let content: Content
    public let style: ListStyle
    public let spacing: CGFloat
    
    public init(
        style: ListStyle = .default,
        spacing: CGFloat = 8,
        @ViewBuilder content: () -> Content
    ) {
        self.content = content()
        self.style = style
        self.spacing = spacing
    }
    
    public var body: some View {
        ScrollView {
            LazyVStack(spacing: spacing) {
                content
            }
            .padding(.horizontal, 16)
        }
        .background(style.backgroundColor)
    }
}

public struct UserRowView: View {
    public let user: User
    public let showAvatar: Bool
    public let showSubtitle: Bool
    public let action: (() -> Void)?
    
    public init(
        user: User,
        showAvatar: Bool = true,
        showSubtitle: Bool = true,
        action: (() -> Void)? = nil
    ) {
        self.user = user
        self.showAvatar = showAvatar
        self.showSubtitle = showSubtitle
        self.action = action
    }
    
    public var body: some View {
        Button(action: { action?() }) {
            HStack(spacing: 12) {
                if showAvatar {
                    if let avatarURL = user.avatarURL {
                        AsyncImage(url: avatarURL) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            Image(systemName: "person.circle.fill")
                                .font(.title2)
                                .foregroundColor(.primary)
                        }
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                    } else {
                        Image(systemName: "person.circle.fill")
                            .font(.title2)
                            .foregroundColor(.primary)
                            .frame(width: 50, height: 50)
                    }
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(user.name)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    
                    if showSubtitle {
                        Text(user.email)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(10)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

public struct SettingsRowView: View {
    public let icon: String
    public let title: String
    public let subtitle: String?
    public let accessory: RowAccessory
    public let action: (() -> Void)?
    
    public init(
        icon: String,
        title: String,
        subtitle: String? = nil,
        accessory: RowAccessory = .none,
        action: (() -> Void)? = nil
    ) {
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
        self.accessory = accessory
        self.action = action
    }
    
    public var body: some View {
        Button(action: { action?() }) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundColor(.primary)
                    .frame(width: 24)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                    
                    if let subtitle = subtitle {
                        Text(subtitle)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                
                Spacer()
                
                accessoryView
            }
            .padding()
            .background(Color(.systemBackground))
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    @ViewBuilder
    private var accessoryView: some View {
        switch accessory {
        case .none:
            EmptyView()
        case .chevron:
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.secondary)
        case .switch:
            Toggle("", isOn: .constant(true))
                .labelsHidden()
        case .badge(let text):
            Text(text)
                .font(.caption2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.horizontal, 6)
                .padding(.vertical, 2)
                .background(Color.red)
                .clipShape(Capsule())
        case .custom(let view):
            view
        }
    }
}

public struct ProductRowView: View {
    public let product: Product
    public let showImage: Bool
    public let showPrice: Bool
    public let action: (() -> Void)?
    
    public init(
        product: Product,
        showImage: Bool = true,
        showPrice: Bool = true,
        action: (() -> Void)? = nil
    ) {
        self.product = product
        self.showImage = showImage
        self.showPrice = showPrice
        self.action = action
    }
    
    public var body: some View {
        Button(action: { action?() }) {
            HStack(spacing: 12) {
                if showImage {
                    if let imageURL = product.imageURL {
                        AsyncImage(url: imageURL) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            Rectangle()
                                .fill(Color(.systemGray5))
                        }
                        .frame(width: 60, height: 60)
                        .cornerRadius(8)
                    } else {
                        Rectangle()
                            .fill(Color(.systemGray5))
                            .frame(width: 60, height: 60)
                            .cornerRadius(8)
                    }
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(product.name)
                        .font(.headline)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                        .lineLimit(2)
                    
                    if let description = product.description {
                        Text(description)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                    }
                    
                    if showPrice {
                        HStack {
                            Text(product.price)
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                            
                            if let originalPrice = product.originalPrice {
                                Text(originalPrice)
                                    .font(.caption)
                                    .strikethrough()
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            
                            if let rating = product.rating {
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
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(10)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - List Style
public struct ListStyle {
    public let backgroundColor: Color
    public let cornerRadius: CGFloat
    public let shadowColor: Color
    public let shadowRadius: CGFloat
    
    public init(
        backgroundColor: Color = Color(.systemGroupedBackground),
        cornerRadius: CGFloat = 0,
        shadowColor: Color = .clear,
        shadowRadius: CGFloat = 0
    ) {
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.shadowColor = shadowColor
        self.shadowRadius = shadowRadius
    }
    
    public static let `default` = ListStyle()
    public static let grouped = ListStyle(backgroundColor: Color(.systemGroupedBackground))
    public static let insetGrouped = ListStyle(backgroundColor: Color(.systemGroupedBackground))
    public static let plain = ListStyle(backgroundColor: Color(.systemBackground))
}

// MARK: - Row Accessory
public enum RowAccessory {
    case none
    case chevron
    case `switch`
    case badge(String)
    case custom(AnyView)
}

// MARK: - Models
public struct User {
    public let id: String
    public let name: String
    public let email: String
    public let avatarURL: URL?
    
    public init(id: String, name: String, email: String, avatarURL: URL? = nil) {
        self.id = id
        self.name = name
        self.email = email
        self.avatarURL = avatarURL
    }
}

public struct Product {
    public let id: String
    public let name: String
    public let description: String?
    public let price: String
    public let originalPrice: String?
    public let imageURL: URL?
    public let rating: Double?
    
    public init(
        id: String,
        name: String,
        description: String? = nil,
        price: String,
        originalPrice: String? = nil,
        imageURL: URL? = nil,
        rating: Double? = nil
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.price = price
        self.originalPrice = originalPrice
        self.imageURL = imageURL
        self.rating = rating
    }
} 