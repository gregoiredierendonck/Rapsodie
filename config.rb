compass_config do |config|
	config.output_style = :compact
end

require 'slim'
activate :livereload
# Desactivate to deploy on github pages
# activate :directory_indexes

set :js_dir, 'assets/javascripts'
set :css_dir, 'assets/stylesheets'
set :images_dir, 'assets/images'
set :layouts_dir, 'layouts'
# set :partials_dir, 'views/global'

# Add bower's directory to sprockets asset path
after_configuration do
	@bower_config = JSON.parse(IO.read("#{root}/.bowerrc"))
	sprockets.append_path File.join "#{root}", @bower_config["directory"]
end

['legroupe', 'concerts', 'albums', 'ateliers', 'presse', 'contact'].each do |name|
	proxy "/pages/#{name}.html", "#{name}.html", layout: nil
end

# Build-specific configuration
configure :build do
	activate :favicon_maker do |f|
		f.template_dir  = File.join(root, 'source')
		f.output_dir    = File.join(root, 'build')
		f.icons = {
			'favicon_base.png' => [
				{ icon: 'chrome-touch-icon-192x192.png' },
				{ icon: 'apple-touch-icon.png', size: '152x152' },
				{ icon: 'ms-touch-icon-144x144-precomposed.png', size: '144x144' },
				{ icon: 'favicon-196x196.png' },
				{ icon: 'favicon-160x160.png' },
				{ icon: 'favicon-96x96.png' },
				{ icon: 'favicon-32x32.png' },
				{ icon: 'favicon-16x16.png' },
				{ icon: 'favicon.ico', size: '64x64,32x32,24x24,16x16' },
			]
		}
	end
	activate :minify_css
	activate :minify_javascript
	activate :asset_hash
	activate :relative_assets
	set :relative_links, true
end
