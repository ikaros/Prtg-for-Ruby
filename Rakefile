require 'rubygems'
require 'rspec/core/rake_task'
require 'rubygems/package_task'
require 'rdoc/task'

RSpec::Core::RakeTask.new(:spec)

desc "install gem"
task "install" do
  sh %{gem build prtg.gemspec}
  sh %{gem install prtg*.gem}
  sh %{rm prtg*.gem}
end
