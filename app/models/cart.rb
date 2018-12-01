class Cart < ApplicationRecord
    has_many :line_items, dependent: :destroy

    def add_product(product)
        current_item = line_items.find_by(product_id: product.id)
        if current_item
            current_item.quantity += 1
        else
            current_item = line_items.build(product_id: product.id)
        end
        current_item
    end

    def reduce_product(product)
        current_item = line_items.find_by(product_id: product.id)
        if current_item.quantity == 1
            current_item.destroy
            "destroyed"
        elsif current_item.quantity > 1
            current_item.quantity -= 1
            current_item 
        end
    end

    # We implement the Cart method using the nifty Array::sum method to sum the
    # prices of each item in the collection:
    def total_price
        line_items.to_a.sum { |item| item.total_price }
    end
end
