# frozen_string_literal: true

require 'test_helper'

class ReservaTest < ActiveSupport::TestCase
  def setup
    movie = Movie.create(title: 'Movie')
    MovieTime.create(room: 5, date_start: Date.new(2022, 10, 10),
                     date_end: Date.new(2022, 10, 12),
                     time: 'TANDA', movie_id: movie.id)
  end

  def teardown
    Reserva.destroy_all
    MovieTime.destroy_all
    Movie.destroy_all
  end

  test 'Reserva creada con parametros validos' do
    reserva = Reserva.create(sala: 5, fecha: Date.new(2022, 10, 11), asiento: 10, horario: 'TANDA',
                             name: 'Pedro')
    assert_equal(true, reserva.valid?)
  end

  test 'Reserva creada con sala invalida' do
    reserva = Reserva.create(sala: 5000, fecha: Date.new(2022, 10, 11),
                             asiento: 10, horario: 'TANDA',
                             name: 'Pedro')
    assert_equal(false, reserva.valid?)
  end

  test 'Reserva creada con fecha invalida' do
    reserva = Reserva.create(sala: 5, fecha: 'marzo', asiento: 10, horario: 'TANDA',
                             name: 'Pedro')
    assert_equal(false, reserva.valid?)
  end

  test 'Reserva creada con asiento invalido' do
    reserva = Reserva.create(sala: 5, fecha: Date.new(2022, 10, 11), asiento: 500, horario: 'TANDA',
                             name: 'Pedro')
    assert_equal(false, reserva.valid?)
  end

  test 'Reserva creada con horario invalido' do
    reserva = Reserva.create(sala: 5, fecha: Date.new(2022, 10, 11), asiento: 10, horario: 'TANDA2',
                             name: 'Pedro')
    assert_equal(false, reserva.valid?)
  end

  test 'Reserva creada con nombre invalido' do
    reserva = Reserva.create(sala: 5, fecha: Date.new(2022, 10, 11), asiento: 10, horario: 'TANDA',
                             name: '')
    assert_equal(false, reserva.valid?)
  end
end
