class PostPurchase
  include Sidekiq::Job

  def perform(order)
    # Trigger a notification email to the user
    UserMailer.purchase_confirmation(user, order).deliver_later
  end
end
