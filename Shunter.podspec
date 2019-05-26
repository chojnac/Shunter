
Pod::Spec.new do |s|
  s.name             = 'Shunter'
  s.version          = '0.1.0'
  s.summary          = 'Feature flag manager for your application'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/chojnac/Shunter'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Wojciech Chojnacki' => 'chojnac@gmail.com' }
  s.source           = { :git => 'https://github.com/chojnac/Shunter.git', :tag => s.version.to_s }
  s.swift_version    = '5.0'
  
  s.ios.deployment_target = '11.0'
  s.osx.deployment_target = '10.12'

  s.source_files = ['Shunter/**/*.swift']
end
