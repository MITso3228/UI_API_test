require_relative 'spec_helper'
require_relative '../pages/api'

describe 'API - ' do
  let(:api) { API.new }

  it 'Add new pet, Update pet, Place an order for a pet, Output purchase order, Delete purchase, Delete pet', :smoke do
    pet_name = "Dog Casie"
    status = "available"
    pet_id = "4"

    api.add_new_pet(pet_id, pet_name, status)

    new_pet_name = "Cat Maggy"

    api.update_pet(pet_id, new_pet_name)

    order_id = 1

    api.place_an_order(order_id, pet_id, 1, "placed", true)

    api.output_order(order_id)

    api.delete_order(order_id)
    expect(api.delete_order(order_id)).to eq(404)

    api.delete_pet(pet_id)
    expect(api.delete_pet(pet_id)).to eq(404)
  end
end