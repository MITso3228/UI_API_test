require 'httparty'
require 'json'
require 'date'

class API
  BASE_URL = 'https://petstore.swagger.io/v2'

  KEY_VALUE = "dGVzdF9hcGk="
  HEADERS = {
    'Content-Type' => 'application/json',
    'Name' => 'api_key',
    'In' => 'header',
    'Value' => Base64.decode64(KEY_VALUE)
  }
  PET_BODY = {
    :id => 0,
    :category => {
      :id => 0,
      :name => "string"
    },
    :name => "string",
    :photoUrls => [
      "string"
    ],
    :tags => [
      {
        :id => 0,
        :name => "string"
      }
    ],
    :status => "string"
  }

  def add_new_pet(pet_id, pet_name, status)
    body = PET_BODY
    body[:id] = pet_id
    body[:name] = pet_name
    body[:status] = status

    response = HTTParty.post(BASE_URL + "/pet",
                             :body => body.to_json,
                             :headers => HEADERS)
    if response.code != 200
      raise "Got #{response.code} during request. Body is #{response.body}"
    end
  end

  def get_pet_info(pet_id)
    response = HTTParty.get(BASE_URL + "/pet/#{pet_id}",
                            :headers => HEADERS)
  end

  def update_pet(pet_id, pet_name=nil, status=nil)
    pet_info = get_pet_info(pet_id)
    pet_name = JSON.parse(pet_info.body)[:name] if pet_name == nil
    status = JSON.parse(pet_info.body)[:status] if status == nil

    body = PET_BODY
    body[:id] = pet_id
    body[:name] = pet_name if pet_name != nil
    body[:status] = status if status != nil

    response = HTTParty.put(BASE_URL + "/pet",
                            :body => body.to_json,
                            :headers => HEADERS)
  end

  def place_an_order(order_id, pet_id, quantity, status, complete)
    body = {
      :id => order_id,
      :petId => pet_id,
      :quantity => quantity,
      :shipDate => (Date.today + 1).to_s,
      :status => status,
      :complete => complete
    }

    response = HTTParty.post(BASE_URL + "/store/order",
                             :body => body.to_json,
                             :headers => HEADERS)
  end

  def output_order(order_id)
    response = HTTParty.get(BASE_URL + "/store/order/#{order_id}",
                            :headers => HEADERS)

    puts "Your order is: #{response.body}"
    response.code
  end

  def delete_order(order_id)
    response = HTTParty.delete(BASE_URL + "/store/order/#{order_id}",
                               :headers => HEADERS)
    response.code
  end

  def delete_pet(pet_id)
    response = HTTParty.delete(BASE_URL + "/pet/#{pet_id}",
                               :headers => HEADERS)
    response.code
  end
end