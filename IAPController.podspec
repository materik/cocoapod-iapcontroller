Pod::Spec.new do |s|
  s.name           = "IAPController"
  s.version        = "0.2.0"
  s.summary        = "In App Purchase controller for Swift"
  s.homepage       = "https://github.com/materik/IAPController.git"
  s.license        = { :type => "MIT", :file => "LICENSE.md" }
  s.author         = { "Mattias Eriksson" => "thematerik@gmail.com" }
  s.platform       = :ios, 8.0
  s.source         = { :git => "https://github.com/materik/IAPController.git", :tag => "0.1.0" }
  s.source_files   = "*.swift"
  s.framework      = "StoreKit"
end
