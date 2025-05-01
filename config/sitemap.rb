# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://rice-ball-recipe.com"

SitemapGenerator::Sitemap.create do
  add root_path, priority: 1.0
  add rice_balls_path, priority: 1.0

  RiceBall.find_each do |rice_ball|
    add rice_ball_path(rice_ball),
        lastmod: rice_ball.updated_at,
        priority: 0.5
  end

  User.find_each do |user|
    add user_path(user),
        lastmod: user.updated_at,
        priority: 0.5

    add created_index_user_path(user),
        lastmod: user.updated_at,
        priority: 0.5

    add bookmarked_index_user_path(user),
        lastmod: user.updated_at,
        priority: 0.3
  end

  add new_user_registration_path, priority: 0.4
  add new_user_session_path, priority: 0.2

  add "https://kiyac.app/termsOfService/irLBMVrx7DpxxxTkrJTj",
      priority: 0.3

  add "https://kiyac.app/privacypolicy/EUhTMocT4INUTEElzvoq",
      priority: 0.3
end
