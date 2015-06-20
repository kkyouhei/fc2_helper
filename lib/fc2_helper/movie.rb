# coding: utf-8

module Fc2Helper
  class Movie
    attr_accessor :title, :upid, :seconds, :limit_desc, :thumnail_url, :external_link_tag
    SRC = 'http://static.fc2.com/video/js/outerplayer.min.js'
    TK = 'TVRJM056WTNOamc9'
    SJ = '45000'
    D = '1494'
    W = '448'
    H = '310'
    CHARSET = 'UTF-8'
    LIMIT_FREE = "free"
    LIMIT_SAMPLE = "sample"
    LIMIT_MEMBER = "member"
    LIMIT_PRICE = "price"

    def external_link_tag
      external_link_tag = "<script src='#{SRC}' url='http://video.fc2.com/ja/a/content/%s/' tk='#{TK}' tl='%s' sj='#{SJ}' d='#{D}' w='#{W}' h='#{H}'  suggest='on' charset='#{CHARSET}'></script>"
      sprintf(external_link_tag, @upid, @title)
    end

    def limit_type
      result = case @limit_desc
      when "全員★" then LIMIT_FREE
      when "全員" then LIMIT_SAMPLE
      when "有料会員" then LIMIT_MEMBER
      else LIMIT_PRICE
      end
    end

  end
end
