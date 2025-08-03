import SwiftUI

// MARK: - Navigation Components
public struct CustomTabBar: View {
    @Binding public var selectedTab: Int
    public let tabs: [TabItem]
    public let backgroundColor: Color
    public let selectedColor: Color
    public let unselectedColor: Color
    
    public init(
        selectedTab: Binding<Int>,
        tabs: [TabItem],
        backgroundColor: Color = Color.white,
        selectedColor: Color = .blue,
        unselectedColor: Color = .gray
    ) {
        self._selectedTab = selectedTab
        self.tabs = tabs
        self.backgroundColor = backgroundColor
        self.selectedColor = selectedColor
        self.unselectedColor = unselectedColor
    }
    
    public var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(tabs.enumerated()), id: \.offset) { index, item in
                TabBarItem(
                    item: item,
                    isSelected: selectedTab == index,
                    selectedColor: selectedColor,
                    unselectedColor: unselectedColor
                ) {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        selectedTab = index
                    }
                }
            }
        }
        .background(backgroundColor)
        .overlay(
            Rectangle()
                .frame(height: 0.5)
                .foregroundColor(Color.gray.opacity(0.1)),
            alignment: .top
        )
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: -2)
    }
}

public struct TabItem {
    public let icon: String
    public let title: String
    public let badge: String?
    
    public init(
        icon: String,
        title: String,
        badge: String? = nil
    ) {
        self.icon = icon
        self.title = title
        self.badge = badge
    }
}

public struct TabBarItem: View {
    public let item: TabItem
    public let isSelected: Bool
    public let selectedColor: Color
    public let unselectedColor: Color
    public let action: () -> Void
    
    public var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                ZStack {
                    Image(systemName: item.icon)
                        .font(.system(size: 24))
                        .foregroundColor(isSelected ? selectedColor : unselectedColor)
                        .scaleEffect(isSelected ? 1.1 : 1.0)
                        .animation(.easeInOut(duration: 0.2), value: isSelected)
                    
                    if let badge = item.badge {
                        Text(badge)
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color.red)
                            .clipShape(Capsule())
                            .offset(x: 12, y: -12)
                    }
                }
                
                Text(item.title)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(isSelected ? selectedColor : unselectedColor)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
    }
}

public struct CustomNavigationBar: View {
    public let title: String
    public let leftButton: NavigationButton?
    public let rightButton: NavigationButton?
    public let backgroundColor: Color
    public let titleColor: Color
    
    public init(
        title: String,
        leftButton: NavigationButton? = nil,
        rightButton: NavigationButton? = nil,
        backgroundColor: Color = Color.white,
        titleColor: Color = .primary
    ) {
        self.title = title
        self.leftButton = leftButton
        self.rightButton = rightButton
        self.backgroundColor = backgroundColor
        self.titleColor = titleColor
    }
    
    public var body: some View {
        HStack {
            if let leftButton = leftButton {
                Button(action: leftButton.action) {
                    Image(systemName: leftButton.icon)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(leftButton.isEnabled ? .blue : .gray)
                }
                .disabled(!leftButton.isEnabled)
            }
            
            Spacer()
            
            Text(title)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(titleColor)
                .lineLimit(1)
            
            Spacer()
            
            if let rightButton = rightButton {
                Button(action: rightButton.action) {
                    Image(systemName: rightButton.icon)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(rightButton.isEnabled ? .blue : .gray)
                }
                .disabled(!rightButton.isEnabled)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(backgroundColor)
        .overlay(
            Rectangle()
                .frame(height: 0.5)
                .foregroundColor(Color.gray.opacity(0.1)),
            alignment: .bottom
        )
    }
}

public struct NavigationButton {
    public let icon: String
    public let action: () -> Void
    public let isEnabled: Bool
    
    public init(
        icon: String,
        isEnabled: Bool = true,
        action: @escaping () -> Void
    ) {
        self.icon = icon
        self.action = action
        self.isEnabled = isEnabled
    }
}

public struct CustomSideMenu: View {
    @Binding public var isPresented: Bool
    public let menuItems: [MenuItem]
    public let backgroundColor: Color
    public let overlayColor: Color
    
    public init(
        isPresented: Binding<Bool>,
        menuItems: [MenuItem],
        backgroundColor: Color = Color.white,
        overlayColor: Color = Color.black.opacity(0.5)
    ) {
        self._isPresented = isPresented
        self.menuItems = menuItems
        self.backgroundColor = backgroundColor
        self.overlayColor = overlayColor
    }
    
    public var body: some View {
        ZStack {
            if isPresented {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            isPresented = false
                        }
                    }
                
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(menuItems, id: \.id) { item in
                            MenuItemView(item: item) {
                                item.action()
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    isPresented = false
                                }
                            }
                        }
                        
                        Spacer()
                    }
                    .frame(width: 280)
                    .background(backgroundColor)
                    .offset(x: isPresented ? 0 : -280)
                    
                    Spacer()
                }
            }
        }
        .animation(.easeInOut(duration: 0.3), value: isPresented)
    }
}

