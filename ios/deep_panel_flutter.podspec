#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint deep_panel_flutter.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'deep_panel_flutter'
  s.version          = '0.0.1'
  s.summary          = 'Flutter integration with DeepPanel!!'
  s.description      = <<-DESC
Flutter integration with DeepPanel!!
                       DESC
  s.homepage         = 'https://sergiocasero.es'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.static_framework = true
  s.dependency 'Flutter'
  s.dependency 'DeepPanel'
  s.platform = :ios, '13.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'

end
