# encoding: UTF-8
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)
require 'configuratrilla/version'

Gem::Specification.new do |s|
  s.name        = 'configuratrilla'
  s.version     = Configuratrilla::VERSION
  s.date        = '2013-03-17'
  s.summary     = "New elastic way to create configuration"
  s.description = "Allows to set configuration files with ruby in free and easy style."
  s.authors     = ["Anton Versal"]
  s.email       = 'ant.ver@gmail.com'
  s.files       = ["lib/configuratrilla/config.rb", "lib/configuratrilla/nil.rb", "lib/configuratrilla/version.rb",
                   "lib/configuratrilla.rb", "README.md"]
  s.homepage    = 'http://github.com/antonversal/configuratrilla'
end