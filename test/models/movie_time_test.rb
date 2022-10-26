# frozen_string_literal: true

require 'test_helper'

class MovieTimeTest < ActiveSupport::TestCase
  test 'MovieTime con fechas invalidas' do
    movie = Movie.create(title: 'Matrixx')
    movie_time = MovieTime.create(date_start: '2020-01-01', date_end: '2019-01-01',
                                  time: 'MATINÉ', room: 1, movie_id: movie.id)
    assert_equal(false, movie_time.valid?)
  end

  test 'Movietime con sala ocupada' do
    movie = Movie.create(title: 'Matrix')
    MovieTime.create(date_start: '2020-01-01', date_end: '2020-01-02',
                     time: 'MATINÉ', room: 1, movie_id: movie.id)
    movie_time2 = MovieTime.create(date_start: '2020-01-01', date_end: '2020-01-02',
                                   time: 'MATINÉ', room: 1, movie_id: movie.id)
    assert_equal(false, movie_time2.valid?)
  end

  test 'Movietime con time inválido' do
    movie = Movie.create(title: 'Matrix')
    movie_time = MovieTime.create(date_start: '2020-01-01', date_end: '2020-01-02',
                                  time: 'MATINÉ2', room: 1, movie_id: movie.id)
    assert_equal(false, movie_time.valid?)
  end

  test 'Movietime con movie_id inexistente' do
    movie_time = MovieTime.create(date_start: '2020-01-01', date_end: '2020-01-02',
                                  time: 'MATINÉ', room: 1, movie_id: 999)
    assert_equal(false, movie_time.valid?)
  end

  test 'Movietime con room inválida' do
    movie = Movie.create(title: 'Matrix')
    movie_time = MovieTime.create(date_start: '2020-01-01', date_end: '2020-01-02',
                                  time: 'MATINÉ', room: 0, movie_id: movie.id)
    assert_equal(false, movie_time.valid?)
  end
end
