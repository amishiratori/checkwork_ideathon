require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require 'json'
require 'net/http'
require 'open-uri'
require 'sinatra/json'
require './models'
require 'sinatra/base'



get '/' do
  @like = Like.all
  erb :top_page
end

post '/search' do
  search_rest = params[:search]
  uri = URI('http://api.gnavi.co.jp/RestSearchAPI/20150630/')
  uri.query = URI.encode_www_form({
    keyid: ENV['GNAVI_KEY'],
    format: 'json',
    freeword: search_rest,
    hit_per_page: 50,
  });
  res = Net::HTTP.get_response(uri)
  returned_json = JSON.parse(res.body)
  @response_stores = returned_json['rest']
  logger.info returned_json
  erb :list
end

post '/new' do
  rest = params[:rest]
  Like.create(
      name: rest["name"],
      img: rest["img"],
      url: rest["url"],
  )
  redirect '/'
end