Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '12.0'
s.name = "CCBotManager"
s.summary = "CCBotManager"
s.requires_arc = true

# 2
s.version = "0.0.1"

# 3
s.license = { :type => "MIT", :file => "LICENSE" }

# 4 - Replace with your name and e-mail address
s.author = { "KevinLo" => "kevin.lo@udngroup.com" }

# 5 - Replace this URL with your own GitHub page's URL (from the address bar)
s.homepage = "https://github.com/IssueLo/ios_lib_UDNCCBotManager.git"

# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/IssueLo/ios_lib_UDNCCBotManager.git",
             :tag => "#{s.version}" }

# 7
s.framework = "UIKit", "WebKit"

# 8
s.source_files = "ios_lib_UDNCCBotManager/**/*.{swift}"

# 9
# s.resources = "CCBotManager/**/*.{xcassets}"
s.resource_bundles = { 'CCBotManager' => ['ios_lib_UDNCCBotManager/*.xcassets'] }

# 10
s.swift_version = "5.0"

end
