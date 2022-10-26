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

  test 'should create movie time' do
    movie = Movie.create(title: 'Matrix')
    assert_difference 'MovieTime.count' do
      post new_movie_time_url, params: { movie_time: {
        room: 5, date_start: Date.new(2022, 10, 10),
        date_end: Date.new(2022, 10, 12),
        time: 'TANDA', movie_id: movie.id
      } }
    end
  end

  test 'should not create movie time if room is empty' do
    movie = Movie.create(title: 'Matrix')
    assert_no_difference 'MovieTime.count' do
      post new_movie_time_url, params: { movie_time: {
        room: '', date_start: Date.new(2022, 10, 10),
        date_end: Date.new(2022, 10, 12),
        time: 'TANDA', movie_id: movie.id
      } }
    end
  end

  test 'should get movies list by date' do
    get movies_by_date_url, params: { date: Date.new(2022, 10, 10) }
    assert_response :success
  end
end
