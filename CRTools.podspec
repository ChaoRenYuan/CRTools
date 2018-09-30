

Pod::Spec.new do |s|
  s.name         = "CRTools"
  s.version      = "0.0.1"
  s.summary      = "维护超人在Swift开发中需要用到的工具"
  s.description  = <<-DESC
             Hello CR!
                   DESC
  s.homepage     = "https://www.crios.cn"
  s.license      = "MIT"
  s.platform     = :ios, "9.0"
  s.ios.deployment_target = "9.0"
  s.source = { :path => '.' }
  s.source_files = "CRTools", "CRTools/**/*.{h,m,swift}"
  s.resources = "ThreeRingControl/*.mp3"
  s.resources = "CRTools/**/*.mp3"
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4' }

end
