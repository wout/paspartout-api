# paspartout-api

An abstraction layer for the Paspartout API.

## Installation

Use RubyGems to install paspartout-api to get started:

		$ gem install paspartout-api

## Initialization

Use the API key of the Paspartout site, found in the settings panel, to establish the connection:

		@paspartout = Paspartout.new('ppt-247400')

## Pulling data

Get the site data:

		@site = @paspartout.site

Get pages in menu:
		
		@pages = @paspartout.pages

Get a particular page including children or blocks:

		@page = @paspartout.page(123)

This also works with the permaname:

		@page = @paspartout.page('page-permaname')

There are some comvenience methods:
		
		@portfolio = @paspartout.portfolio
		@blog = @paspartout.blog
		@shop = @paspartout.shop
		@about = @paspartout.about


## Contributing to paspartout-api
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2014 Wout Fierens. See LICENSE.txt for further details.