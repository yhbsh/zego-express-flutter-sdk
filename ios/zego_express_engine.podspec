require 'yaml'
require 'ostruct'
pubspec = OpenStruct.new YAML.load_file('../pubspec.yaml')

Pod::Spec.new do |s|
  s.name             = pubspec.name
  s.version          = pubspec.version
  s.summary          = pubspec.summary
  s.description      = pubspec.description
  s.homepage         = pubspec.homepage
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'ZEGO' => 'developer@zego.im' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.static_framework = true
  s.dependency 'Flutter'
  s.vendored_frameworks = 'libs/ZegoExpressEngine.xcframework'
  s.platform = :ios, '9.0'

  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }

  s.prepare_command = 'sh download.sh'
  s.script_phases = [
    { :name => 'Download native dependency',
      :script => 'sh ${PODS_TARGET_SRCROOT}/download.sh',
      :execution_position => :before_compile,
      :input_files => [ '${PODS_TARGET_SRCROOT}/DEPS' ],
      :output_files => [ '${PODS_TARGET_SRCROOT}/libs/*' ]
    }
  ]
end
