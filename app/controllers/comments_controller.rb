class CommentsController < ApplicationController



  def create

    @comment = Comment.new(comment_params)

    if verify_recaptcha

      if @comment.save

        # Объявляем хранилище оценок
        all_scores = []

        # Находим все оценки
        @comment.item.comments.each do |c|
          if c.rating
            all_scores << c.rating
          end
        end

        # Если оценки есть
        if all_scores.any?

          # Считаем среднее арифметическое
          avg = all_scores.sum.to_f / all_scores.length

          # Сохраняем их к товару
          @comment.item.update_attribute :rating, avg

        end

        redirect_to @comment.item, notice: 'Comment was successfully created.'
      else
        redirect_to @comment.item, alert: @comment.errors.messages
      end

    else
      redirect_to :back, alert: 'Wrong captcha, motherfucker'
    end


  end



  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params[:comment].permit(:name, :item_id, :message, :rating)
    end
end
