get '/' do
  # Look in app/views/index.erb
  @all_url = Url.all
  erb :index
end

post '/' do
  url_obj = Url.create(params[:post])
  if url_obj.new_record?
    @error = url_obj.errors.messages[:full_link][0]
  end
  @all_url = Url.all
  erb :index
end

get '/:short_url' do
  short_url = params[:short_url]
  url_obj = Url.where(shorten_link: "http://localhost:9393/#{short_url}")[0]
  full_url = url_obj.full_link
  url_obj.add_count
  redirect full_url
end

