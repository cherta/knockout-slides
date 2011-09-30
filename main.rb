require 'sinatra'
require 'json'
require 'erb'

configure(:development) do |c|  
  require "sinatra/reloader" #Sinatra::Reloader to reload the files in development
  c.also_reload "*.rb"
end

set :erb, :layout_engine => :erb, :layout => :"layout/application"

get '/' do
  erb :index
end

#The iframe is hackery, I couldn't add to ko.applyBindings without breaking everything else
get '/slides' do
  content_type :json

  presentations = []

  presentations << {:id =>'1', :title =>  'Qu&eacute; es Knockout', :html  =>  file_content('what_is_1.erb')}
  presentations << {:id =>'2', :title =>  'Qu&eacute; es Knockout', :html  =>  file_content('what_is_2.erb')}
  presentations << {:id =>'3', :title =>  'Plain Old jQuery Way', :html  =>  file_content('checkout_cart_jquery.erb')}
  presentations << {:id =>'4', :title =>  'Plain Old jQuery Way (Problems)', :html  =>  file_content('checkout_cart_jquery_failures.erb')}
  presentations << {:id =>'5', :title =>  'New Fancy Knockout Way', :html  =>  '<iframe src="/checkout_cart_knockout" style="height: 1220px;"></iframe>'}
  presentations << {:id =>'6', :title =>  'Pasando en Limpio (Observable)', :html  => '<iframe src="/resuming_observable" style="height: 800px;"></iframe>'}
  presentations << {:id =>'7', :title =>  'Pasando en Limpio (Dependent Observable I)', :html  =>  '<iframe src="/resuming_dependent_observable_1" style="height: 660px;"></iframe>'}
  presentations << {:id =>'8', :title =>  'Pasando en Limpio (Dependent Observable II)', :html  =>  '<iframe src="/resuming_dependent_observable_2" style="height: 980px;"></iframe>'}
  presentations << {:id =>'9', :title =>  'Pasando en Limpio (Observable Array)', :html  =>  '<iframe src="/resuming_observable_array" style="height: 970px;"></iframe>'}
  presentations << {:id =>'10', :title =>  'Trabajando con el Servidor', :html  =>  '<iframe src="/working_with_server_1" style="height: 1100px;"></iframe>'}
  presentations << {:id =>'11', :title =>  'Trabajando con el Servidor', :html  =>  '<iframe src="/working_with_server_2" style="height: 1330px;"></iframe>'}

  presentations.to_json
end

get '/checkout_cart_knockout' do
  erb :checkout_cart_knockout
end

get '/resuming_observable' do
  erb :resuming_observable
end

get '/resuming_observable_array' do
  erb :resuming_observable_array
end

get '/resuming_dependent_observable_1' do
  erb :resuming_dependent_observable_1
end

get '/resuming_dependent_observable_2' do
  erb :resuming_dependent_observable_2
end

get '/working_with_server_1' do
  erb :working_with_server_1
end

get '/tasks' do
  content_type :json
  [{:title => 'Tarea desde el server', :done => false}, {:title => 'Otra desde el server', :done => true}].to_json
end

get '/working_with_server_2' do
  erb :working_with_server_2
end

post '/tasks' do
  content_type :json
  puts params.inspect
  params.to_json
end

def file_content(file_name)
  file = File.open("views/#{file_name}", "rb")
  contents = file.read
  contents.encode('utf-8', 'iso-8859-1')
end