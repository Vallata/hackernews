class VotesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @vote = Vote.new(post_id: @post.id, user: current_user)
    if @vote.save
      @post.increment!(:score)
      redirect_to posts_path, notice: "Your vote was successfully recorded."
    else
      redirect_to posts_path, alert: "There was an error recording your vote."
    end
  end
end
