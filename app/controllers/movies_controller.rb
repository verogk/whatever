class MoviesController < ApplicationController
  def index
    @q = Movie.ransack(params[:q])
    @movies = @q.result(:distinct => true).includes(:directors, :castings, :boomarks, :users, :actors).page(params[:page]).per(10)

    render("movies/index.html.erb")
  end

  def show
    @boomark = Boomark.new
    @casting = Casting.new
    @director = Director.new
    @movie = Movie.find(params[:id])

    render("movies/show.html.erb")
  end

  def new
    @movie = Movie.new

    render("movies/new.html.erb")
  end

  def create
    @movie = Movie.new

    @movie.title = params[:title]
    @movie.duration = params[:duration]

    save_status = @movie.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/movies/new", "/create_movie"
        redirect_to("/movies")
      else
        redirect_back(:fallback_location => "/", :notice => "Movie created successfully.")
      end
    else
      render("movies/new.html.erb")
    end
  end

  def edit
    @movie = Movie.find(params[:id])

    render("movies/edit.html.erb")
  end

  def update
    @movie = Movie.find(params[:id])

    @movie.title = params[:title]
    @movie.duration = params[:duration]

    save_status = @movie.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/movies/#{@movie.id}/edit", "/update_movie"
        redirect_to("/movies/#{@movie.id}", :notice => "Movie updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Movie updated successfully.")
      end
    else
      render("movies/edit.html.erb")
    end
  end

  def destroy
    @movie = Movie.find(params[:id])

    @movie.destroy

    if URI(request.referer).path == "/movies/#{@movie.id}"
      redirect_to("/", :notice => "Movie deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Movie deleted.")
    end
  end
end
