require 'compress'

describe Array do
  it 'returns an empty array when passed an empty array' do
    expect([].compress).to eq []
  end

  it 'returns original array if argument is already flattened array' do
    expect([1, 2, 3].compress).to eq [1, 2, 3]
  end

  it 'returns a single array for nested array' do
    expect([[1, 2, 3]].compress).to eq [1, 2, 3]
  end

  it 'compresses multiple levels of nested arrays' do
    expect([[[1, 2, 3]]].compress).to eq [1, 2, 3]
  end

  it 'compresses an array made of multiple kinds of elements' do
    expect([1, [2], [[3]], {"4" => "5"}, [:symbol], "string"].compress).to eq [1, 2, 3, {"4" => "5"}, :symbol, "string"]
  end
end
