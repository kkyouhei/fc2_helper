# coding: utf-8
module Env
  FC2_URL = "http://video.fc2.com"
  FC2_ADULT_URL = "#{FC2_URL}/a/"
  FC2_ADULT_RANKING_WEEKLY = "#{FC2_ADULT_URL}list.php?m=cont&type=1&page=%s"
  FC2_ADULT_RANKING_MONTHLY = "#{FC2_ADULT_URL}list.php?m=cont&type=2&page=%s"
  FC2_ADULT_RANKING_YEARLY = "#{FC2_ADULT_URL}list.php?m=cont&type=3%page=%s"
  FC2_ADULT_POPULAR = "#{FC2_ADULT_URL}recentpopular.php?page=%s"
  FC2_ADULT_NEW = "#{FC2_ADULT_URL}list_scont?page=%s"
  FC2_ADULT_SEARCH = "#{FC2_ADULT_URL}movie_search.php?perpage=50&page=%s&"
end
