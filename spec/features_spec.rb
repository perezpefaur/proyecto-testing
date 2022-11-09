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
    movie_a = Movie.create(title: '+18 (es)', adult: true, language: 'SPANISH')
    movie_b = Movie.create(title: '+18 (en)', adult: true, language: 'ENGLISH')
    movie_c = Movie.create(title: '-18 (es)', adult: false, language: 'SPANISH')
    movie_d = Movie.create(title: '-18 (en)', adult: false, language: 'ENGLISH')

    MovieTime.create(room: 1, date_start: Date.new(2022, 10, 10),
                     date_end: Date.new(2022, 10, 12), time: 'TANDA',
                     movie_id: movie_a.id, location: 'SANTIAGO')
    MovieTime.create(room: 2, date_start: Date.new(2022, 10, 10),
                     date_end: Date.new(2022, 10, 12), time: 'TANDA',
                     movie_id: movie_a.id, location: 'REGIONAL')

    MovieTime.create(room: 3, date_start: Date.new(2022, 10, 10),
                     date_end: Date.new(2022, 10, 12), time: 'TANDA',
                     movie_id: movie_b.id, location: 'SANTIAGO')
    MovieTime.create(room: 4, date_start: Date.new(2022, 10, 10),
                     date_end: Date.new(2022, 10, 12), time: 'TANDA',
                     movie_id: movie_b.id, location: 'REGIONAL')

    MovieTime.create(room: 5, date_start: Date.new(2022, 10, 10),
                     date_end: Date.new(2022, 10, 12), time: 'TANDA',
                     movie_id: movie_c.id, location: 'SANTIAGO')
    MovieTime.create(room: 6, date_start: Date.new(2022, 10, 10),
                     date_end: Date.new(2022, 10, 12), time: 'TANDA',
                     movie_id: movie_c.id, location: 'REGIONAL')

    MovieTime.create(room: 7, date_start: Date.new(2022, 10, 10),
                     date_end: Date.new(2022, 10, 12), time: 'TANDA',
                     movie_id: movie_d.id, location: 'SANTIAGO')
    MovieTime.create(room: 8, date_start: Date.new(2022, 10, 10),
                     date_end: Date.new(2022, 10, 12), time: 'TANDA',
                     movie_id: movie_d.id, location: 'REGIONAL')
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
    expect(page).to have_content('-18 (es)')
  end

  scenario '>= 18 (V), Español (V), Regional (F)' do
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
    select 'REGIONAL', from: 'location'
    # should have search button
    expect(page).to have_selector('input#search')
    # click search button
    click_button 'search'
    # Should exist text +18 (es)
    expect(page).to have_content('+18 (es)')

    # Should exist text -18 (es)
    expect(page).to have_content('-18 (es)')
  end

  scenario '>= 18 (V), English (F), Santiago (V)' do
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
    select 'ENGLISH', from: 'language'
    # show have select location
    expect(page).to have_selector('select#location')
    # select option with id location
    select 'SANTIAGO', from: 'location'
    # should have search button
    expect(page).to have_selector('input#search')
    # click search button
    click_button 'search'
    # Should exist text +18 (en)
    expect(page).to have_content('+18 (en)')

    # Should exist text -18 (es)
    expect(page).to have_content('-18 (en)')
  end

  scenario '>= 18 (V), English (F), Regional (F)' do
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
    select 'ENGLISH', from: 'language'
    # show have select location
    expect(page).to have_selector('select#location')
    # select option with id location
    select 'REGIONAL', from: 'location'
    # should have search button
    expect(page).to have_selector('input#search')
    # click search button
    click_button 'search'
    # Should exist text +18 (en)
    expect(page).to have_content('+18 (en)')

    # Should exist text -18 (es)
    expect(page).to have_content('-18 (en)')
  end

  scenario '< 18 (F), Español (V), Santiago (V)' do
    visit '/'
    # show have input find_date
    expect(page).to have_selector('input#find_date')
    # fill input with id find_date
    fill_in 'find_date', with: '2022-10-10'
    # show have input check_adult
    expect(page).to have_selector('input#check_adult')
    # check input with id check_adult
    uncheck 'check_adult'
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

    # Should exist text -18 (es)
    expect(page).to have_content('-18 (es)')
  end

  scenario '< 18 (F), Español (V), Regional (F)' do
    visit '/'
    # show have input find_date
    expect(page).to have_selector('input#find_date')
    # fill input with id find_date
    fill_in 'find_date', with: '2022-10-10'
    # show have input check_adult
    expect(page).to have_selector('input#check_adult')
    # check input with id check_adult
    uncheck 'check_adult'
    # show have select language
    expect(page).to have_selector('select#language')
    # select option with id language
    select 'SPANISH', from: 'language'
    # show have select location
    expect(page).to have_selector('select#location')
    # select option with id location
    select 'REGIONAL', from: 'location'
    # should have search button
    expect(page).to have_selector('input#search')
    # click search button
    click_button 'search'

    # Should exist text -18 (es)
    expect(page).to have_content('-18 (es)')
  end

  scenario '< 18 (F), English (F), Santiago (V)' do
    visit '/'
    # show have input find_date
    expect(page).to have_selector('input#find_date')
    # fill input with id find_date
    fill_in 'find_date', with: '2022-10-10'
    # show have input check_adult
    expect(page).to have_selector('input#check_adult')
    # check input with id check_adult
    uncheck 'check_adult'
    # show have select language
    expect(page).to have_selector('select#language')
    # select option with id language
    select 'ENGLISH', from: 'language'
    # show have select location
    expect(page).to have_selector('select#location')
    # select option with id location
    select 'SANTIAGO', from: 'location'
    # should have search button
    expect(page).to have_selector('input#search')
    # click search button
    click_button 'search'

    # Should exist text -18 (en)
    expect(page).to have_content('-18 (en)')
  end

  scenario '< 18 (F), English (F), Regional (F)' do
    visit '/'
    # show have input find_date
    expect(page).to have_selector('input#find_date')
    # fill input with id find_date
    fill_in 'find_date', with: '2022-10-10'
    # show have input check_adult
    expect(page).to have_selector('input#check_adult')
    # check input with id check_adult
    uncheck 'check_adult'
    # show have select language
    expect(page).to have_selector('select#language')
    # select option with id language
    select 'ENGLISH', from: 'language'
    # show have select location
    expect(page).to have_selector('select#location')
    # select option with id location
    select 'REGIONAL', from: 'location'
    # should have search button
    expect(page).to have_selector('input#search')
    # click search button
    click_button 'search'

    # Should exist text -18 (en)
    expect(page).to have_content('-18 (en)')
  end
end
