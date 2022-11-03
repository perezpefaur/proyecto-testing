# frozen_string_literal: true

require 'test_helper'

class MovieTest < ActiveSupport::TestCase
  def teardown
    Movie.destroy_all
  end

  test 'Movie con parametros validos' do
    movie = Movie.create(title: 'Matrix', adult: true, language: "SPANISH")
    assert_equal(true, movie.valid?)
  end

  test 'Movie con título inválido' do
    movie = Movie.create(title: 'a' * 129)
    assert_equal(false, movie.valid?)
  end
end
