# frozen_string_literal: true

require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
  end

  test 'should get new' do
    get new_product_url
    assert_response :success
  end

  test 'should create product' do
    assert_difference('Product.count') do
      post products_url,
           params: { product: { category: 'Bebestible', price: '10',
                                volume: '10', weight: '10' } }
    end

    assert_redirected_to product_url(Product.last)
  end

  test 'should show product' do
    get product_url(@product)
    assert_response :success
  end

  test 'should get edit' do
    get edit_product_url(@product)
    assert_response :success
  end

  test 'should update product' do
    patch product_url(@product),
          params: { product: { category: 'Comestible', price: '100',
                               volume: '100', weight: '109' } }
    assert_redirected_to product_url(@product)
  end

  test 'should destroy product' do
    assert_difference('Product.count', -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end

  test 'should get index' do
    get products_url
    assert_response :success
  end

  test 'should filter by category' do
    get products_url, params: { select_category: 'Bebestible' }
    assert_response :success
  end

  test 'should filter by category showing all products' do
    get products_url, params: { select_category: 'All' }
    assert_response :success
  end

  test 'should fail to create product' do
    assert_difference('Product.count', 0) do
      post products_url,
           params: { product: { category: 'Bebestible', price: '10',
                                volume: '', weight: '10' } }
    end
  end

  test 'should fail to update product' do
    assert_difference('Product.count', 0) do
      patch product_url(@product),
            params: { product: { category: 'Comestible', price: '100',
                                 volume: '100', weight: '' } }
    end
  end
end
