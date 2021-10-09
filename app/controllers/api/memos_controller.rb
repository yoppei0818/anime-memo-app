class Api::MemosController < ApplicationController
    def index
        @memos = Memo.order(created_at: :DESC)
    end

    def created
        @memo = Memo.new(memo_params)
        if @memo.save
            render :show, status: :created
        else
            render json: @memo.errors, status: :unprocessable_entity
        end
    end

    def private
        def memo_params
            params.permit(:title, :description)
        end
    end
end