public struct MenuItem {
    public let id = UUID()
    public let icon: String
    public let title: String
    public let subtitle: String?
    public let action: () -> Void
    
    public init(
        icon: String,
        title: String,
        subtitle: String? = nil,
        action: @escaping () -> Void
    ) {
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
        self.action = action
    }
}

public struct MenuItemView: View {
    public let item: MenuItem
    public let onTap: () -> Void
    
    public var body: some View {
        Button(action: onTap) {
            HStack(spacing: 12) {
                Image(systemName: item.icon)
                    .font(.system(size: 18))
                    .foregroundColor(.blue)
                    .frame(width: 24)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(item.title)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.primary)
                    
                    if let subtitle = item.subtitle {
                        Text(subtitle)
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.secondary)
                    }
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

public struct CustomBreadcrumbs: View {
    public let items: [BreadcrumbItem]
    public let onItemTap: (BreadcrumbItem) -> Void
    
    public init(
        items: [BreadcrumbItem],
        onItemTap: @escaping (BreadcrumbItem) -> Void
    ) {
        self.items = items
        self.onItemTap = onItemTap
    }
    
    public var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                    HStack(spacing: 4) {
                        Button(action: {
                            onItemTap(item)
                        }) {
                            Text(item.title)
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(index == items.count - 1 ? .primary : .blue)
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        if index < items.count - 1 {
                            Image(systemName: "chevron.right")
                                .font(.system(size: 10))
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .padding(.vertical, 8)
        .background(Color.gray.opacity(0.1))
    }
}

public struct BreadcrumbItem {
    public let title: String
    public let id: String
    
    public init(title: String, id: String) {
        self.title = title
        self.id = id
    }
}

public struct CustomSearchBar: View {
    @Binding public var text: String
    public let placeholder: String
    public let onSearch: (() -> Void)?
    public let onCancel: (() -> Void)?
    @State private var isEditing = false
    
    public init(
        text: Binding<String>,
        placeholder: String = "Search...",
        onSearch: (() -> Void)? = nil,
        onCancel: (() -> Void)? = nil
    ) {
        self._text = text
        self.placeholder = placeholder
        self.onSearch = onSearch
        self.onCancel = onCancel
    }
    
    public var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
                    .font(.system(size: 16))
                
                TextField(placeholder, text: $text)
                    .font(.system(size: 16, weight: .regular))
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            isEditing = true
                        }
                    }
                    .onSubmit {
                        onSearch?()
                    }
                
                if !text.isEmpty {
                    Button(action: {
                        text = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.secondary)
                            .font(.system(size: 16))
                    }
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
            
            if isEditing {
                Button("Cancel") {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isEditing = false
                        text = ""
                    }
                    onCancel?()
                }
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.blue)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}

public struct CustomStepIndicator: View {
    public let steps: [String]
    public let currentStep: Int
    public let activeColor: Color
    public let inactiveColor: Color
    
    public init(
        steps: [String],
        currentStep: Int,
        activeColor: Color = .blue,
        inactiveColor: Color = .gray
    ) {
        self.steps = steps
        self.currentStep = currentStep
        self.activeColor = activeColor
        self.inactiveColor = inactiveColor
    }
    
    public var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(steps.enumerated()), id: \.offset) { index, step in
                HStack(spacing: 8) {
                    ZStack {
                        Circle()
                            .fill(index <= currentStep ? activeColor : inactiveColor)
                            .frame(width: 24, height: 24)
                        
                        if index < currentStep {
                            Image(systemName: "checkmark")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.white)
                        } else {
                            Text("\(index + 1)")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.white)
                        }
                    }
                    
                    if index < steps.count - 1 {
                        Rectangle()
                            .fill(index < currentStep ? activeColor : inactiveColor)
                            .frame(height: 2)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
}

// MARK: - Navigation Extensions
public extension View {
    func customTabBarStyle() -> some View {
        self
            .background(Color.white)
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: -2)
    }
    
    func customNavigationBarStyle() -> some View {
        self
            .background(Color.white)
            .overlay(
                Rectangle()
                    .frame(height: 0.5)
                    .foregroundColor(Color.gray.opacity(0.1)),
                alignment: .bottom
            )
    }
} 