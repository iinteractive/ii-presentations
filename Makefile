render: libs
	@wallflower -a app.psgi -d . -F urls --no-follow
preview: libs
	@plackup
libs:
	@cpanm App::Wallflower JSON::XS Plack::Middleware::Xslate Plack::Middleware::Static
