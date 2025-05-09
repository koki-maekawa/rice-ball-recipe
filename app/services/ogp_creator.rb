require "ruby-vips"

class OgpCreator
  BASE_IMAGE_PATH = Rails.root.join("app/assets/images/onigiri_OGP.jpg").to_s
  DEFAULT_IMAGE_PATH = Rails.root.join("app/assets/images/onigiri.png").to_s
  FONT_SIZE = 65
  INDENTION_COUNT = 8
  ROW_LIMIT = 2
  OGP_WIDTH = 1200
  OGP_HEIGHT = 630
  POST_IMAGE_WIDTH = 600
  POST_IMAGE_HEIGHT = 630

  def self.build(id, text, user_image_blob)
    # 背景画像を読み込み
    base_image = Vips::Image.new_from_file(BASE_IMAGE_PATH)

    # テキスト整形して、テキスト画像を生成
    prepare_text = prepare_text(text)
    text_image = generate_text_image(prepare_text)

    # テキストを背景画像に合成（右側に配置）
    with_text_image = base_image.composite(
      text_image,
      :over,
      x: (OGP_WIDTH / 2) + (POST_IMAGE_WIDTH / 2) - (text_image.width / 2),
      y: OGP_HEIGHT / 2
    )

    # 投稿画像をリサイズ
    resized_user_image = Vips::Image.thumbnail_buffer(
      user_image_blob.attached? ? user_image_blob.download : File.read(DEFAULT_IMAGE_PATH),
      POST_IMAGE_WIDTH,
      height: POST_IMAGE_HEIGHT,
      crop: :centre
     )

    # 投稿画像を背景画像に合成（左側に配置）
    final_image = with_text_image.composite(
      resized_user_image,
      :over,
    )

    # 保存
    output_path = Rails.root.join("tmp", "#{id}.jpg")
    final_image.write_to_file(output_path.to_s)

    output_path
  end

  private

  def self.prepare_text(text)
    text.to_s.scan(/.{1,#{INDENTION_COUNT}}/)[0...ROW_LIMIT].join("\n")
  end

  def self.generate_text_image(text)
    Vips::Image.text(
      text,
      font: "IPAゴシック #{FONT_SIZE}",
      rgba: true,
      dpi: 72
    )
  end
end
