# coding: utf-8

module Fc2Helper
  class Movies
    attr_reader :index
    attr_reader :movie_list

    def initialize
      @movie_list = Array.new
      @index = 0
    end

    def append_movie(movie)
      @movie_list.push(movie)
    end

    def next?
      @movie_list.length > @index
    end

    def next
      return nil unless next?
      @index += 1
      @movie_list[@index]
    end

  end

end
