### 画面遷移図

[画面遷移図_Figma](https://www.figma.com/design/2DjWGvdNMZWW88edgnAJVA/%E3%81%8A%E3%81%AB%E3%81%8E%E3%82%8A?node-id=1649-344&t=NnjAS9viIXaeWkFP-1)


### ER図

```mermaid
erDiagram
  USERS ||--o{ RICE_BALLS : has
  USERS ||--o{ BOOKMARKS : has
  RICE_BALLS ||--o{ INGREDIENTS : has
  RICE_BALLS ||--o{ STEPS : has
  RICE_BALLS ||--o{ BOOKMARKS : has
  ACTIVE_STORAGE_BLOBS ||--o{ ACTIVE_STORAGE_ATTACHMENTS : has
  ACTIVE_STORAGE_BLOBS ||--o{ ACTIVE_STORAGE_VARIANT_RECORDS : has

  USERS {
    string email
    string encrypted_password
    string name
    boolean policies_agreed
  }

  RICE_BALLS {
    string title
    text description
  }

  INGREDIENTS {
    string name
    string amount
  }

  STEPS {
    text description
    int step_number
  }

  BOOKMARKS {
    datetime created_at
  }

  ACTIVE_STORAGE_ATTACHMENTS {
    string name
    string record_type
  }

  ACTIVE_STORAGE_BLOBS {
    string key
    string filename
    string content_type
  }

  ACTIVE_STORAGE_VARIANT_RECORDS {
    string variation_digest
  }
```

### サービス概要

「いつものおにぎり」にひと工夫を加え、より楽しくおにぎり作りをサポートすることを目的とした、おにぎり特化型のレシピ投稿アプリです。写真・材料・作り方をシンプルかつ分かりやすく記録・共有できる機能を備えており、ご自身の定番レシピや思い出のおにぎりを気軽に投稿いただけます。

### 想定されるユーザー層

本サービスの主なユーザー層は、おにぎりを日常的に作る親御様や、一人暮らしを始めたばかりの方を想定しております。親御様にとっては、子どもが飽きずに食べられる工夫を施したおにぎりのアイデアを探し、記録・共有するための便利なツールとなります。また、一人暮らしの方にとっては、手軽な自炊の第一歩として活用できる実用的なレシピ共有サービスとなっております。

### サービス利用のイメージ

写真や材料、作り方を簡潔に記録・共有する機能により、自分だけのレシピを手軽に保存できるほか、他のユーザーの投稿から幅広いアイデアを得ることが可能です。定番のおにぎりからちょっとした工夫を凝らしたアレンジまで、多彩なレシピが閲覧できるため、ユーザーのレシピの幅が広がります。

### サービスの差別化ポイント

おにぎりに特化した専門性です。本サービスは「おにぎり」に特化したレシピ共有サービスであり、一般的な料理レシピサイトとは異なり、おにぎりに関する情報を集約しております。これにより、ユーザーのおにぎりに関するニーズに的確に応えるコンテンツを利用できます。
