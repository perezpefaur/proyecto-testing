class AddLocationToMovieTimes < ActiveRecord::Migration[7.0]
  def change
    add_column :movie_times, :location, :string
  end
end
