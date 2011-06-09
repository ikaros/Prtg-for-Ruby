#!/usr/bin/env rake
require 'rake'
require 'rubygems'
require 'rspec'
require 'spec/rake/spectask'
require 'rake/packagetask'
require 'rubygems/package_task'

desc "Run all examples"
Spec::Rake::SpecTask.new('examples') do |t|
  t.spec_files = FileList['examples/**/*.rb']
end
