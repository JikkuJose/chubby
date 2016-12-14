require 'unirest'
require_relative 'constants.rb'

module Chubby
  class PriceChanges
    def initialize(item_id:)
      @item_id = item_id
    end

    def average
      @average ||= data
        .map { |d| d["Price"] }.reduce(:+) / data.length
    end

    def sorted_by_price
      @sorted_by_price ||= data
        .sort { |l, r| l["Price"] <=> r["Price"] }
    end

    def maximum
      sorted_by_price
        .last
    end

    def minimum
      sorted_by_price
        .first
    end

    def download
      Unirest
        .get(url)
        .body
    end

    def data
      @data ||= download
    end

    def url
      URL[:price_changes] + @item_id
    end
  end
end
