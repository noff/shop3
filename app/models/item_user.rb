class ItemUser < ActiveRecord::Base
  belongs_to :item
  belongs_to :user

  validates :item_id, :user_id, :quantity,
            presence: true,
            numericality: {
                only_integer: true,
                greater_than: 0
            }


  # Считает полную сумму содержимого корзины
  # @param user [User] Объект пользователя, для которого считаем корзину
  # @return Float
  def self.total_price(user)

    # Сумма, которую будем считать
    total = 0.0

    # Перебираем все записи из корзины и меняем сумму
    user.item_users.each do |item_user|
      total = total + item_user.full_price
    end

    # Вернуть результат
    total

  end

  # Считает стоимость текущей позиции в корзине - если товаров одного наименования больше 1
  def full_price
    quantity * item.price
  end



end
