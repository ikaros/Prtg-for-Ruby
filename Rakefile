require 'rubygems'
require 'rspec/core/rake_task'
require 'rubygems/package_task'
require 'rdoc/task'

RSpec::Core::RakeTask.new(:spec)

desc "build gem"
task :build do
  sh %{gem build prtg.gemspec}
end

desc "Push the gem online"
task :publish => :build do
  sh %{gem push prtg*.gem}
  sh %{rm prtg*.gem}
end

desc "install gem"
task :install => :build do
  sh %{gem install prtg*.gem}
  sh %{rm prtg*.gem}
end
