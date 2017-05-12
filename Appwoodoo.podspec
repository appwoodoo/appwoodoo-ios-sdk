Pod::Spec.new do |s|
  s.name         = "Appwoodoo"
  s.version      = "3.2.2"
  s.summary      = "The simplest way to add an admin panel to existing or new apps, to edit their content."
  s.description  = <<-DESC
                   The simplest way to add an admin panel to existing or new apps, to edit their content.
                   DESC
  s.homepage     = "http://www.appwoodoo.com/"
  s.license      = { :type => "MIT", :file => "README.md" }
  s.author       = { "Tamas Dancsi" => "tomi@appwoodoo.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/appwoodoo/appwoodoo-ios-sdk.git", :tag => "3.2.2" }
  s.source_files = "SDK/*.{h,m}"
  s.resources    = ['SDK/*.storyboard', 'SDK/*.xib']
  s.public_header_files = "SDK/*.h"
  s.requires_arc = true
end
