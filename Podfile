source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.3'

def common_pods
	pod 'ActionSheetPicker-3.0'
end

target 'HappyTrack' do
  common_pods
end


inhibit_all_warnings!
use_frameworks!

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['ENABLE_BITCODE'] = 'NO'
    end
  end
end