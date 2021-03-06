Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '9.0'
s.name = "CCBotManager"
s.module_name = 'CCBotManager'
s.summary = "ChatBot Module for udnNews"
s.requires_arc = true

# 2
s.version = "0.3.1"

# 3
# s.license = { :type => "MIT", :file => "LICENSE" }

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
s.source_files = "ios_lib_UDNCCBotManager/*.swift"

    s.subspec 'CCBot' do |c|
        c.source_files = "ios_lib_UDNCCBotManager/CCBot/*.swift"
    end
    
    s.subspec 'Manager' do |m|
        m.source_files = "ios_lib_UDNCCBotManager/Manager/*.swift"
    end

    s.subspec 'News' do |n|
        n.source_files = "ios_lib_UDNCCBotManager/News/*.swift"
    end

    s.subspec 'Extension' do |e|
        e.source_files = "ios_lib_UDNCCBotManager/Extension/*.swift"
    end

# s.source_files = "ios_lib_UDNCCBotManager/*.{swift}","ios_lib_UDNCCBotManager/Extension"

# 9
# s.resources = "CCBotManager/**/*.{xcassets}"
s.resource_bundles = { 'CCBotManager' => ['ios_lib_UDNCCBotManager/*.xcassets'] }

# 10
s.swift_version = "5.0"

end
