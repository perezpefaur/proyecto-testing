# frozen_string_literal: true

require 'test_helper'

class MovieControllerTest < ActionDispatch::IntegrationTest
  def setup; end

  def teardown
    MovieTime.destroy_all
    Movie.destroy_all
  end

  test 'should get new' do
    get movie_new_url
    assert_response :success
  end

  test 'should create movie' do
    assert_difference 'Movie.count' do
      post movie_new_url, params: { title: 'Matrix' }
    end
  end

  test 'should not create movie if title is empty' do
    assert_no_difference 'Movie.count' do
      post movie_new_url, params: { title: '' }
    end
  end
end
