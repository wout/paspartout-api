require 'httparty'
require 'hashie'

class Paspartout
  
  def initialize api_key
    @api_key = api_key
    @loaded  = {}
  end

  def errors
    @errors
  end

  def loaded?
    @errors.empty?
  end

  def site
    return @loaded[:site] if @loaded[:site]

    if result = get
      @loaded[:site] = result
    end
  end

  def pages
    return @loaded[:pages] if @loaded[:pages]

    if result = get('/pages')
      @loaded[:pages] = result
    end
  end

  def page id
    return @loaded[:"page_#{ id }"] if @loaded[:"page_#{ id }"]

    if result = get("/pages/#{ id }")
      @loaded[:"page_#{ id }"] = result
    end
  end

  %w[ portfolio about blog shop ].each do |m|
    define_method m do
      return @loaded[:"#{ m }"] if @loaded[:"#{ m }"]

      pages.each { |p| @loaded[:"#{ m }"] = page(p.id) if p.type == m }

      @loaded[:"#{ m }"]
    end
  end
  
private
  
  def get path = ''
    @errors = []
    
    request = HTTParty.get("http://api.paspartout.com/public/v2/#{ @api_key }#{ path }.json")
    result  = Hashie::Mash.new({ body: JSON.parse(request.body) })
    
    if result.error
      @errors.push(result.error)

      false
    else
      result.body
    end
  end

end