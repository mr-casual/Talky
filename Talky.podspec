Pod::Spec.new do |s|

s.name         = "Talky"
s.version      = "0.1.1"
s.summary      = "A lightweight and swift-based HTTP client with native support for Encodable and Decodable."
s.description  = "A lightweight and swift-based HTTP client with native support for Encodable and Decodable. TODO: write more about it"

s.homepage     = "https://github.com/mr-casual"
s.license      = { :type => "MIT", :file => "LICENSE" }

s.author    = "Martin Klöpfel"
s.platform     = :ios, "10.3"
s.swift_version = '4.0'

#  When using multiple platforms
# s.ios.deployment_target = "5.0"
# s.osx.deployment_target = "10.7"
# s.watchos.deployment_target = "2.0"
# s.tvos.deployment_target = "9.0"


s.source       = { :git => "https://github.com/mr-casual/Talky.git", :tag => "#{s.version}" }
s.source_files  = "Sources", "Sources/**/*.swift"
s.public_header_files = "Sources/**/*.h"

# s.dependency "JSONKit", "~> 1.4"

end
