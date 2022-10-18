class Product < ApplicationRecord
    validates :price, presence: true

    validate :is_valid_price
    validate :is_valid_category
    validate :comestible_has_weight
    validate :bebestible_has_volume

    def is_valid_price
        if price.nil? || price < 0 || price.class != Integer
            errors.add(:price, "must be a positive number")
        end
    end


    def is_valid_category
        if category != "Bebestible" and category != "Comestible" and category != "Souvenir"
            errors.add(:category, "no es una categoría válida")
            # print recieved value
        end 
    end

    def comestible_has_weight
        if category == "Comestible"
            if not weight.is_a? Numeric or not weight > 0
                errors.add(:weight, "debe tener peso mayor a 0 si es comestible")
            end
        end
    end

    def bebestible_has_volume
        if category == "Bebestible"
            if not volume.is_a? Numeric or not volume > 0
                errors.add(:volume, "debe tener volumen mayor a 0 si es bebestible")
            end
        end
    end

end
