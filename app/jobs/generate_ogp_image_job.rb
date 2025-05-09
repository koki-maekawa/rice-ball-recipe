class GenerateOgpImageJob < ApplicationJob
  queue_as :default

  def perform(rice_ball)
    ogp_image_url = OgpCreator.build(rice_ball.id, rice_ball.title, rice_ball.image)
    rice_ball.update(ogp_image: ogp_image_url)
  rescue => e
    Rails.logger.error(e.message)
  end
end
