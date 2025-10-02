class PostsController < ApplicationController

  require "json"
  require "open-uri"

  def get_new_posts_from_hn_api
    # je récupère les 10 derniers posts des tops stories de l'api HN
    url = "https://hacker-news.firebaseio.com/v0/newstories.json?print=pretty"
    posts_serialized = URI.parse(url).read
    posts = JSON.parse(posts_serialized).first(10)
    # je les crée en DB (j'ai mis un title uniqueness true pour que ca ne crée pas de doublons)
    create(posts)
  end

  def create(posts)
    posts.each do |post_id|
      hn_post_url = "https://hacker-news.firebaseio.com/v0/item/#{post_id}.json"
      post_serialized = URI.parse(hn_post_url).read
      post = JSON.parse(post_serialized)
      Post.create(title: post["title"], url: post["url"], post_type: post["type"], post_author: post["by"], score: post["score"])
    end
    redirect_to posts_path
  end
  
  def index
    @posts = Post.all
    @posts = Post.order(score: :desc)
  end

end
