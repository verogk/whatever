class BoomarksController < ApplicationController
  def index
    @boomarks = Boomark.all

    render("boomarks/index.html.erb")
  end

  def show
    @boomark = Boomark.find(params[:id])

    render("boomarks/show.html.erb")
  end

  def new
    @boomark = Boomark.new

    render("boomarks/new.html.erb")
  end

  def create
    @boomark = Boomark.new

    @boomark.movie_id = params[:movie_id]
    @boomark.user_id = params[:user_id]

    save_status = @boomark.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/boomarks/new", "/create_boomark"
        redirect_to("/boomarks")
      else
        redirect_back(:fallback_location => "/", :notice => "Boomark created successfully.")
      end
    else
      render("boomarks/new.html.erb")
    end
  end

  def edit
    @boomark = Boomark.find(params[:id])

    render("boomarks/edit.html.erb")
  end

  def update
    @boomark = Boomark.find(params[:id])

    @boomark.movie_id = params[:movie_id]
    @boomark.user_id = params[:user_id]

    save_status = @boomark.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/boomarks/#{@boomark.id}/edit", "/update_boomark"
        redirect_to("/boomarks/#{@boomark.id}", :notice => "Boomark updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Boomark updated successfully.")
      end
    else
      render("boomarks/edit.html.erb")
    end
  end

  def destroy
    @boomark = Boomark.find(params[:id])

    @boomark.destroy

    if URI(request.referer).path == "/boomarks/#{@boomark.id}"
      redirect_to("/", :notice => "Boomark deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Boomark deleted.")
    end
  end
end
