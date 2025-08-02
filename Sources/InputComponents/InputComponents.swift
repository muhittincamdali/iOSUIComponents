import SwiftUI

// MARK: - Input Components
public struct CustomTextField: View {
    @Binding public var text: String
    public let placeholder: String
    public let icon: String?
    public let validation: TextFieldValidation
    public let isSecure: Bool
    
    public init(
        text: Binding<String>,
        placeholder: String,
        icon: String? = nil,
        validation: TextFieldValidation = .none,
        isSecure: Bool = false
    ) {
        self._text = text
        self.placeholder = placeholder
        self.icon = icon
        self.validation = validation
        self.isSecure = isSecure
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                if let icon = icon {
                    Image(systemName: icon)
                        .foregroundColor(.secondary)
                        .frame(width: 20)
                }
                
                if isSecure {
                    SecureField(placeholder, text: $text)
                } else {
                    TextField(placeholder, text: $text)
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
            
            if !text.isEmpty {
                validationMessage
            }
        }
    }
    
    @ViewBuilder
    private var validationMessage: some View {
        switch validation {
        case .email:
            if !text.isValidEmail {
                Text("Please enter a valid email address")
                    .font(.caption)
                    .foregroundColor(.red)
            }
        case .password:
            if text.count < 8 {
                Text("Password must be at least 8 characters")
                    .font(.caption)
                    .foregroundColor(.red)
            }
        default:
            EmptyView()
        }
    }
}

public struct CustomToggle: View {
    @Binding public var isOn: Bool
    public let title: String
    public let subtitle: String?
    public let icon: String?
    
    public init(
        isOn: Binding<Bool>,
        title: String,
        subtitle: String? = nil,
        icon: String? = nil
    ) {
        self._isOn = isOn
        self.title = title
        self.subtitle = subtitle
        self.icon = icon
    }
    
    public var body: some View {
        HStack {
            if let icon = icon {
                Image(systemName: icon)
                    .foregroundColor(.primary)
                    .frame(width: 24)
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.body)
                    .fontWeight(.medium)
                
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            Toggle("", isOn: $isOn)
                .labelsHidden()
        }
        .padding()
        .background(Color(.systemBackground))
    }
}

public struct CustomSlider: View {
    @Binding public var value: Double
    public let range: ClosedRange<Double>
    public let step: Double
    public let title: String?
    
    public init(
        value: Binding<Double>,
        range: ClosedRange<Double>,
        step: Double = 1.0,
        title: String? = nil
    ) {
        self._value = value
        self.range = range
        self.step = step
        self.title = title
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let title = title {
                Text(title)
                    .font(.body)
                    .fontWeight(.medium)
            }
            
            HStack {
                Slider(value: $value, in: range, step: step)
                
                Text(String(format: "%.1f", value))
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .frame(width: 40)
            }
        }
        .padding()
        .background(Color(.systemBackground))
    }
}

public struct SearchBar: View {
    @Binding public var text: String
    public let placeholder: String
    public let onSearch: (() -> Void)?
    
    public init(
        text: Binding<String>,
        placeholder: String = "Search...",
        onSearch: (() -> Void)? = nil
    ) {
        self._text = text
        self.placeholder = placeholder
        self.onSearch = onSearch
    }
    
    public var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
            
            TextField(placeholder, text: $text)
                .textFieldStyle(PlainTextFieldStyle())
            
            if !text.isEmpty {
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

public struct CustomPicker<SelectionValue: Hashable>: View {
    @Binding public var selection: SelectionValue
    public let title: String
    public let options: [(SelectionValue, String)]
    
    public init(
        selection: Binding<SelectionValue>,
        title: String,
        options: [(SelectionValue, String)]
    ) {
        self._selection = selection
        self.title = title
        self.options = options
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.body)
                .fontWeight(.medium)
            
            Picker(title, selection: $selection) {
                ForEach(options, id: \.0) { option in
                    Text(option.1).tag(option.0)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
        }
    }
}

// MARK: - Text Field Validation
public enum TextFieldValidation {
    case none
    case email
    case password
    case phone
    case custom
}

// MARK: - String Extensions
public extension String {
    var isValidEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
    
    var isValidPhoneNumber: Bool {
        let phoneRegex = "^[0-9]{10,15}$"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phonePredicate.evaluate(with: self)
    }
} 