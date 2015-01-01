# coding: utf-8
require 'fc2_helper/crawler'

module Fc2Helper
  class Client
    attr_reader :crawler

    def initialize
      @crawler = Crawler.new
    end

    def get_adult_ranking_weekly
      @crawler.get_adult_ranking_weekly
    end
    def get_adult_ranking_monthly
      @crawler.get_adult_ranking_monthly
    end
    def get_adult_ranking_yearly
      @crawler.get_adult_ranking_yearly
    end
    def get_adult_popular
      @crawler.get_adult_popular
    end
    def get_adult_new
      @crawler.get_adult_new
    end
    def get_adult_search(keyword)
      @crawler.get_adult_search(keyword)
    end
  end

end
