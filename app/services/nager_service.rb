class NagerService

  def conn 
    conn = Faraday.new(
    url: 'https://date.nager.at'
  )
  end

  def next_three_holidays
    response = conn.get('/Api/v2/NextPublicHolidays/us')
    json = JSON.parse(response.body, symbolize_names: true)

    ["#{json[0][:name]}, #{json[0][:date]}",
    "#{json[1][:name]}, #{json[1][:date]}",
    "#{json[2][:name]}, #{json[2][:date]}"]
  end
end