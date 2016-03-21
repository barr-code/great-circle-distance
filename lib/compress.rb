class Array
  def compress(compressed_array = [])
    self.each { |element| element.is_a?(Array) ? element.compress(compressed_array) : compressed_array << element }
    return compressed_array
  end
end
