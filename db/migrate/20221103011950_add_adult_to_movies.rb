class AddAdultToMovies < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :adult, :boolean
  end
end
