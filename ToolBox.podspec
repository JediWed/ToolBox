Pod::Spec.new do |s|
  s.name = 'ToolBox'
  s.version = '1.5'
  s.summary = 'Private Framework for Common Features'
  s.homepage = 'https://www.turcan.de'
  s.authors = { 'Ediz Turcan' => 'ediz.turcan@icloud.com' }
  s.source = { :git => 'https://github.com/JediWed/ToolBox.git' }

  s.ios.deployment_target = '11.0'
  s.source_files = 'ToolBox/**/*.swift'
end
