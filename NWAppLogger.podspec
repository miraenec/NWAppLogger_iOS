Pod::Spec.new do |s|
  s.name             = 'NWAppLogger'
  s.version          = '0.1.6'
  s.summary          = 'NWAppLogger'
  s.description      = 'NWAppLogger is available through CocoaPods. To install it, simply add the following line to your Podfile'
  s.homepage         = 'https://github.com/hlkim/NWAppLogger_iOS'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'hlkim' => 'hlkim@nextweb.co.kr' }
  s.source           = { :git => 'https://github.com/hlkim/NWAppLogger_iOS.git', :branch => 'main', :tag => s.version.to_s }
  s.platform = :ios, '12.0'
  s.ios.deployment_target = '12.0'
  s.source_files = 'NWAppLogger/Classes/**/*'
  s.swift_version = "5.0"
  s.dependency 'Alamofire', '~> 5.4.4'
end
