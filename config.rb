compass_config do |config|
	config.output_style = :compact
end

require 'slim'
require 'builder'
activate :livereload

set :js_dir, 'assets/javascripts'
set :css_dir, 'assets/stylesheets'
set :images_dir, 'assets/images'
set :layouts_dir, 'layouts'

# Remove the layout on specific pages
page "/sitemap.xml", :layout => false
page ".htaccess.apache", :layout => false

# Add bower's directory to sprockets asset path
after_configuration do
	@bower_config = JSON.parse(IO.read("#{root}/.bowerrc"))
	sprockets.append_path File.join "#{root}", @bower_config["directory"]
end

# Redirections on "pages" folder
['index', 'legroupe', 'concerts', 'albums', 'ateliers', 'presse', 'contact', '404'].each do |name|
	proxy "/pages/#{name}.html", "#{name}.html", layout: nil
end

# Add "is-active" class to nav li of current page
helpers do
  def active_page_class(page)
  	puts current_page.url
    current_page.url == page ? 'is-active' : ''
  end
end

# Build-specific configuration
configure :build do
	activate :minify_css
	activate :minify_javascript
	activate :imageoptim
	activate :asset_hash
	activate :relative_assets
	activate :cache_buster
	set :relative_links, true
	ignore 'imageoptim.manifest.yml'
end

# rename file after build
# View : http://coderwall.com/p/daflfq/generate-htaccess-in-middleman
after_build do
  File.rename 'build/.htaccess.apache', 'build/.htaccess'
end
