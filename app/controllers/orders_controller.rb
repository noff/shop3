class OrdersController < ApplicationController

  before_filter :authenticate_user!



  def index
    @orders = current_user.orders
  end


  def create

    # Если в корзине нет товаров, уходим на корзину. Конец программы.
    unless current_user.item_users.any?
      redirect_to root_path
    end

    # Создаем заказ
    order = Order.create! user_id: current_user.id,
                         price: ItemUser.total_price(current_user),
                         status: 'created'

    # Переносим товары в историю заказа
    current_user.item_users.each do |item_user|
      ItemOrder.create! quantity: item_user.quantity,
                        order_id: order.id,
                        price: item_user.item.price,
                        item_id: item_user.item_id
    end

    # Чистим корзину
    current_user.item_users.destroy_all

    # Отправляем письма админу и клиенту
    OrderMailer.order_created_for_user order
    OrderMailer.order_created_for_admin order

    # Переходим на просмотр заказа
    redirect_to order

  end


  def show
    @order = Order.find params[:id]
    if @order.user_id != current_user.id
      raise 'Order not found', code: 404
    end
  end


end
