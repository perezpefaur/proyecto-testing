# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

describe 'Navigation', type: :feature do
  before(:each) do
    Room.create(number: 1)
    Room.create(number: 2)
    Room.create(number: 3)
    Room.create(number: 4)
    Room.create(number: 5)
    Room.create(number: 6)
    Room.create(number: 7)
    Room.create(number: 8)
    movieA = Movie.create(title: '+18 (es)', adult: true, language: 'SPANISH')
    movieB = Movie.create(title: '+18 (en)', adult: true, language: 'ENGLISH')
    movieC = Movie.create(title: '-18 (es)', adult: false, language: 'SPANISH')
    movieD = Movie.create(title: '-18 (en)', adult: false, language: 'ENGLISH')

    movie_timeAA = MovieTime.create(room: 1, date_start: Date.new(2022, 10, 10),
                                    date_end: Date.new(2022, 10, 12), time: 'TANDA', movie_id: movieA.id, location: 'SANTIAGO')
    movie_timeAB = MovieTime.create(room: 2, date_start: Date.new(2022, 10, 10),
                                    date_end: Date.new(2022, 10, 12), time: 'TANDA', movie_id: movieA.id, location: 'REGIONAL')

    movie_timeBA = MovieTime.create(room: 3, date_start: Date.new(2022, 10, 10),
                                    date_end: Date.new(2022, 10, 12), time: 'TANDA', movie_id: movieB.id, location: 'SANTIAGO')
    movie_timeBB = MovieTime.create(room: 4, date_start: Date.new(2022, 10, 10),
                                    date_end: Date.new(2022, 10, 12), time: 'TANDA', movie_id: movieB.id, location: 'REGIONAL')

    movie_timeCA = MovieTime.create(room: 5, date_start: Date.new(2022, 10, 10),
                                    date_end: Date.new(2022, 10, 12), time: 'TANDA', movie_id: movieC.id, location: 'SANTIAGO')
    movie_timeCB = MovieTime.create(room: 6, date_start: Date.new(2022, 10, 10),
                                    date_end: Date.new(2022, 10, 12), time: 'TANDA', movie_id: movieC.id, location: 'REGIONAL')

    movie_timeDA = MovieTime.create(room: 7, date_start: Date.new(2022, 10, 10),
                                    date_end: Date.new(2022, 10, 12), time: 'TANDA', movie_id: movieD.id, location: 'SANTIAGO')
    movie_timeDB = MovieTime.create(room: 8, date_start: Date.new(2022, 10, 10),
                                    date_end: Date.new(2022, 10, 12), time: 'TANDA', movie_id: movieD.id, location: 'REGIONAL')
  end
  scenario '>= 18 (V), Español (V), Santiago (V)' do
    visit '/'
    # show have input find_date
    expect(page).to have_selector('input#find_date')
    # fill input with id find_date
    fill_in 'find_date', with: '2022-10-10'
    # show have input check_adult
    expect(page).to have_selector('input#check_adult')
    # check input with id check_adult
    check 'check_adult'
    # show have select language
    expect(page).to have_selector('select#language')
    # select option with id language
    select 'SPANISH', from: 'language'
    # show have select location
    expect(page).to have_selector('select#location')
    # select option with id location
    select 'SANTIAGO', from: 'location'
    # should have search button
    expect(page).to have_selector('input#search')
    # click search button
    click_button 'search'
    # Should exist text +18 (es)
    expect(page).to have_content('+18 (es)')

    # Should exist text -18 (es)
    # expect(page).to have_content('-18 (es)')

    save_and_open_page
  end
end
