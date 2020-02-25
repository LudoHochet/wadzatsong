class GamesController < ApplicationController

  def create
    # @game = policy_scope(Game.find(params[:id]))
    @game = Game.new
    authorize @game
    @game.user = current_user
    @game.status = :created
    @game.save!
    redirect_to edit_game_path(@game)
  end

  def show
    @game = Game.last
    @answer = Answer.new
    @answers = @game.answers
  end

  def new
    @game = Game.new()
  end

  def edit
    @game = Game.find(params[:id])
    @playlists = Playlist.all
    authorize @game
  end

  def update
    @game = Game.find(params[:id])
    @game.playlist_id = params[:game][:playlist]
    @game.update(game_params)
    authorize @game
    redirect_to game_path(@game)
  end

  def show
    @game = Game.last
    @answer = Answer.new
    @playlist = @game.playlist
    @answers = @game.answers
    authorize @game
  end

  private

  def game_params
  params.require(:game).permit(:status, :playlist_id, :user_id)
  end
end
