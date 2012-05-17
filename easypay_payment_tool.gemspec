# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "easypay_payment_tool/version"

Gem::Specification.new do |s|
  s.name        = "easypay_payment_tool"
  s.version     = EasypayPaymentTool::VERSION
  s.authors     = ["joehwang"]
  s.email       = ["joehwang.com@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{This library access payment api in www.neweb.com.tw}
  s.description = %q{You must sign up account in newweb.com.tw and get authorization code,The libary now support ibon/Famiport/life-ET/okgo and visualaccount.}

  s.rubyforge_project = "easypay_payment_tool"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
