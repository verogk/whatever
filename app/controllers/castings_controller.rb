class CastingsController < ApplicationController
  def index
    @castings = Casting.all

    render("castings/index.html.erb")
  end

  def show
    @casting = Casting.find(params[:id])

    render("castings/show.html.erb")
  end

  def new
    @casting = Casting.new

    render("castings/new.html.erb")
  end

  def create
    @casting = Casting.new

    @casting.movie_id = params[:movie_id]
    @casting.actor_id = params[:actor_id]

    save_status = @casting.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/castings/new", "/create_casting"
        redirect_to("/castings")
      else
        redirect_back(:fallback_location => "/", :notice => "Casting created successfully.")
      end
    else
      render("castings/new.html.erb")
    end
  end

  def edit
    @casting = Casting.find(params[:id])

    render("castings/edit.html.erb")
  end

  def update
    @casting = Casting.find(params[:id])

    @casting.movie_id = params[:movie_id]
    @casting.actor_id = params[:actor_id]

    save_status = @casting.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/castings/#{@casting.id}/edit", "/update_casting"
        redirect_to("/castings/#{@casting.id}", :notice => "Casting updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Casting updated successfully.")
      end
    else
      render("castings/edit.html.erb")
    end
  end

  def destroy
    @casting = Casting.find(params[:id])

    @casting.destroy

    if URI(request.referer).path == "/castings/#{@casting.id}"
      redirect_to("/", :notice => "Casting deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Casting deleted.")
    end
  end
end
