# frozen_string_literal: true

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'Producto con precio negativo' do
    product = Product.create(price: -1, category: 'Comestible', weight: 1, volume: 1)
    assert_equal(false, product.valid?)
  end

  test 'Producto con peso negativo' do
    product = Product.create(price: 1, category: 'Comestible', weight: -1, volume: 1)
    assert_equal(false, product.valid?)
  end

  test 'Producto con volumen negativo' do
    product = Product.create(price: 1, category: 'Bebestible', weight: 1, volume: -1)
    assert_equal(false, product.valid?)
  end

  test 'Producto con categoría inexsitente' do
    product = Product.create(price: 1, category: 'Comestible2', weight: 1, volume: 1)
    assert_equal(false, product.valid?)
  end

  test 'Producto con parametros validos' do
    product = Product.create(price: 1, category: 'Comestible', weight: 1, volume: 1)
    assert_equal(true, product.valid?)
  end
end
