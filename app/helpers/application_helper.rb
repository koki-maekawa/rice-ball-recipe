module ApplicationHelper
  def default_meta_tags
    {
      site: "おにぎりレシピ",
      title: "おにぎりレシピ専用検索サービス",
      reverse: true,
      charset: "utf-8",
      description: "おにぎりレシピを使えば、おにぎりレシピに特化して、自分の好きなおにぎりを検索できます。",
      keywords: "おにぎり、おむすび",
      canonical: request.original_url,
      separator: "|",
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: "website",
        url: request.original_url,
        image: image_url("onigiri.png"),
        local: "ja-JP"
      },
      # Twitter用の設定を個別で設定する
      twitter: {
        card: "summary_large_image",
        site: "@RiceBallRecipe",
        image: image_url("onigiri.png")
      }
    }
  end
end
