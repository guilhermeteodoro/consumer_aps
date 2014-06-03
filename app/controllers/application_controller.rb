class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :get_xml

  def index
    @doc.xpath('//posts/post').map do |i|
      post = Post.new

      post.title = i.at('title').to_str
      post.body = i.at('body').to_str
      post.author = i.at('author').to_str

      @posts << post
    end

  end

  private
  def get_xml
    require 'nokogiri'
    require 'open-uri'

    url = "http://localhost:8000/external_posts.xml"
    @doc = Nokogiri::XML(open(url))

    @posts = []
  end

end
