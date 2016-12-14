require 'uri'
require 'unirest'
require_relative './constants.rb'

module Chubby
  class ItemInfo
    def initialize(item_id:)
      @item_id = item_id
      @parameters = {
        itemId: @item_id
      }
    end

    def data
      @data ||= download
    end

    def image_url
      data["it"]["imageURL"]
    end

    def vendor
      data["it"]["vendor"]
    end

    def title
      data["it"]["title"]
    end

    def url
      URI
        .unescape(data["it"]["url"])
        .gsub(/^\/red.*?\=/, '')
    end

    def download
      Unirest
        .post(URL[:item_info], parameters: @parameters)
        .body
    end
  end
end
