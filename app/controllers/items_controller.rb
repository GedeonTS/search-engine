class ItemsController < ApplicationController
    def index
        if params[:q]
           Record.create(name: params[:q], user_id: current_user.id)
        end
        search

        @records = Record.select("name, count(*) as count")
        .where(user_id: current_user.id)
        .group("name")
        .order("count DESC")
        .limit(10)
    end

    def show
       render json: { search: search}
    end

    def new
        @item = Item.new
    end

    def create
        @item = Item.new(item_params)
        if @item.save
          redirect_to items_path, notice: 'Item was successfully created.'
        else
          render :new
        end
    end

    def search
        query = params[:q]
        result=[]
        result = Rails.cache.fetch("search_result_#{query}", expires_in: 1.hour) do
        if query
            sentence = query.split(' ')

            sentence.each do |word|

               current_result = Item.where('name LIKE ? or description LIKE ?', "%" + word + "%", "%#{word}%")
               result = result + current_result
              end
        end    

        @items = result.uniq.reverse()
    end
end

def item_params
  params.require(:item).permit(:name, :number, :description)
end   


end