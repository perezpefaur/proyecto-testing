# frozen_string_literal: true

# Controler that manages all actions related to movie creation, room assignment and movie schedule
class MovieController < ApplicationController
  def home; end

  def new
    @movie_times = MovieTime.new
  end

  def post
    title = params[:title]
    image = params[:image]
    adult = params[:adult]
    language = params[:language]
    @movie = Movie.new(title:, image:, adult:, language:)
    if @movie.save
      redirect_to '/movie/new', notice: 'Pelicula creada con exito'
    else
      redirect_to '/movie/new', notice: @movie.errors.messages
    end
  end

  def create_movie_time
    movie_time_params = params.require(:movie_time).permit(:movie_id, :time, :date_start,
                                                           :date_end, :room, :location)
    Rails.logger.debug(movie_time_params)
    movie_time = MovieTime.create(movie_time_params)
    if movie_time.persisted?
      redirect_to '/movie/new', notice: 'Pelicula asignada con exito'
    else
      redirect_to '/movie/new', notice: movie_time.errors.messages
    end
  end

  def list_by_date
    @date = params[:date]
    @adult = params[:adult]
    @language = params[:language]
    @location = params[:location]
    # filter movies by adult and language
    Rails.logger.debug("SDBHFJBAHDSKAJSK\n\n")
    Rails.logger.debug(@adult)
    @movies = if @adult == '0'
                Movie.where(adult: @adult, language: @language)
              else
                Movie.where(language: @language)
              end

    @filter = @movies.includes(:movie_times).where(['movie_times.date_start <= ? and
                                                   ? <= movie_times.date_end
                                                   and movie_times.location = ?',
                                                    @date, @date, @location])
                     .references(:movie_times)
  end
end
