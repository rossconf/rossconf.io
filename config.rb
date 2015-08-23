activate :deploy do |deploy|
  deploy.method = :git
  committer_app = "#{Middleman::Deploy::PACKAGE} v#{Middleman::Deploy::VERSION}"
  commit_message = "Deployed using #{committer_app}"

  if ENV["TRAVIS_BUILD_NUMBER"] then
    commit_message += " (Travis Build \##{ENV["TRAVIS_BUILD_NUMBER"]})"
  end

  deploy.commit_message = commit_message
end

set :site_name, "ROSSConf"
set :analytics_code, "UA-60869001-1"

###
# Blog
###
activate :blog do |blog|
  blog.prefix  = "blog"
end
###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end


activate :directory_indexes

data.events.each do |city, event|
  proxy "event/#{city.downcase}/index.html", "/event.html", :locals => { :event => event }
end

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

# Methods defined in the helpers block are available in templates
helpers do
  def md2(source)
    Tilt::KramdownTemplate.new { source }.render
  end
end


set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'
sprockets.append_path File.join root, 'bower_components'

set :images_dir, 'images'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Enable cache buster
  activate :asset_hash

  # Generate favicons
  #
  # activate :favicon_maker, icons: {
  #   "_favicon_template.png" => [
  #     { icon: "apple-touch-icon-152x152-precomposed.png" },
  #     { icon: "apple-touch-icon-144x144-precomposed.png" },
  #     { icon: "apple-touch-icon-114x114-precomposed.png" },
  #     { icon: "apple-touch-icon-72x72-precomposed.png" },
  #     { icon: "apple-touch-icon-precomposed.png", size: "57x57" },
  #     { icon: "favicon.png", size: "16x16" },
  #     { icon: "favicon.ico", size: "64x64,32x32,24x24,16x16" },
  #   ]
  # }

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end
