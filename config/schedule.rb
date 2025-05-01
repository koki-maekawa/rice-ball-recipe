# 環境を指定
set :environment, "production"

# job_type をカスタマイズして bundle exec を使用
job_type :rake, "cd :path && bundle exec rake :task --silent :output"

# 例：毎日深夜にサイトマップを生成するジョブを追加
every 1.day, at: "12:00 am" do
  rake "sitemap:refresh"
end
