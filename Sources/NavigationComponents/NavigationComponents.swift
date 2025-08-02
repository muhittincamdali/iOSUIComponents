import SwiftUI

// MARK: - Navigation Components
public struct CustomNavigationBar: View {
    public let title: String
    public let leftButton: NavigationButton?
    public let rightButton: NavigationButton?
    public let backgroundColor: Color
    
    public init(
        title: String,
        leftButton: NavigationButton? = nil,
        rightButton: NavigationButton? = nil,
        backgroundColor: Color = .systemBackground
    ) {
        self.title = title
        self.leftButton = leftButton
        self.rightButton = rightButton
        self.backgroundColor = backgroundColor
    }
    
    public var body: some View {
        HStack {
            if let leftButton = leftButton {
                Button(action: leftButton.action) {
                    Image(systemName: leftButton.icon)
                        .font(.title3)
                        .foregroundColor(leftButton.isEnabled ? .primary : .secondary)
                }
                .disabled(!leftButton.isEnabled)
            }
            
            Spacer()
            
            Text(title)
                .font(.headline)
                .fontWeight(.semibold)
            
            Spacer()
            
            if let rightButton = rightButton {
                Button(action: rightButton.action) {
                    Image(systemName: rightButton.icon)
                        .font(.title3)
                        .foregroundColor(rightButton.isEnabled ? .primary : .secondary)
                }
                .disabled(!rightButton.isEnabled)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(backgroundColor)
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

public struct CustomTabBar: View {
    @Binding public var selectedTab: Int
    public let tabs: [TabItem]
    
    public init(
        selectedTab: Binding<Int>,
        tabs: [TabItem]
    ) {
        self._selectedTab = selectedTab
        self.tabs = tabs
    }
    
    public var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(tabs.enumerated()), id: \.offset) { index, tab in
                Button(action: {
                    selectedTab = index
                }) {
                    VStack(spacing: 4) {
                        ZStack {
                            Image(systemName: tab.icon)
                                .font(.title3)
                                .foregroundColor(selectedTab == index ? .blue : .secondary)
                            
                            if let badge = tab.badge {
                                Text(badge)
                                    .font(.caption2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 4)
                                    .padding(.vertical, 2)
                                    .background(Color.red)
                                    .clipShape(Capsule())
                                    .offset(x: 12, y: -8)
                            }
                        }
                        
                        Text(tab.title)
                            .font(.caption)
                            .foregroundColor(selectedTab == index ? .blue : .secondary)
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(Color(.systemBackground))
        .overlay(
            Rectangle()
                .frame(height: 0.5)
                .foregroundColor(Color(.systemGray4)),
            alignment: .top
        )
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

public struct BreadcrumbNavigation: View {
    public let items: [BreadcrumbItem]
    public let onItemTap: ((BreadcrumbItem) -> Void)?
    
    public init(
        items: [BreadcrumbItem],
        onItemTap: ((BreadcrumbItem) -> Void)? = nil
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
                            onItemTap?(item)
                        }) {
                            Text(item.title)
                                .font(.caption)
                                .foregroundColor(index == items.count - 1 ? .primary : .secondary)
                        }
                        
                        if index < items.count - 1 {
                            Image(systemName: "chevron.right")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
        }
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

public struct StepIndicator: View {
    public let currentStep: Int
    public let totalSteps: Int
    public let stepTitles: [String]
    
    public init(
        currentStep: Int,
        totalSteps: Int,
        stepTitles: [String]
    ) {
        self.currentStep = currentStep
        self.totalSteps = totalSteps
        self.stepTitles = stepTitles
    }
    
    public var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 0) {
                ForEach(0..<totalSteps, id: \.self) { index in
                    HStack(spacing: 0) {
                        Circle()
                            .fill(index < currentStep ? Color.blue : Color.gray)
                            .frame(width: 24, height: 24)
                            .overlay(
                                Text("\(index + 1)")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                            )
                        
                        if index < totalSteps - 1 {
                            Rectangle()
                                .fill(index < currentStep - 1 ? Color.blue : Color.gray)
                                .frame(height: 2)
                                .frame(maxWidth: .infinity)
                        }
                    }
                }
            }
            
            if !stepTitles.isEmpty {
                HStack {
                    ForEach(Array(stepTitles.enumerated()), id: \.offset) { index, title in
                        Text(title)
                            .font(.caption)
                            .foregroundColor(index < currentStep ? .blue : .secondary)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
        }
        .padding(.horizontal, 16)
    }
} 