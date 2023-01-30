class UserMailer < ApplicationMailer
    def purchase_confirmation(user, order)
        @user = user
        @order = order
        mail(to: @user.email, subject: 'Your Purchase Confirmation')
      nd
end
