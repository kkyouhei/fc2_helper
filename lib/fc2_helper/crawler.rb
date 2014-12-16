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

    after_initialize do
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
      @crawler_url = FC2_ADULT_RANKING_WEEKLY
      @page_index = index
      movie_data = get_html(sprintf(FC2_ADULT_RANKING_WEEKLY, index))
      parsed_movie_data(movie_data)
    end
    def get_adult_ranking_monthly(index=1)
      @crawler_url = FC2_ADULT_RANKING_MONTHLY
      @page_index = index
      movie_data = get_html(sprintf(FC2_ADULT_RANKING_MONTHLY, index))
      parsed_movie_data(movie_data)
    end
    def get_adult_ranking_yearly(index=1)
      @crawler_url = FC2_ADULT_RANKING_YEARLY
      @page_index = index
      movie_data = get_html(sprintf(FC2_ADULT_RANKING_YEARLY, index))
      parsed_movie_data(movie_data)
    end
    def get_adult_popular(index=1)
      @crawler_url = FC2_ADULT_POPULAR
      @page_index = index
      movie_data = get_html(sprintf(FC2_ADULT_POPULAR, index))
      parsed_movie_data(movie_data)
    end
    def get_adult_new(index=1)
      @crawler_url = FC2_ADULT_NEW
      @page_index = index
      movie_data = get_html(sprintf(FC2_ADULT_NEW, index))
      parsed_movie_data(movie_data)
    end
    def get_adult_search(keyword, index=1)
      @crawler_url = sprintf(FC2_ADULT_SEARCH, keyword)
      @page_index = index
      movie_data = get_html(sprintf(FC2_ADULT_SEARCH, keyword, index))
      parsed_movie_data(movie_data)
    end

  private
    def get_html(url)
      begin
        return Nokogiri.HTML(open(url).read)
      rescue Excaption => e
        raise e
      end
    end

    def parsed_movie_data(html)
      movies = Movies.new
      html.xpath('//div[@class="video_list_renew_thumb"]').each do |post|
        begin
          post.search('div[@class="video_thumb_small clsThumbToAlbum"]').each do |div|
            movie = Movie.new

            movie.upid = div.attribute("upid").value
            movie.title = div.children.children.attribute('title').value

            time = div.children.attribute('data-duration').value.sprit(":")
            seconds = time[1].to_i + time[0].to_i * 60
            movie.seconds = seconds

            movies.append_movie(movie)
          end
        rescue Excaption => e
          raise e
        end
      end
      return movies
    end
  end
end
