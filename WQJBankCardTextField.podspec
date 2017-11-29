#
#  Be sure to run `pod spec lint WQJBankCardTextField.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "WQJBankCardTextField"
  s.version      = "0.0.1"
  s.summary      = "iOS银行卡输入框"
  s.description  = "几行代码轻松搞定，银行卡输入框"
  s.homepage     = "https://github.com/mnz12138/WQJBankCardTextField.git"
  s.license      = "MIT"
  s.author             = { "王全金" => "wqjruanjian@126.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/mnz12138/WQJBankCardTextField.git", :tag => "v#{s.version}" }
  s.source_files  = "WQJBankCardTextField", "WQJBankCardTextField/*.{h,m}"

end
