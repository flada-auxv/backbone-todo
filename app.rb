require 'sinatra'

set :public_folder, File.join(File.dirname(__FILE__))

get '/' do
  send_file 'index.html'
end
