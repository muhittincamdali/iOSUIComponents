Pod::Spec.new do |s|
  s.name             = 'iOSUIComponents'
  s.version          = '1.0.0'
  s.summary          = 'Reusable UI components for SwiftUI and UIKit.'
  s.description      = <<-DESC
    iOSUIComponents provides reusable UI components for SwiftUI and UIKit.
    Features include custom buttons, cards, lists, forms, navigation components,
    loading indicators, and accessibility-ready UI elements.
  DESC

  s.homepage         = 'https://github.com/muhittincamdali/iOSUIComponents'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Muhittin Camdali' => 'contact@muhittincamdali.com' }
  s.source           = { :git => 'https://github.com/muhittincamdali/iOSUIComponents.git', :tag => s.version.to_s }

  s.ios.deployment_target = '15.0'
  s.osx.deployment_target = '12.0'

  s.swift_versions = ['5.9', '5.10', '6.0']
  s.source_files = 'Sources/**/*.swift'
  s.frameworks = 'Foundation', 'SwiftUI', 'UIKit'
end
