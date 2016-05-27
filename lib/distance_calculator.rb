require 'json'

class DistanceCalculator
  EARTH_RADIUS_IN_KM = 6371.0
  RADIAN_DEGREE_RATIO = Math::PI / 180.0
  MAXIMUM_DISTANCE = 100

  attr_reader :origin_longitude, :origin_latitude

  def initialize(longitude, latitude)
    @origin_longitude = longitude
    @origin_latitude = latitude
  end

  def extract_customer_data(file_name)
    customer_data = []
    File.open(file_name, "r").each_line do |line|
      customer_data.push(JSON.parse(line))
    end
    return customer_data
  end

  def convert_to_radians(degrees)
    degrees = degrees.to_f unless degrees.is_a?(Float)
    degrees * RADIAN_DEGREE_RATIO
  end

  def calculate_distance_km(latitude, longitude)
    calculate_radial_distance(latitude, longitude) * EARTH_RADIUS_IN_KM
  end

  def calculate_radial_distance(latitude, longitude)
    lat_1 = convert_to_radians(origin_latitude)
    long_1 = convert_to_radians(origin_longitude)
    lat_2 = convert_to_radians(latitude)
    long_2 = convert_to_radians(longitude)
    long_diff = long_1 - long_2
    arctan_numerator = Math.sqrt((Math.cos(lat_2) * Math.sin(long_diff))**2 + (Math.cos(lat_1) * Math.sin(lat_2) - Math.sin(lat_1) * Math.cos(lat_2) * Math.cos(long_diff))**2)
    arctan_denominator = Math.sin(lat_1) * Math.sin(lat_2) + Math.cos(lat_1) * Math.cos(lat_2) * Math.cos(long_diff)

    radial_distance = Math.atan2(arctan_numerator, arctan_denominator)

    return radial_distance
  end

  def find_nearby_customers(file_name)
    customer_list = extract_customer_data(file_name)
    nearby_customers = customer_list.select {|customer| calculate_distance_km(customer["latitude"], customer["longitude"]) <= MAXIMUM_DISTANCE}.sort_by {|customer| customer["user_id"]}
  end

  def print_nearby_customers(file_name)
    customers = find_nearby_customers(file_name)
    customers.each {|customer| puts "Name: #{customer["name"]}, User Id: #{customer["user_id"]}"}
  end
end
