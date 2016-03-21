require 'spherical_distance_calculator'

describe SphericalDistanceCalculator do
  let(:calculator){SphericalDistanceCalculator.new}

  it "#extract_customer_data returns an array of data" do
    customer_data = calculator.extract_customer_data("test_examples.txt")
    expect(customer_data.is_a?(Array)).to be true
  end

  it "#extract_customer_data opens a file and extracts customer data" do
    sample_data = {"latitude" => "53.3333", "user_id" => 3, "name" => "Customer 1", "longitude" => "-6.267"}
    customer_data = calculator.extract_customer_data("test_examples.txt")
    expect(customer_data.first).to eq sample_data
  end

  it "#convert_to_radians converts degrees to radians" do
    expect(calculator.convert_to_radians(0)).to eq 0
    expect(calculator.convert_to_radians(180)).to eq Math::PI
  end

  it "#convert_to_radians converts strings to integers before conversion" do
    expect(calculator.convert_to_radians("180")).to eq Math::PI
  end

  it "#calculate_radial_distance returns float value" do
    expect(calculator.calculate_radial_distance(0,0).is_a?(Float)).to be true
  end

  it "#calculate_radial_distance finds distance in terms of earth's radius from Intercom" do
    expect(calculator.calculate_radial_distance(0,0).round(3)).to eq 0.935
  end

  it "#calculate_radial_distance returns 0 for Intercom's coordinates" do
    expect(calculator.calculate_radial_distance(53.3381985, -6.2592576)).to eq 0
  end

  it "#calculate_distance_km returns 0 for Intercom's coordinates" do
    expect(calculator.calculate_distance_km(53.3381985, -6.2592576)).to eq 0
  end

  it "#calculate_distance_km finds the distance in km between coordinates and Intercom" do
    expect(calculator.calculate_distance_km(0, 0).ceil).to eq 5960
  end

  it "#find_nearby_customers selects customers within 100km" do
    customers = calculator.find_nearby_customers("test_examples.txt")
    expect(customers.length).to eq 2
    expect(customers.first["user_id"]).to eq 1
  end

  it "#print_nearby_customers outputs names and user ids of nearby users" do
    expect{ calculator.print_nearby_customers("test_examples.txt")}.to output("Name: Customer 2, User Id: 1\nName: Customer 1, User Id: 3\n").to_stdout
  end
end
