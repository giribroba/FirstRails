User.delete_all

require 'uri'
require 'net/http'

private
  def get_avatar(name)
    search = 'skyrim+' + name.split[0]
    result = JSON.parse(Net::HTTP.get(URI.parse('https://serpapi.com/search.json?q=' + search +'&tbm=isch&ijn=0&api_key=' + Rails.application.credentials.dig(:serpapi_key))))
    
    if result['error'].nil?
      return result['images_results'][0]['thumbnail']
    else
      return 'Error: '+result['error']
    end
    
  end


  5.times do |i|
    name = Faker::Games::ElderScrolls.name

    User.create!(
      name: name, 
      age: rand(15..50),
      avatar: get_avatar(name)
    )
  end 