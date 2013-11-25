class OrderMailer < ActionMailer::Base

  default from: "noreply@young-gorge-6562.herokuapp.com"

  def order_created_for_user(order)
    @order = order
    mail(to: order.user.email, subject: 'Оформлен заказ').deliver
  end


  def order_created_for_admin(order)
    @order = order
    mail(to: 'kechinoff@gmail.com,sam@mkechinov.ru', subject: 'Оформлен новый заказ').deliver
  end

end