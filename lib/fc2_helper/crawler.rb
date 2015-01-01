# coding: utf-8
require 'fc2_helper/env'
require 'fc2_helper/movies'
require 'fc2_helper/movie'
require 'open-uri'
require 'nokogiri'

module Fc2Helper
  class Crawler
    attr_reader :crawler_url
    attr_reader :page_index
    attr_reader :page_max
    attr_reader :movies

    def initialize
      @page_index = 1
      @page_max = 1
      @movies = {}
    end

    def next_page?
      @page_max > @page_index
    end

    def get_next_page
      @page_index += 1
      movie_data = next_page? ? get_html(sprintf(@crawler_url, @index)) : nil
      parsed_movie_data(movie_data)
    end

    def get_adult_ranking_weekly(index=1)
      @crawler_url = Env::FC2_ADULT_RANKING_WEEKLY
      @page_index = index
      movie_data = get_html(sprintf(Env::FC2_ADULT_RANKING_WEEKLY, index))
      parsed_movie_data(movie_data)
    end
    def get_adult_ranking_monthly(index=1)
      @crawler_url = Env::FC2_ADULT_RANKING_MONTHLY
      @page_index = index
      movie_data = get_html(sprintf(Env::FC2_ADULT_RANKING_MONTHLY, index))
      parsed_movie_data(movie_data)
    end
    def get_adult_ranking_yearly(index=1)
      @crawler_url = Env::FC2_ADULT_RANKING_YEARLY
      @page_index = index
      movie_data = get_html(sprintf(Env::FC2_ADULT_RANKING_YEARLY, index))
      parsed_movie_data(movie_data)
    end
    def get_adult_popular(index=1)
      @crawler_url = Env::FC2_ADULT_POPULAR
      @page_index = index
      movie_data = get_html(sprintf(Env::FC2_ADULT_POPULAR, index))
      parsed_movie_data(movie_data)
    end
    def get_adult_new(index=1)
      @crawler_url = Env::FC2_ADULT_NEW
      @page_index = index
      movie_data = get_html(sprintf(Env::FC2_ADULT_NEW, index))
      parsed_movie_data(movie_data)
    end
    def get_adult_search(keyword, index=1)
      @crawler_url = sprintf(Env::FC2_ADULT_SEARCH, keyword)
      @page_index = index
      movie_data = get_html(sprintf(Env::FC2_ADULT_SEARCH, keyword, index))
      parsed_movie_data(movie_data)
    end

  private
    def get_html(url)
      begin
        return Nokogiri.HTML(open(url).read)
      rescue Exception => e
        raise e
      end
    end

    def parsed_movie_data(html)
      movies = Movies.new
      html.xpath('//div[@id="main"]').each do |post|
        begin
          post.search('div[@class="video_thumb_small clsThumbToAlbum"]').each do |div|
            movie = Movie.new
            movie.upid = div.attribute("upid").value
            movie.title = div.children.attribute('title').value

            time = div.attribute('data-duration').value.split(":")
            seconds = time[1].to_i + time[0].to_i * 60
            movie.seconds = seconds

            movies.append_movie(movie)
          end
        rescue Exception => e
          raise e
        end
      end
      return movies
    end
  end
end
