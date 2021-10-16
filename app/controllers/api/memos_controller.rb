class Api::MemosController < ApplicationController
    def index
        @memos = Memo.order(created_at: :DESC)
    end

    def create
        @memo = Memo.new(memo_params)
        # binding.pry
        if @memo.save
            render :index, status: :created
        else
            render json: @memo.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @memo = Memo.find(params[:id])
        if @memo.destroy
            render :index
        else 
            render json: @memo.errors, status: :unprocessable_entity
        end
    end

    private
        def memo_params
            # requireを設定すると送れなくなる
            params.permit(:title, :image)
        end
end
