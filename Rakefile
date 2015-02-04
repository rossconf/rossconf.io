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
