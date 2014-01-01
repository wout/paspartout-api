require 'helper'

describe Paspartout do

	before do
	  @paspartout = Paspartout.new('ppt-247400')
	end

	describe '#errors' do

		it 'fails for non existant sites' do
			@page = @paspartout.page(0)

			@page.error.code.should be(404)
		end

	end

  describe '#site' do

  	it 'loads the site' do
  	  @paspartout.site.subdomain.should eq('gmc')
  	end

  end

  describe '#pages' do

  	it 'loads pages' do
  	  @paspartout.pages.size.should be > 0
  	end

  end

  describe '#page' do

  	it 'loads a given page by id' do
  		@paspartout.page(3077).type.should eq 'portfolio'
  	end

  	it 'loads a given page by permaname' do
  		@paspartout.page('portfolio').id.should be 3077
  	end

  end

  describe '#portfolio' do

  	it 'loads the portfolio page' do
  		@paspartout.portfolio.id.should be 3077
  	end

  	it 'includes children' do
  		@paspartout.portfolio.children.any?.should be true
  	end

  end

  describe '#blog' do

  	it 'loads the blog page' do
  		@paspartout.blog.id.should be 3079
  	end

  	it 'includes children' do
  		@paspartout.blog.children.any?.should be true
  	end

  end

  describe '#about' do

  	it 'loads the about page' do
  		@paspartout.about.id.should be 3078
  	end

  end

  describe '#shop' do

  	it 'loads the shop page' do
  		@paspartout.shop.id.should be 6026
  	end

  	it 'includes children' do
  		@paspartout.shop.children.any?.should be true
  	end

  end

end
