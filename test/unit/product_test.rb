require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any? == true
    assert product.errors[:description].any? == true
    assert product.errors[:price].any? == true
    assert product.errors[:image_url].any? == true
  end
  
  test "product price must be positive" do
    product = Product.new(title: "My book title",
      description: "yyy",
      image_url: "zzz.jpg")
    product.price = -1
    assert product.invalid? == true
    assert_equal "must be greater than or equal to 0.01", product.errors[:price].join('; ')
    
    product.price = 0
    assert product.invalid? == true
    assert_equal "must be greater than or equal to 0.01", product.errors[:price].join('; ')
    
    product.price = 1
    assert product.valid?
  end
end
