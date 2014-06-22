platform :ios, '7.0'
pod 'FlatUIKit'
pod 'Canvas'
pod 'MagicalRecord'
pod 'SWTableViewCell'
pod 'BlocksKit'

post_install do | installer |
  require 'fileutils'
    FileUtils.cp_r('Pods/Pods-Acknowledgements.plist', 'LFGoods/Settings.bundle/Acknowledgements.plist', :remove_destination => true)
end
