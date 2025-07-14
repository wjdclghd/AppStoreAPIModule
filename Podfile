# Uncomment the next line to define a global platform for your project
platform :ios, '16.0'


target 'AppStoreAPIModule' do
  use_frameworks!

  #pod 'CoreModule', :path => '../CoreModule'

  target 'AppStoreAPIModuleTests' do
    inherit! :search_paths

    # Pods for testing
  end

end


post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '16.0'
      
      existing_flags = config.build_settings['OTHER_SWIFT_FLAGS'] || '$(inherited)'
      unless existing_flags.include?('-no-verify-emitted-module-interface') 
        config.build_settings['OTHER_SWIFT_FLAGS'] = "#{existing_flags} -no-verify-emitted-module-interface"
      end
    end
  end
end