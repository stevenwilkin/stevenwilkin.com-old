desc "Run specs"
task :spec do
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new do |t|
	t.rspec_opts = ["-c", "-f documentation", "-r ./spec/spec_helper.rb"]
	t.pattern = 'spec/**/*_spec.rb'
  end
end
