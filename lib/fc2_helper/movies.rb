# coding: utf-8

module Fc2Helper
  class Movies
    attr_reader :index
    @crawler

    after_initialize do
      @movies = {}
      @index = 0
    end

    def append_movie(movie)
      @movies << movie
    end

    def next?
      @movie.length > @index
    end

    def next
      @index += 1
      @movies[@index]
    end

  end

end
