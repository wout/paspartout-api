require 'htmlentities'
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

    if ''.respond_to?(:html_safe)
      result = make_html_safe(result)
    end
    
    if result.error
      @errors.push(result.error)

      false
    else
      result.body
    end
  end

  def make_html_safe value
    case value.class.to_s
    when 'String'
      value = HTMLEntities.new.decode(value).html_safe
    when 'Array'
      value.each.with_index do |v, i|
        value[i] = make_html_safe(v)
      end
    when 'Hash'
    when 'Hashie::Mash'
      value.each_pair do |k, v|
        value[k] = make_html_safe(v)
      end
    end

    value
  end

end