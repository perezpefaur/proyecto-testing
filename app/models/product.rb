# frozen_string_literal: true

class Product < ApplicationRecord
  validates :price, presence: true

  validate :is_valid_price
  validate :is_valid_category
  validate :comestible_has_weight
  validate :bebestible_has_volume

  def is_valid_price
    if price.nil? || price.negative? || price.class != Integer
      errors.add(:price, 'must be a positive number')
    end
  end

  def is_valid_category
    if (category != 'Bebestible') && (category != 'Comestible') && (category != 'Souvenir')
      errors.add(:category, 'no es una categoría válida')
      # print recieved value
    end
  end

  def comestible_has_weight
    if category == 'Comestible' && ((!weight.is_a? Numeric) || (weight <= 0))
      errors.add(:weight, 'debe tener peso mayor a 0 si es comestible')
    end
  end

  def bebestible_has_volume
    if category == 'Bebestible' && ((!volume.is_a? Numeric) || (volume <= 0))
      errors.add(:volume, 'debe tener volumen mayor a 0 si es bebestible')
    end
  end
end
