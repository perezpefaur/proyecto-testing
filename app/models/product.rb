# frozen_string_literal: true

# Product model
class Product < ApplicationRecord
  validates :price, presence: true

  validate :valid_price?
  validate :valid_category?
  validate :comestible_has_weight
  validate :bebestible_has_volume

  def valid_price?
    return if (price.is_a? Numeric) && price.positive? && price.instance_of?(Integer)

    errors.add(:price, 'must be a positive number')
  end

  def valid_category?
    if (category != 'Bebestible') && (category != 'Comestible') && (category != 'Souvenir')
      # needs to be valid category
      errors.add(:category, 'no es una categoría válida')
    end
  end

  def comestible_has_weight
    return if category == 'Comestible' && ((weight.is_a? Numeric) && weight.positive?)

    errors.add(:weight, 'debe tener peso mayor a 0 si es comestible') if category == 'Comestible'
  end

  def bebestible_has_volume
    return if category == 'Bebestible' && ((volume.is_a? Numeric) && volume.positive?)

    errors.add(:volume, 'debe tener volumen mayor a 0 si es bebestible') if category == 'Bebestible'
  end
end
