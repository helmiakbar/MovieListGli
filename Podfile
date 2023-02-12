# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

use_frameworks!
use_modular_headers!
inhibit_all_warnings!

def user_interface
  pod 'Toast-Swift', '~> 5.0.0'
  pod 'NVActivityIndicatorView', '~> 4.8.0'
  pod 'AnyCodable-FlightSchool', '~> 0.2.2'
  pod 'SkeletonView', :git => 'https://github.com/Juanpe/SkeletonView', :tag => '1.8.2'
  pod 'FloatingPanel', '~> 2.5.5'
  pod 'FSCalendar', '~> 2.8.2'
  pod 'IQKeyboardManagerSwift', '~> 6.5.6'
end

def utilities
  pod 'RxSwift', '~> 5.1.3'
  pod 'RxCocoa', '~> 5.1.3'
  pod 'RxBlocking', '~> 5.1.3'
  pod 'SwiftLint', '0.43.1'
  pod 'Swinject', '2.8.0'
  pod 'netfox' #Network Debuging
  pod 'Kingfisher', '~> 6.3.1'
  pod 'Alamofire', '~> 4.9.1'
end


def unit_test_dependencies
  pod 'Swinject', '2.8.0'
  pod 'Alamofire', '~> 4.9.1'
  pod 'Cuckoo', '1.7.1'
  pod 'RxSwift', '~> 5.1.3'
  pod 'RxCocoa', '~> 5.1.3'
  pod 'RxBlocking', '~> 5.1.3'
  pod 'AnyCodable-FlightSchool', '~> 0.2.2'
  pod 'SQLogger', :git => 'https://bitbucket.org/sehatQ/sqlogger', :tag => '0.1.1'
end

target 'TestGLI' do

  # Pods for SehatQ Merchant Center
  user_interface
  utilities

  target 'TestGLIUITests' do
    # Pods for testing
  end

end

target 'TestGLITests' do
  inherit! :search_paths
  unit_test_dependencies
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings["ONLY_ACTIVE_ARCHS"] = "YES"
      config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
   end
    if target.name == 'RxCocoa'
      puts "Patching RxCocoa references to UIWebView"
      root = File.join(File.dirname(installer.pods_project.path), 'RxCocoa')
      `chflags -R nouchg #{root}`
      `grep --include=UIWebView+Rx.swift -rl '#{root}' -e "os\(iOS\)" | xargs sed -i '' 's/os(iOS)/false/'`
      `grep --include=RxWebViewDelegateProxy.swift -rl '#{root}' -e "os\(iOS\)" | xargs sed -i '' 's/os(iOS)/false/'`
      `grep --include=Deprecated.swift -rl '#{root}' -e "extension UIWebView" | xargs sed -i '' '/extension UIWebView/{N;N;N;N;N;d;}'`
    end
  end
end
