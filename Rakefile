desc "Build, Deploy to gh-pages and cleanup"
task :deploy do
  puts "Building..."
  system "bundle exec middleman build"
  puts "Deploying..."
  system "bundle exec middleman deploy"
  puts "Cleaning up..."
  rm_rf "./build"
  puts "Done"
end

task default: %w[test]

task :test do
  puts "\nBuilding project"
  try "middleman build"
end

task :deploy do
  puts "\nCopying GitHub-specific files"
  try "cp -rv ./github/* ./build/"

  puts "\nDeploying to GitHub"
  try "middleman deploy"
end

namespace :travis do
  task :script do
    Rake::Task["test"].invoke
  end

  task :after_success do
    puts "\nRunning Travis Deployment"
    puts "\nSetting up Git access"
    try "echo ${GH_TOKEN} > ./.git/credentials"
    try "git config --global user.name ${GHUSER}"
    try "git config --global user.email ${GHUSERMAIL}"
    try "git remote set-url origin https://${GH_TOKEN}:x-oauth-basic@github.com/rossconf/rossconf.io.git"

    Rake::Task["deploy"].invoke
  end
end

## Helper so we fail as soon as a command fails.
def try(command)
  system command
  if $? != 0 then
    raise "Command: `#{command}` exited with code #{$?.exitstatus}"
  end
end
