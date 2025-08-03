import SwiftUI

// MARK: - Input Components
public struct CustomTextField: View {
    public let placeholder: String
    @Binding public var text: String
    public let validation: ValidationType?
    public let keyboardType: UIKeyboardType
    public let textContentType: UITextContentType?
    @State private var isEditing = false
    @State private var showPassword = false
    
    public init(
        placeholder: String,
        text: Binding<String>,
        validation: ValidationType? = nil,
        keyboardType: UIKeyboardType = .default,
        textContentType: UITextContentType? = nil
    ) {
        self.placeholder = placeholder
        self._text = text
        self.validation = validation
        self.keyboardType = keyboardType
        self.textContentType = textContentType
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                TextField(placeholder, text: $text)
                    .font(.system(size: 16, weight: .regular))
                    .keyboardType(keyboardType)
                    .textContentType(textContentType)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(isEditing ? Color.blue : Color.clear, lineWidth: 2)
                    )
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            isEditing = true
                        }
                    }
                    .onChange(of: text) { _ in
                        isEditing = false
                    }
                
                if validation == .password {
                    Button(action: {
                        showPassword.toggle()
                    }) {
                        Image(systemName: showPassword ? "eye.slash" : "eye")
                            .foregroundColor(.gray)
                    }
                    .padding(.trailing, 8)
                }
            }
            
            if let validation = validation, !text.isEmpty {
                ValidationMessage(type: validation, isValid: validate(text, type: validation))
                    .transition(.opacity.combined(with: .scale))
            }
        }
    }
    
    private func validate(_ text: String, type: ValidationType) -> Bool {
        switch type {
        case .email:
            let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
            return emailPredicate.evaluate(with: text)
        case .phone:
            let phoneRegex = "^[0-9]{10,}$"
            let phonePredicate = NSPredicate(format:"SELF MATCHES %@", phoneRegex)
            return phonePredicate.evaluate(with: text)
        case .password:
            return text.count >= 8 && text.rangeOfCharacter(from: .uppercaseLetters) != nil
        case .url:
            return URL(string: text) != nil
        case .custom(let validator):
            return validator(text)
        }
    }
}

public enum ValidationType {
    case email, phone, password, url
    case custom((String) -> Bool)
}

public struct ValidationMessage: View {
    public let type: ValidationType
    public let isValid: Bool
    
    public var body: some View {
        HStack(spacing: 4) {
            Image(systemName: isValid ? "checkmark.circle.fill" : "xmark.circle.fill")
                .foregroundColor(isValid ? .green : .red)
                .font(.system(size: 12))
            
            Text(message)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(isValid ? .green : .red)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background((isValid ? Color.green : Color.red).opacity(0.1))
        .cornerRadius(4)
    }
    
    private var message: String {
        switch type {
        case .email:
            return isValid ? "Valid email format" : "Invalid email format"
        case .phone:
            return isValid ? "Valid phone number" : "Invalid phone number"
        case .password:
            return isValid ? "Strong password" : "Password too weak"
        case .url:
            return isValid ? "Valid URL" : "Invalid URL format"
        case .custom:
            return isValid ? "Valid input" : "Invalid input"
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
                    .font(.system(size: 18))
                    .foregroundColor(.blue)
                    .frame(width: 24)
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.primary)
                
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            Toggle("", isOn: $isOn)
                .toggleStyle(SwitchToggleStyle(tint: .blue))
                .scaleEffect(0.9)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}

public struct CustomSlider: View {
    @Binding public var value: Double
    public let range: ClosedRange<Double>
    public let step: Double
    public let title: String?
    public let showValue: Bool
    
    public init(
        value: Binding<Double>,
        range: ClosedRange<Double>,
        step: Double = 1.0,
        title: String? = nil,
        showValue: Bool = true
    ) {
        self._value = value
        self.range = range
        self.step = step
        self.title = title
        self.showValue = showValue
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let title = title {
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.primary)
            }
            
            HStack {
                Text("\(Int(range.lowerBound))")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.secondary)
                
                Slider(value: $value, in: range, step: step)
                    .accentColor(.blue)
                
                Text("\(Int(range.upperBound))")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.secondary)
            }
            
            if showValue {
                Text("\(Int(value))")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.blue)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}

public struct CustomPicker<SelectionValue: Hashable>: View {
    @Binding public var selection: SelectionValue
    public let options: [SelectionValue]
    public let title: String?
    public let placeholder: String?
    
    public init(
        selection: Binding<SelectionValue>,
        options: [SelectionValue],
        title: String? = nil,
        placeholder: String? = nil
    ) {
        self._selection = selection
        self.options = options
        self.title = title
        self.placeholder = placeholder
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let title = title {
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.primary)
            }
            
            Menu {
                ForEach(options, id: \.self) { option in
                    Button(String(describing: option)) {
                        selection = option
                    }
                }
            } label: {
                HStack {
                    Text(selection == nil ? (placeholder ?? "Select option") : String(describing: selection))
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(selection == nil ? .secondary : .primary)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.down")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color(.systemGray6))
                .cornerRadius(8)
            }
        }
    }
}

public struct CustomDatePicker: View {
    @Binding public var date: Date
    public let title: String?
    public let mode: UIDatePicker.Mode
    public let range: ClosedRange<Date>?
    
    public init(
        date: Binding<Date>,
        title: String? = nil,
        mode: UIDatePicker.Mode = .date,
        range: ClosedRange<Date>? = nil
    ) {
        self._date = date
        self.title = title
        self.mode = mode
        self.range = range
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let title = title {
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.primary)
            }
            
            DatePicker(
                "",
                selection: $date,
                in: range ?? Date.distantPast...Date.distantFuture,
                displayedComponents: mode == .date ? .date : .hourAndMinute
            )
            .datePickerStyle(CompactDatePickerStyle())
            .labelsHidden()
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color(.systemGray6))
            .cornerRadius(8)
        }
    }
}

public struct CustomSearchBar: View {
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
                .font(.system(size: 16))
            
            TextField(placeholder, text: $text)
                .font(.system(size: 16, weight: .regular))
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
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}

public struct CustomStepper: View {
    @Binding public var value: Int
    public let range: ClosedRange<Int>
    public let title: String?
    public let step: Int
    
    public init(
        value: Binding<Int>,
        range: ClosedRange<Int>,
        title: String? = nil,
        step: Int = 1
    ) {
        self._value = value
        self.range = range
        self.title = title
        self.step = step
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let title = title {
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.primary)
            }
            
            HStack {
                Button(action: {
                    if value > range.lowerBound {
                        value -= step
                    }
                }) {
                    Image(systemName: "minus.circle.fill")
                        .font(.system(size: 24))
                        .foregroundColor(value > range.lowerBound ? .blue : .gray)
                }
                .disabled(value <= range.lowerBound)
                
                Spacer()
                
                Text("\(value)")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.primary)
                    .frame(minWidth: 40)
                
                Spacer()
                
                Button(action: {
                    if value < range.upperBound {
                        value += step
                    }
                }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 24))
                        .foregroundColor(value < range.upperBound ? .blue : .gray)
                }
                .disabled(value >= range.upperBound)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color(.systemGray6))
            .cornerRadius(8)
        }
    }
}

// MARK: - Input Extensions
public extension View {
    func customTextFieldStyle() -> some View {
        self
            .textFieldStyle(PlainTextFieldStyle())
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color(.systemGray6))
            .cornerRadius(8)
    }
    
    func customToggleStyle() -> some View {
        self
            .toggleStyle(SwitchToggleStyle(tint: .blue))
            .scaleEffect(0.9)
    }
} 
} 