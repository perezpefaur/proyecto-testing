# frozen_string_literal: true

require 'test_helper'

class ReservasControllerTest < ActionDispatch::IntegrationTest
  def setup
    movie = Movie.create(title: 'Matrix', adult: true, language: 'SPANISH')
    MovieTime.create(room: 5, date_start: Date.new(2000, 11, 10),
                     date_end: Date.new(2000, 11, 12), time: 'TANDA',
                     movie_id: movie.id, location: 'SANTIAGO')
  end

  def teardown
    Reserva.destroy_all
    MovieTime.destroy_all
    Movie.destroy_all
  end

  test 'Posting a new reserva' do
    assert_difference 'Reserva.count' do
      post new_reserva_url(5, '2000-11-12', 'TANDA'),
           params: { reservation_seats: 'C-3', name: 'Diego' }
    end
  end

  test 'Should get new' do
    get new_reserva_url(5, '2000-11-12', 'TANDA')
    assert_response :success
  end

  test 'Should not get new if name is empty' do
    assert_no_difference 'Reserva.count' do
      post new_reserva_url(5, '2000-11-12', 'TANDA'),
           params: { reservation_seats: 'C-3', name: '' }
    end
  end

  test 'Should not get new if seat is full' do
    Reserva.create(sala: 5, fecha: Date.new(2000, 11, 12), asiento: 3,
                   horario: 'TANDA', name: 'Diego')
    assert_no_difference 'Reserva.count' do
      post new_reserva_url(5, '2000-11-12', 'TANDA'),
           params: { reservation_seats: 'A-3', name: 'Diego' }
    end
  end

  test 'Should not get new if seat is empty' do
    assert_no_difference 'Reserva.count' do
      post new_reserva_url(5, '2000-11-12', 'TANDA'),
           params: { reservation_seats: '', name: 'Diego' }
    end
  end

  test 'get_asiento_value(item) should return the correct value' do
    assert_equal 34, get_asiento_value('C-10')
  end
end
