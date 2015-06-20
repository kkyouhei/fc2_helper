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
      @page_index = index
      @crawler_url = "#{Env::FC2_ADULT_SEARCH}keyword=\"#{keyword}\""
      movie_data = get_html(sprintf(@crawler_url, index))
      parsed_movie_data(movie_data)
    end

  private
    def get_html(url)
      begin
        return Nokogiri.HTML(open(URI.escape(url)).read)
      rescue Exception => e
        raise e
      end
    end

    def parsed_movie_data(html)
      movies = Movies.new
      html.xpath('//div[@id="video_list_1column"]').each do |post|
        begin
          post.search('div[@class="video_list_renew clearfix"]').each do |elem|
            thumb_div = elem.search('div[@class="video_thumb_small clsThumbToAlbum"]')

            movie = Movie.new
            # movie upid
            movie.upid = thumb_div.attribute("upid").value
            # movie title
            movie.title = thumb_div.children.attribute('title').value
            # movie view limit desc
            movie.limit_desc = elem.css('li.member_icon').inner_text.to_s
            # movie thumnail url
            movie.thumnail_url = thumb_div.children.children.attribute('src').value
            # movie time
            time = elem.search('span[@class="video_time_renew"]').text.to_s.split(":")
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
