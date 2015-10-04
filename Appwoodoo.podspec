Pod::Spec.new do |s|
  s.name         = "Appwoodoo"
  s.version      = "1.1.4"
  s.summary      = "Configure iOS apps remotely without resubmitting to the Apple Store"
  s.description  = <<-DESC
                   Configure iOS apps remotely without resubmitting to the Apple Store: enable extra features, send push notifications, conduct A/B tests or control any other behaviour from the air.
                   DESC
  s.homepage     = "http://www.appwoodoo.com/"
  s.license      = { :type => "MIT", :file => "README.md" }
  s.author       = { "Tamas Dancsi" => "tomi@appwoodoo.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/appwoodoo/appwoodoo-ios-sdk.git", :tag => "1.1.4" }
  s.source_files = "SDK/*.{h,m}"
  s.public_header_files = "SDK/*.h"
  s.requires_arc = true
end
