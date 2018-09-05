Pod::Spec.new do |s|


  s.name         = "YXZStretchHeaderView"
  s.version      = "1.0.0"
  s.summary      = "头部拉伸"
  s.description  = <<-DESC

        头部拉伸实现
                   DESC
  s.homepage     = "https://github.com/YXZCoder/stretchHeaderView"
  s.license      = { :type => "MIT", :file => "LICENSE" }


  s.author       = { "YXZCoder" => "120246443@qq.com"}
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/YXZCoder/stretchHeaderView.git", :tag => s.version }
  s.source_files = "stretchHeaderView/Code/*.{h,m}"
  s.requires_arc = true



end
